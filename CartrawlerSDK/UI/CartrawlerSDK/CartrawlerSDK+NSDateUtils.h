//
//  NSDateUtils.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 14/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CartrawlerSDK)

@property (nonatomic, readonly) NSInteger minute;

- (NSString *)stringFromDateWithFormat:(NSString *)format;
- (NSString *)shortDescriptionFromDate;
- (NSString *)simpleTimeString;

+ (NSDate *)dateWithHour:(NSInteger)hour minute:(NSInteger)minute;
+ (NSDate *)mergeTimeWithDateWithTime:(NSDate *)dateWithTime dateWithDay:(NSDate *)dateWithDay;

@end
