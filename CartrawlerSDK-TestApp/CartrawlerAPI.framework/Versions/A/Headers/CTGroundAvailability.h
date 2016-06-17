//
//  CTGroundAvailResponse.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 24/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTGroundService.h"
/**
 *  CTGroundAvailability
 */
@interface CTGroundAvailability : NSObject

/**
 *  An array of services for ground transportation
 */
@property (nonatomic, strong, readonly) NSArray<CTGroundService *> *services;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
