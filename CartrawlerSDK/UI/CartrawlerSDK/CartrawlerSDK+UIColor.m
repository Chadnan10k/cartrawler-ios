//
//  UIColorUtils.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 25/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerSDK+UIColor.h"

@implementation UIColor (CartrawlerSDK)

- (UIColor *)lighterColorForColor;
{
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.2, 1.0)
                               green:MIN(g + 0.2, 1.0)
                                blue:MIN(b + 0.2, 1.0)
                               alpha:a];
    return nil;
}

- (NSString *)hex
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString=[NSString stringWithFormat:@"%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    return hexString;
}

@end
