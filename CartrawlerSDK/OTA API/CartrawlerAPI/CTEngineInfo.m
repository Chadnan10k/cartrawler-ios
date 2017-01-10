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
    
    _uniqueID = dict[@"@uniqueID"];
    _engineLoadID = dict[@"@engineLoadID"];
    _queryID = dict[@"@queryID"];

    return self;
}

@end
