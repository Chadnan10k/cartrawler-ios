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
    formatter.dateFormat = format;
    
    return [formatter stringFromDate:date];
}

+ (NSString *)shortDescriptionFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
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
    
    components3.year = components1.year;
    components3.month = components1.month;
    components3.day = components1.day;
    
    components3.hour = components2.hour;
    components3.minute = components2.minute;
    components3.second = components2.second;
    
    // Generate a new NSDate from components3.
    return [gregorianCalendar dateFromComponents:components3];
}


@end
