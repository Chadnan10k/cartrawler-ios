//
//  CTRateDistance.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 05/05/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTRateDistance.h"

@implementation CTRateDistance

- (instancetype)initFromDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    _distanceUnitName = dictionary[@"@DistUnitName"] ?: @"";
    NSInteger quantityInt = [dictionary[@"@Quantity"] integerValue] ?: 0;
    _quantity = [NSNumber numberWithInteger:quantityInt];
    _isUnlimited = [dictionary[@"@Unlimited"] boolValue];
    _vehiclePeriodUnitName = dictionary[@"@@VehiclePeriodUnitName"] ?: @"";
    
    return self;
}

@end
