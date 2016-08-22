//
//  CTGroundBooking.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 24/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  CTGroundBooking
 */
@interface CTGroundBooking : NSObject
/**
 *  The confirmation ID of the ground transport booking
 */
@property (nonatomic, nonnull, readonly) NSString *confirmationId;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
