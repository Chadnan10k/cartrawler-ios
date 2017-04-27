//
//  NSNumberUtils.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerSDK+NSNumber.h"
#import "CTSDKSettings.h"

@implementation NSNumber (CartrawlerSDK)

- (NSString *)numberStringWithCurrencyCode
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.minimumFractionDigits = 2;
    f.currencyCode = [CTSDKSettings instance].currencyCode;
    f.numberStyle = NSNumberFormatterCurrencyStyle;
    
    return [f stringFromNumber:self];
}

- (NSString *)decimalPlaces:(int)places;
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.minimumFractionDigits = places;
    f.maximumFractionDigits = places;
    f.numberStyle = NSNumberFormatterDecimalStyle;
    return [f stringFromNumber:self];
}

- (NSString *)pricePerDay:(NSDate *)pickup dropoff:(NSDate *)dropoff
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:pickup
                                                          toDate:dropoff
                                                         options:0];
    
    NSNumber *pricePerDay = [NSNumber numberWithFloat:self.floatValue
                             / ([components day] ?: 1)];
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.minimumFractionDigits = 2;
    f.currencyCode = [CTSDKSettings instance].currencyCode;
    f.numberStyle = NSNumberFormatterCurrencyStyle;
    
    return [f stringFromNumber:pricePerDay];
}

+ (NSNumber *)numberFromString:(NSString *)string
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    return [f numberFromString:string];
}

@end
