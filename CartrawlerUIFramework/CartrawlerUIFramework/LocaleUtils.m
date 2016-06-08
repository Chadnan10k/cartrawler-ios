//
//  LocaleUtils.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "LocaleUtils.h"

@implementation LocaleUtils

+ (NSString *)priceForDeviceLocale:(NSNumber *)price
{
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setLocale: [NSLocale currentLocale]];
    [numFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    return [numFormatter stringFromNumber:price];
}

@end
