//
//  CTTheme.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 20/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTAppearance.h"

@implementation CTAppearance

+ (instancetype)instance
{
    static CTAppearance *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CTAppearance alloc] init];
        
        //set the default theme here
        sharedInstance.navigationItemTint = [UIColor blueColor];
        sharedInstance.navigationBarTint = [UIColor whiteColor];
        //sharedInstance.navigationBarImage = [UIImage imageNamed:@""];
        
        sharedInstance.buttonColor = [UIColor colorWithRed:1.0/255.0 green:51.0/255.0 blue:84.0/255.0 alpha:1.0];
        sharedInstance.buttonTextColor = [UIColor whiteColor];
        sharedInstance.buttonCornerRadius = 5.0;
        sharedInstance.buttonShadowEnabled = YES;
        
        sharedInstance.fontName = @"Avenir";
        sharedInstance.viewBackgroundColor = [UIColor colorWithRed:1.0/255.0 green:177.0/255.0 blue:201.0/255.0 alpha:1.0];
        sharedInstance.textFieldCornerRadius = 5.0;
        sharedInstance.textFieldTint = [UIColor colorWithRed:1.0/255.0 green:177.0/255.0 blue:201.0/255.0 alpha:1.0];
        sharedInstance.textFieldBackgroundColor = [UIColor whiteColor];
        
        sharedInstance.locationSelectionBarColor = [UIColor colorWithRed:1.0/255.0 green:177.0/255.0 blue:201.0/255.0 alpha:1.0];

        sharedInstance.calendarHeaderTopSectionColor = [UIColor colorWithRed:1.0/255.0 green:177.0/255.0 blue:201.0/255.0 alpha:1.0];
        sharedInstance.calendarHeaderBottomSectionColor = [UIColor colorWithRed:123.0/255.0 green:201.0/255.0 blue:212.0/255.0 alpha:1.0];
        sharedInstance.calendarStartCellColor = [UIColor colorWithRed:1.0/255.0 green:177.0/255.0 blue:201.0/255.0 alpha:1.0];
        sharedInstance.calendarEndCellColor = [UIColor colorWithRed:1.0/255.0 green:177.0/255.0 blue:201.0/255.0 alpha:1.0];
        sharedInstance.calendarMidCellColor = [UIColor colorWithRed:236.0/255.0 green:99.0/255.0 blue:0.0/255.0 alpha:1.0];
    });
    return sharedInstance;
}

//Nav

- (void)setNavigationItemTint:(UIColor *)color
{
    _navigationItemTint = color;
}

- (void)setNavigationBarTint:(UIColor *)color
{
    _navigationBarTint = color;
}

- (void)setNavigationBarImage:(UIImage *)image
{
    _navigationBarImage = image;
}

//But

- (void)setButtonColor:(UIColor *)color
{
    _buttonColor = color;
}

- (void)setButtonTextColor:(UIColor *)color
{
    _buttonTextColor = color;
}

- (void)setButtonCornerRadius:(CGFloat)radius
{
    _buttonCornerRadius = radius;
}

- (void)setButtonShadowEnabled:(BOOL)isEnabled
{
    _buttonShadowEnabled = isEnabled;
}

//Font

- (void)setFontName:(NSString *)fontName;
{
    _fontName = fontName;
}

//view

- (void)setViewBackgroundColor:(UIColor *)color
{
    _viewBackgroundColor = color;
}

// textfield

- (void)setTextFieldCornerRadius:(CGFloat)radius
{
    _textFieldCornerRadius = radius;
}

- (void)setTextFieldTint:(UIColor *)color
{
    _textFieldTint = color;
}

- (void)setTextFieldBackgroundColor:(UIColor *)color
{
    _textFieldBackgroundColor = color;
}

//Location selection

- (void)setLocationSelectionBarColor:(UIColor *)color
{
    _locationSelectionBarColor = color;
}

//Calendar

- (void)setCalendarHeaderTopSectionColor:(UIColor *)color
{
    _calendarHeaderTopSectionColor = color;
}

- (void)setCalendarHeaderBottomSectionColor:(UIColor *)color
{
    _calendarHeaderBottomSectionColor = color;
}

- (void)setCalendarStartCellColor:(UIColor *)color
{
    _calendarStartCellColor = color;
}

- (void)setCalendarMidCellColor:(UIColor *)color
{
    _calendarMidCellColor = color;
}

- (void)setCalendarEndCellColor:(UIColor *)color
{
    _calendarEndCellColor = color;
}

@end
