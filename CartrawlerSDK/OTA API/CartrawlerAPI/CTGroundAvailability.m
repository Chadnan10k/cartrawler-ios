//
//  CTGroundAvailResponse.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 24/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTGroundAvailability.h"

@implementation CTGroundAvailability

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];

    dict = dict[@"GroundServices"];
    
    NSMutableArray *tempServices = [[NSMutableArray alloc] init];
    for (NSDictionary *service in dict) {
        CTGroundService *groundService = [[CTGroundService alloc] initWithDictionary: service];
        [tempServices addObject:groundService];
    }
    _services = tempServices;

    
    return self;
}

@end
