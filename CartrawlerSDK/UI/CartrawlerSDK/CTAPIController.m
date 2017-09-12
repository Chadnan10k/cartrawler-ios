//
//  CTAPIController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/18/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAPIController.h"
#import "CartrawlerAPI.h"
#import "CTAppController.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CartrawlerSDK+NSNumber.h"

@implementation CTAPIController

- (void)setNewSessionWithState:(CTUserSettingsState *)userSettingsState
{
    [CartrawlerAPI requestNewSessionWithClientID:userSettingsState.clientID
                                    currencyCode:userSettingsState.currencyCode
                                    languageCode:userSettingsState.languageCode
                                     countryCode:userSettingsState.countryCode
                                       debugMode:userSettingsState.debugMode
                                      completion:^(CT_IpToCountryRS *response, CTErrorResponse *error) {
                                          if (response) {
                                              [CTAppController dispatchAction:CTActionAPIDidReturnEngineLoadID payload:response.engineLoadID];
                                              [CTAppController dispatchAction:CTActionAPIDidReturnCustomerID payload:response.customerID];
                                          } else {
                                              // TODO: Dispatch error action
                                          }
                                      }];
}

- (void)fetchSearchLocationsWithState:(CTAppState *)appState {
    CTUserSettingsState *userSettingsState = appState.userSettingsState;
    CTSearchState *searchState = appState.searchState;
    
    [CartrawlerAPI locationSearchPerformRequestWithClientID:userSettingsState.clientID
                                             locationString:searchState.searchBarText
                                               languageCode:userSettingsState.languageCode
                                                  debugMode:userSettingsState.debugMode
                                             loggingEnabled:userSettingsState.loggingEnabled
                                                 completion:^(CTLocationSearch *response, CTErrorResponse *error) {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         if (response && !error) {
                                                             [CTAppController dispatchAction:CTActionAPIDidReturnMatchedLocations payload:response.matchedLocations];
                                                         } else {
                                                             // TODO: Dispatch error action
                                                         }
                                                     });
                                                     
                                                 }];
}

- (void)requestVehicleAvailabilityWithState:(CTAppState *)appState {
    CTSearchState *searchState = appState.searchState;
    CTUserSettingsState *userSettingsState = appState.userSettingsState;
    CTAPIState *apiState = appState.APIState;
    NSString *requestTimestamp = apiState.availabilityRequestTimestamp;
    
    NSDate *pickupDate = [NSDate mergeTimeWithDateWithTime:searchState.selectedPickupTime
                                               dateWithDay:searchState.selectedPickupDate];
    NSDate *dropoffDate = [NSDate mergeTimeWithDateWithTime:searchState.selectedDropoffTime
                                               dateWithDay:searchState.selectedDropoffDate];
    
    CTMatchedLocation *dropoffLocation = searchState.dropoffLocationRequired ? searchState.selectedDropoffLocation : searchState.selectedPickupLocation;
    
    NSNumber *age = searchState.driverAgeRequired ? [NSNumber numberFromString:searchState.displayedDriverAge ] : @30;
    
    [CartrawlerAPI requestVehicleAvailabilityForLocation:searchState.selectedPickupLocation.code
                                      returnLocationCode:dropoffLocation.code
                                     customerCountryCode:appState.userSettingsState.countryCode
                                            passengerQty:@1
                                               driverAge:age
                                          pickUpDateTime:pickupDate
                                          returnDateTime:dropoffDate
                                            currencyCode:userSettingsState.currencyCode
                                                clientID:userSettingsState.clientID
                                                language:userSettingsState.languageCode
                                               debugMode:userSettingsState.debugMode
                                          loggingEnabled:userSettingsState.loggingEnabled
                                              completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      if (response && !error) {
                                                          [CTAppController dispatchAction:CTActionAPIDidReturnVehicles payload:@{requestTimestamp : response.items}];
                                                      } else {
                                                          [CTAppController dispatchAction:CTActionAPIDidReturnVehiclesError payload:error];
                                                      }
                                                  });
                                              }];
}

- (void)requestInsuranceForSelectedVehicleWithState:(CTAppState *)appState {
    CTSearchState *searchState = appState.searchState;
    CTUserSettingsState *userSettingsState = appState.userSettingsState;
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setMinimumFractionDigits:2];
    NSString *price = [formatter stringFromNumber:selectedVehicleState.selectedAvailabilityItem.vehicle.totalPriceForThisVehicle];
    
    [CartrawlerAPI requestInsuranceQuoteForVehicle:selectedVehicleState.selectedAvailabilityItem
                                   homeCountryCode:userSettingsState.countryCode
                            destinationCountryCode:searchState.selectedPickupLocation.countryCode
                                          currency:userSettingsState.currencyCode
                                         totalCost:price
                                    pickupDateTime:searchState.selectedPickupDate
                                    returnDateTime:searchState.selectedDropoffDate
                                          clientID:userSettingsState.clientID
                                         debugMode:userSettingsState.debugMode
                                    loggingEnabled:userSettingsState.loggingEnabled
                                        completion:^(CTInsurance *response, CTErrorResponse *error) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                if (response && !error) {
                                                    [CTAppController dispatchAction:CTActionAPIDidReturnInsurance payload:response];
                                                } else {
                                                    [CTAppController dispatchAction:CTActionAPIDidReturnInsuranceError payload:error];
                                                }
                                            });
                                        }];
}

- (void)requestTermsAndConditionsForSelectedVehicleWithState:(CTAppState *)appState {
    // TODO: Duplicated code in this class
    
    CTSearchState *searchState = appState.searchState;
    CTUserSettingsState *userSettingsState = appState.userSettingsState;
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    
    NSDate *pickupDate = [NSDate mergeTimeWithDateWithTime:searchState.selectedPickupTime
                                               dateWithDay:searchState.selectedPickupDate];
    NSDate *dropoffDate = [NSDate mergeTimeWithDateWithTime:searchState.selectedDropoffTime
                                                dateWithDay:searchState.selectedDropoffDate];
    
    CTMatchedLocation *dropoffLocation = searchState.dropoffLocationRequired ? searchState.selectedDropoffLocation : searchState.selectedPickupLocation;
    
    [CartrawlerAPI requestTermsAndConditions:pickupDate
                              returnDateTime:dropoffDate
                          pickupLocationCode:searchState.selectedPickupLocation.code
                          returnLocationCode:dropoffLocation.code
                                 homeCountry:userSettingsState.countryCode
                                         car:selectedVehicleState.selectedAvailabilityItem.vehicle
                                    clientID:userSettingsState.clientID
                                   debugMode:userSettingsState.debugMode
                              loggingEnabled:userSettingsState.loggingEnabled
                                      locale:userSettingsState.languageCode
                                  completion:^(CTTermsAndConditions *response, CTErrorResponse *error) {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (response && !error) {
                                              [CTAppController dispatchAction:CTActionAPIDidReturnTermsAndConditions payload:response];
                                          } else  {
                                              [CTAppController dispatchAction:CTActionAPIDidReturnTermsAndConditionsError payload:error];
                                          }
                                      });
                                      
                                  }];
}

@end
