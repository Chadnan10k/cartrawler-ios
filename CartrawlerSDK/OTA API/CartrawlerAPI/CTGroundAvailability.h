//
//  CTGroundAvailResponse.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 24/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTGroundService.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  CTGroundAvailability
 */
@interface CTGroundAvailability : NSObject

/**
 *  An array of services for ground transportation
 */
@property (nonatomic, nonnull, readonly) NSArray<CTGroundService *> *services;

- (instancetype)initWithDictionary:(NSDictionary *)dict  ;

@end

NS_ASSUME_NONNULL_END
