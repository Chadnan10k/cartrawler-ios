//
//  NSDateUtils.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 13/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+ (void)forceLinkerLoad_;


+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;
+ (NSString *)shortDescriptionFromDate:(NSDate *)date;
+ (NSDate *)mergeTimeWithDateWithTime:(NSDate *)dateWithTime dateWithDay:(NSDate *)dateWithDay;

@end
