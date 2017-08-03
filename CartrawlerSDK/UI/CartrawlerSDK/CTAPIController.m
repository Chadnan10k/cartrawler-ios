//
//  CTAPIController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/18/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAPIController.h"
#import <CartrawlerAPI/CartrawlerAPI.h>
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
                                               debugMode:userSettingsState.debugMode
                                          loggingEnabled:userSettingsState.loggingEnabled
                                              completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      if (response && !error) {
                                                          [CTAppController dispatchAction:CTActionAPIDidReturnVehicles payload:@{requestTimestamp : response.items}];
                                                      } else {
                                                          // TODO: Dispatch error action
                                                      }
                                                  });
                                              }];
}

@end
