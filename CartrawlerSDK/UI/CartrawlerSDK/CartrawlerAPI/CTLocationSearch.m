//
//  OTAVehLocSearchResponse.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 13/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTLocationSearch.h"
#import "CTMatchedLocation.h"

@implementation CTLocationSearch

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (dictionary[@"VehMatchedLocs"] != nil) {
        NSMutableArray *tempMatchedLocations = [[NSMutableArray alloc] init];
        NSArray *locationArray = dictionary[@"VehMatchedLocs"];
        
        if (locationArray.count > 1) {
            for (NSDictionary *locationDict in locationArray) {
                CTMatchedLocation *location = [[CTMatchedLocation alloc] initWithDictionary: locationDict];
                [tempMatchedLocations addObject: location];
            }
        } else {
            CTMatchedLocation *location = [[CTMatchedLocation alloc] initWithDictionary: dictionary[@"VehMatchedLocs"][@"VehMatchedLoc"]];
            [tempMatchedLocations addObject: location];
        }
        _matchedLocations = tempMatchedLocations;
        tempMatchedLocations = nil;
    }
    
    return self;
}

- (instancetype)initWithPartialTextDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (dictionary[@"VehMatchedLocs"][@"LocationDetail"] != nil) {
        NSMutableArray *tempMatchedLocations = [[NSMutableArray alloc] init];

        if ([dictionary[@"VehMatchedLocs"][@"LocationDetail"] isKindOfClass:[NSArray class]]) {
        
        NSArray *locationArray = dictionary[@"VehMatchedLocs"][@"LocationDetail"];
        
                for (NSDictionary *locationDict in locationArray) {
                    CTMatchedLocation *location = [[CTMatchedLocation alloc] initWithPartialStringDictionary:locationDict];
                    [tempMatchedLocations addObject: location];
                }
            
        } else {
            CTMatchedLocation *location = [[CTMatchedLocation alloc] initWithPartialStringDictionary: dictionary[@"VehMatchedLocs"][@"LocationDetail"]];
            [tempMatchedLocations addObject: location];
        }
        
        _matchedLocations = tempMatchedLocations;
        tempMatchedLocations = nil;
    }
    return self;
}

@end
