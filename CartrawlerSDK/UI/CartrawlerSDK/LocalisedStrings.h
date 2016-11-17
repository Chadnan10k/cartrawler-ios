//
//  LocalisedStrings.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 09/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CartrawlerAPI/CTAvailabilityItem.h>
#import <CartrawlerAPI/CTGroundService.h>

@interface LocalisedStrings : NSObject

+ (NSString *)pickupType:(CTAvailabilityItem *)item;
+ (NSString *)vehicleSize:(VehicleSize)size;
+ (NSString *)serviceLevel:(ServiceLevel)type;
+ (NSString *)inclusionText:(Inclusion)inclusion;
+ (NSString *)fuelPolicy:(FuelPolicy)fuelPolicy;

+ (NSString *)toolTipTextForFuelPolicy:(FuelPolicy)fuelPolicy;
+ (NSString *)toolTipTextForPickupType:(PickupType)pickupType;

+ (NSString *)localizedStringForKey:(NSString *)key;

@end
