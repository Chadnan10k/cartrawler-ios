//
//  CTVehicleIndexation.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 01/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleIndexation.h"

@implementation CTVehicleIndexation
/*
 "IndexByPrice": {
 "@Key": "61",
 "@BundleText": "Standard",
 "@BundleType": "Rate_IN"
 }
 */

- (instancetype)initFromDictionary:(NSDictionary *)dict
{
    self = [super init];
    NSNumberFormatter *nf = [NSNumberFormatter new];
    
    _key = [nf numberFromString:dict[@"IndexByPrice"][@"@Key"]].integerValue;
    _bundleText = dict[@"IndexByPrice"][@"@BundleText"];
    _bundleType = dict[@"IndexByPrice"][@"@BundleType"];

    return self;
}

@end
