//
//  UIColorUtils.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 25/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "UIColorUtils.h"

@implementation UIColorUtils

+ (UIColor *)lighterColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.2, 1.0)
                               green:MIN(g + 0.2, 1.0)
                                blue:MIN(b + 0.2, 1.0)
                               alpha:a];
    return nil;
}

@end
