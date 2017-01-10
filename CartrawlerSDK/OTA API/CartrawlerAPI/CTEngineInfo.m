//
//  CTEngineInfo.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 10/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTEngineInfo.h"

@implementation CTEngineInfo

- (instancetype)initFromDictionary:(NSDictionary *)dict
{
    self = [super init];
    NSLog(@"%@", dict[@"TPA_Extensions"]);
    _uniqueID = dict[@"TPA_Extensions"][@"BookEngine"][@"@uniqueID"];
    _engineLoadID = dict[@"TPA_Extensions"][@"BookEngine"][@"@engineLoadID"];
    _queryID = dict[@"TPA_Extensions"][@"BookEngine"][@"@queryID"];

    return self;
}

@end
