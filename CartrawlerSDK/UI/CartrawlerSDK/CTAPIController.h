//
//  CTAPIController.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/18/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTAppController.h"
#import "CTAppState.h"

@interface CTAPIController : NSObject

- (void)setNewSessionWithState:(CTUserSettingsState *)userSettingsState;
- (void)fetchSearchLocationsWithState:(CTAppState *)appState;
- (void)requestVehicleAvailabilityWithState:(CTAppState *)appState;
- (void)requestInsuranceForSelectedVehicleWithState:(CTAppState *)appState;
- (void)requestTermsAndConditionsForSelectedVehicleWithState:(CTAppState *)appState;

@end
