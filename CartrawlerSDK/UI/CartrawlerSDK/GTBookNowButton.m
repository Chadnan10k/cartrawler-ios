//
//  GTBookNowButton.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTBookNowButton.h"
#import "CTAppearance.h"

@implementation GTBookNowButton




- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    UIColor *color = [CTAppearance instance].buttonColor;
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    // iOS 5
    if ([color respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
    } else {
        // < iOS 5
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    
    // This is a non-RGB color
    if(CGColorGetNumberOfComponents(color.CGColor) == 2) {
        CGFloat hue;
        CGFloat saturation;
        CGFloat brightness;
        [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        
    }
    

    self.backgroundColor = color;

    self.layer.cornerRadius = 3.0f;
    self.layer.shadowColor = [UIColor colorWithRed:red * 0.75f
                                             green:green * 0.75f
                                              blue:blue * 0.75f
                                             alpha:1.0].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2.5);
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowRadius = 0.0;
    
    return self;
}

@end
