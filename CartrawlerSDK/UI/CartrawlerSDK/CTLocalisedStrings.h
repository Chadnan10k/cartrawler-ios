//
//  CTLocalisedStrings.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 09/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CartrawlerAPI/CTAvailabilityItem.h>
#import <CartrawlerAPI/CTGroundService.h>

/**
 *  Convenience macro for localized strings
 *  Uses strings file from bundle of calling object
 */
#define CTLocalizedString(key) \
[CTLocalisedStrings localizedStringForKey:(key) bundle:[NSBundle bundleForClass:[self class]]]

@interface CTLocalisedStrings : NSObject

+ (NSString *)pickupType:(CTAvailabilityItem *)item;
+ (NSString *)vehicleSize:(VehicleSize)size;
+ (NSString *)serviceLevel:(ServiceLevel)type;
+ (NSString *)inclusionText:(Inclusion)inclusion;
+ (NSString *)fuelPolicy:(FuelPolicy)fuelPolicy;

+ (NSString *)toolTipTextForFuelPolicy:(FuelPolicy)fuelPolicy;
+ (NSString *)toolTipTextForPickupType:(CTAvailabilityItem *)item;

+ (NSString *)transmission:(NSString *)transmissionStr;

+ (NSString *)localizedStringForKey:(NSString *)key bundle:(NSBundle *)bundle;

@end
