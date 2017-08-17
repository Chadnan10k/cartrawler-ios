//
//  CTSelectedVehicleState.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/26/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CartrawlerAPI/CTAvailabilityItem.h>
#import <CartrawlerAPI/CTInsurance.h>

typedef NS_ENUM(NSInteger, CTSelectedVehicleTab) {
    CTSelectedVehicleTabIncluded,
    CTSelectedVehicleTabRatings,
};

typedef NS_ENUM(NSInteger, CTSelectedVehicleExpanded) {
    CTSelectedVehicleExpandedPickupLocation,
    CTSelectedVehicleExpandedFuelPolicy,
    CTSelectedVehicleExpandedMileageAllowance,
    CTSelectedVehicleExpandedInsurance,
};

@interface CTSelectedVehicleState : NSObject

@property (nonatomic) CTAvailabilityItem *selectedAvailabilityItem;

@property (nonatomic) CTSelectedVehicleTab selectedTab;
@property (nonatomic) BOOL pickupLocationExpanded;
@property (nonatomic) BOOL fuelPolicyExpanded;
@property (nonatomic) BOOL mileageAllowanceExpanded;
@property (nonatomic) BOOL insuranceExpanded;

@property (nonatomic) CTInsurance *insurance;
@property (nonatomic) BOOL insuranceAdded;

@property (nonatomic) NSMapTable <CTExtraEquipment *, NSNumber *> *addedExtras;
@property (nonatomic) NSMutableArray <NSNumber *> *flippedExtras;
@end
