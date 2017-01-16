//
//  CT_IpToCountryRS.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 13/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CT_IpToCountryRS.h"

@implementation CT_IpToCountryRS

- (instancetype)initFromDictionary:(NSDictionary *)dict
{
    self = [super init];
    _engineLoadID = dict[@"Config"][@"@engineLoadID"];
    _customerID = dict[@"Config"][@"@uniqueID"];
    _ipAddress = dict[@"ClientAddress"][@"@IP"];
    return self;
}

@end
