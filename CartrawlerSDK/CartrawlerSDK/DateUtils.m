//
//  NSDateUtils.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 13/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+ (void)forceLinkerLoad_
{
    
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:date];
}

+ (NSString *)shortDescriptionFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    return [formatter stringFromDate:date];
}

+ (NSDate *)mergeTimeWithDateWithTime:(NSDate *)dateWithTime dateWithDay:(NSDate *)dateWithDay
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    // Extract date components into components1
    NSDateComponents *components1 = [gregorianCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                                         fromDate:dateWithDay];
    
    // Extract time components into components2
    NSDateComponents *components2 = [gregorianCalendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
                                                         fromDate:dateWithTime];
    
    // Combine date and time into components3
    NSDateComponents *components3 = [[NSDateComponents alloc] init];
    
    [components3 setYear:components1.year];
    [components3 setMonth:components1.month];
    [components3 setDay:components1.day];
    
    [components3 setHour:components2.hour+1];
    [components3 setMinute:components2.minute];
    [components3 setSecond:components2.second];
    
    // Generate a new NSDate from components3.
    return [gregorianCalendar dateFromComponents:components3];
}


@end
