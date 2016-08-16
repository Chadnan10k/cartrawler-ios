//
//  LocaleUtils.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "LocaleUtils.h"

@implementation LocaleUtils

+ (void)forceLinkerLoad_
{
    
}

+ (NSString *)priceForDeviceLocale:(NSNumber *)price
{
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    numFormatter.locale = [NSLocale currentLocale];
    numFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    return [numFormatter stringFromNumber:price];
}

@end
