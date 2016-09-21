//
//  OTAVehLocSearchResponse.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 13/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTMatchedLocation.h"

@interface CTLocationSearch : NSObject

@property (nonatomic, strong, readonly) NSArray<CTMatchedLocation *> *matchedLocations;

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (id)initWithPartialTextDictionary:(NSDictionary *)dictionary;

@end