//
//  CTState.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/18/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTUserSettingsState.h"
#import "CTAPIState.h"
#import "CTNavigationState.h"
#import "CTSearchState.h"
#import "CTVehicleListState.h"
#import "CTSelectedVehicleState.h"

@interface CTAppState : NSObject
@property (nonatomic) CTUserSettingsState *userSettingsState;
@property (nonatomic) CTAPIState *APIState;
@property (nonatomic) CTNavigationState *navigationState;
@property (nonatomic) CTSearchState *searchState;
@property (nonatomic) CTVehicleListState *vehicleListState;
@property (nonatomic) CTSelectedVehicleState *selectedVehicleState;
@end
