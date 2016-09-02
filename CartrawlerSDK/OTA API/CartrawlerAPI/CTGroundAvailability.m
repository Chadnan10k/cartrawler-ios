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
    NSMutableArray *tempShuttles = [[NSMutableArray alloc] init];

    for (NSDictionary *service in dict) {
        if (service[@"Shuttle"]) {
            CTGroundShuttle *shuttle = [[CTGroundShuttle alloc] initWithDictionary:service];
            [tempShuttles addObject:shuttle];
        } else {
            CTGroundService *groundService = [[CTGroundService alloc] initWithDictionary: service];
            [tempServices addObject:groundService];
        }
    }
    
    _services = tempServices;
    _shuttles = tempShuttles;
    
    return self;
}

@end
