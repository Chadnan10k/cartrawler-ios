//
//  CT+NSNumber.m
//  TestApp
//
//  Created by Lee Maguire on 08/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CT+NSNumber.h"

@implementation NSNumber (CT)

- (NSString *)numberStringWithCurrencyCode
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.minimumFractionDigits = 2;
    f.currencyCode = @"EUR";
    f.numberStyle = NSNumberFormatterCurrencyStyle;
    
    return [f stringFromNumber:self];
}

@end
