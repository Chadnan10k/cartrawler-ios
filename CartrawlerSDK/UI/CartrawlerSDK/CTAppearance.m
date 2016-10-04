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
        
        sharedInstance.buttonColor = [UIColor colorWithRed:1.0/255.0 green:51.0/255.0 blue:84.0/255.0 alpha:1.0];
        sharedInstance.buttonTextColor = [UIColor whiteColor];
        sharedInstance.buttonCornerRadius = 2.0;
        sharedInstance.enableShadows = NO;
        
        sharedInstance.viewBackgroundColor = [UIColor colorWithRed:1.0/255.0 green:177.0/255.0 blue:201.0/255.0 alpha:1.0];
        sharedInstance.navigationBarColor = [UIColor colorWithRed:1.0/255.0 green:177.0/255.0 blue:201.0/255.0 alpha:1.0];

        sharedInstance.textFieldCornerRadius = 3.0;
        sharedInstance.textFieldTint = [UIColor colorWithRed:1.0/255.0 green:177.0/255.0 blue:201.0/255.0 alpha:1.0];
        sharedInstance.textFieldBackgroundColor = [UIColor whiteColor];
        
        sharedInstance.fontName = @"Avenir";
        sharedInstance.boldFontName = @"Avenir-Medium";
        
        sharedInstance.calendarStartCellColor = [UIColor colorWithRed:1.0/255.0 green:177.0/255.0 blue:201.0/255.0 alpha:1.0];
        sharedInstance.calendarEndCellColor = [UIColor colorWithRed:1.0/255.0 green:177.0/255.0 blue:201.0/255.0 alpha:1.0];
        sharedInstance.calendarMidCellColor = [UIColor colorWithRed:236.0/255.0 green:99.0/255.0 blue:0.0/255.0 alpha:1.0];
        
        sharedInstance.presentAnimated = YES;
        sharedInstance.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        sharedInstance.modalPresentationStyle = UIModalPresentationCurrentContext;
        
    });
    return sharedInstance;
}

@end
