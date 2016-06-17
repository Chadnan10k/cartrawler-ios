//
//  CTGroundBooking.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 24/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  CTGroundBooking
 */
@interface CTGroundBooking : NSObject
/**
 *  The confirmation ID of the ground transport booking
 */
@property (nonatomic, strong, readonly) NSString *confirmationId;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
