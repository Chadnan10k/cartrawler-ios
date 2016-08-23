//
//  LocalisedStrings.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 09/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CartrawlerAPI/CTAvailabilityItem.h>

@interface LocalisedStrings : NSObject

+ (NSString *)pickupType:(CTAvailabilityItem *)item;
+ (NSString *)vehicleSize:(VehicleSize)size;

@end
