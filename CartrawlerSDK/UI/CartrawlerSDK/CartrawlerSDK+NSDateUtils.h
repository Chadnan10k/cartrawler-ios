//
//  NSDateUtils.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 14/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CartrawlerSDK)

- (NSString *)stringFromDateWithFormat:(NSString *)format;
- (NSString *)shortDescriptionFromDate;
+ (NSDate *)mergeTimeWithDateWithTime:(NSDate *)dateWithTime dateWithDay:(NSDate *)dateWithDay;
- (NSString *)simpleTimeString;

@end
