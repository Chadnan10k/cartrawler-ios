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
    NSDate *pickupDate = [NSDate mergeTimeWithDateWithTime:appState.searchState.selectedPickupTime
                                               dateWithDay:appState.searchState.selectedPickupDate];
    NSDate *dropoffDate = [NSDate mergeTimeWithDateWithTime:appState.searchState.selectedDropoffTime
                                               dateWithDay:appState.searchState.selectedDropoffDate];
    
    [CartrawlerAPI requestVehicleAvailabilityForLocation:appState.searchState.selectedPickupLocation.code
                                      returnLocationCode:appState.searchState.selectedDropoffLocation.code
                                     customerCountryCode:appState.userSettingsState.countryCode
                                            passengerQty:@1
                                               driverAge:@30
                                          pickUpDateTime:pickupDate
                                          returnDateTime:dropoffDate
                                            currencyCode:appState.userSettingsState.currencyCode
                                                clientID:appState.userSettingsState.clientID
                                               debugMode:appState.userSettingsState.debugMode
                                          loggingEnabled:appState.userSettingsState.loggingEnabled
                                              completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                                                  if (response) {
                                                      [CTAppController dispatchAction:CTActionAPIDidReturnVehicles payload:response];
                                                  }
                                                  // TODO: Handle Error
                                              }];
}

@end
