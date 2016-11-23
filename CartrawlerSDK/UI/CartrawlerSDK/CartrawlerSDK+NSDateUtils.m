//
//  NSDateUtils.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 14/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerSDK+NSDateUtils.h"

@implementation NSDate (CartrawlerSDK)

- (NSString *)stringFromDateWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *)stringFromDate:(NSString *)format;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    
    return [formatter stringFromDate:self];
}

- (NSString *)shortDescriptionFromDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    return [formatter stringFromDate:self];
}

- (NSString *)simpleTimeString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterNoStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    return [formatter stringFromDate:self];
}

+ (NSDate *)mergeTimeWithDateWithTime:(NSDate *)dateWithTime dateWithDay:(NSDate *)dateWithDay
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    // Extract date components into components1
    NSDateComponents *components1 = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                         fromDate:dateWithDay];
    
    // Extract time components into components2
    NSDateComponents *components2 = [gregorianCalendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond
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
