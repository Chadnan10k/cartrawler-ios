//
//  OTAVehLocSearchResponse.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 13/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTMatchedLocation.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  CTLocationSearch
 */
@interface CTLocationSearch : NSObject

/**
 *  Array of CTMatchedLocation's
 */
@property (nonatomic, readonly, nonnull) NSArray<CTMatchedLocation *> *matchedLocations;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary  ;
- (instancetype)initWithPartialTextDictionary:(NSDictionary *)dictionary  ;
@end

NS_ASSUME_NONNULL_END
