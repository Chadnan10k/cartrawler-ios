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

@end
