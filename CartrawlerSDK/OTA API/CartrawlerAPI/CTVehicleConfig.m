//
//  CTVehicleConfig.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 01/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleConfig.h"

@implementation CTVehicleConfig

/*
 
 "Config": {
 "@OrderBy": "42",
 "@Relevance": "0",
 "@Insurance": "true",
 "@Duration": "1",
 "@CC_Info": "true"
 },
 
 */

- (instancetype)initFromDictionary:(NSDictionary *)dict
{
    self = [super init];
 
    NSNumberFormatter *nf = [NSNumberFormatter new];
    [nf setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];

    _orderBy = [nf numberFromString:dict[@"@OrderBy"]].integerValue;
    _relevance = [nf numberFromString:dict[@"@Relevance"]].integerValue;
    _rentalDuration = [nf numberFromString:dict[@"@Duration"]].integerValue;
    
    if ([dict[@"@Insurance"] isEqualToString:@"true"]) {
        _insurance = YES;
    } else {
        _insurance = NO;
    }
    
    if ([dict[@"@CC_Info"] isEqualToString:@"true"]) {
        _ccInfo = YES;
    } else {
        _ccInfo = NO;
    }
    
    return self;
}

@end
