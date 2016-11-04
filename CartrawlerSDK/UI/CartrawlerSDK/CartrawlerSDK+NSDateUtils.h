//
//  NSDateUtils.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 14/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CartrawlerSDK)
//static framework doesnt like categories so I guess we're stuck creating extensions like this

- (NSString *)stringFromDateWithFormat:(NSString *)format;
- (NSString *)stringFromDate:(NSString *)format;
- (NSString *)shortDescriptionFromDate;
+ (NSDate *)mergeTimeWithDateWithTime:(NSDate *)dateWithTime dateWithDay:(NSDate *)dateWithDay;

@end