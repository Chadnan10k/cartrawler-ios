//
//  NSNumberUtils.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "NSNumberUtils.h"
#import "CTSDKSettings.h"

@implementation NSNumberUtils

+ (NSString *)numberStringWithCurrencyCode:(NSNumber *)number
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.minimumFractionDigits = 2;
    f.currencyCode = [CTSDKSettings instance].currencyCode;
    f.numberStyle = NSNumberFormatterCurrencyStyle;
    
    return [f stringFromNumber:number];
}

@end
