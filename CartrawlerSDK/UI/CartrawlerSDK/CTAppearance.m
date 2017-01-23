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
        sharedInstance.buttonColor = [UIColor colorWithRed:241.0/255.0 green:201.0/255.0 blue:51.0/255.0 alpha:1.0];
        sharedInstance.buttonTextColor = [UIColor colorWithRed:7.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:1.0];
        sharedInstance.buttonCornerRadius = 5.0;
        sharedInstance.enableShadows = YES;

        sharedInstance.viewBackgroundColor = [UIColor colorWithRed:7.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:1.0];
        sharedInstance.navigationBarColor = [UIColor colorWithRed:7.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:1.0];
        sharedInstance.tabBarTint = [UIColor colorWithRed:27.0/255.0 green:78.0/255.0 blue:148.0/255.0 alpha:1.0];
        sharedInstance.iconTint = [UIColor colorWithRed:32.0/255.0 green:145.0/255.0 blue:235.0/255.0 alpha:1.0];
        sharedInstance.headerTitleColor = [UIColor colorWithRed:32.0/255.0 green:145.0/255.0 blue:235.0/255.0 alpha:1.0];
        sharedInstance.subheaderTitleColor = [UIColor colorWithRed:164.0/255.0 green:170.0/255.0 blue:179.0/255.0 alpha:1.0];
        sharedInstance.tooltipBackgroundColor = [UIColor colorWithRed:31.0/255.0 green:73.0/255.0 blue:155.0/255.0 alpha:1.0];

        sharedInstance.containerViewCornerRadius = 5.0;
        sharedInstance.containerViewMarginPadding = 16;
        
        sharedInstance.textFieldCornerRadius = 3.0;
        sharedInstance.textFieldTint = [UIColor colorWithRed:26.0/255.0 green:38.0/255.0 blue:88.0/255.0 alpha:1.0];
        sharedInstance.textFieldBackgroundColor = [UIColor whiteColor];
        sharedInstance.enableTextFieldShadows = NO;
        sharedInstance.supplierDetailPrimaryColor = [UIColor colorWithRed:7.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:1.0];
        sharedInstance.supplierDetailSecondaryColor = [UIColor colorWithRed:32.0/255.0 green:145.0/255.0 blue:235.0/255.0 alpha:1.0];
        sharedInstance.insurancePrimaryColor = [UIColor colorWithRed:32.0/255.0 green:145.0/255.0 blue:235.0/255.0 alpha:1.0];

        sharedInstance.fontName = @"Avenir";
        sharedInstance.boldFontName = @"Avenir-Medium";
        
        sharedInstance.calendarStartCellColor = [UIColor colorWithRed:241.0/255.0 green:201.0/255.0 blue:51.0/255.0 alpha:1.0];
        sharedInstance.calendarEndCellColor = [UIColor colorWithRed:241.0/255.0 green:201.0/255.0 blue:51.0/255.0 alpha:1.0];
        sharedInstance.calendarMidCellColor = [UIColor colorWithRed:7.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:1.0];
        sharedInstance.calendarSameDayCellColor = [UIColor colorWithRed:241.0/255.0 green:201.0/255.0 blue:51.0/255.0 alpha:1.0];
        sharedInstance.calendarSummaryViewColor = [UIColor colorWithRed:32/255.0 green:145/255.0 blue:235/255.0 alpha:1.0];
        sharedInstance.calendarSummaryTitleLabelColor = [UIColor colorWithRed:27.0/255.0 green:78.0/255.0 blue:148.0/255.0 alpha:1.0];
        
        sharedInstance.presentAnimated = YES;
        sharedInstance.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        sharedInstance.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        sharedInstance.merchandisingBestSeller = [UIColor colorWithRed:32.0/255.0 green:145.0/255.0 blue:235.0/255.0 alpha:1.0];
        sharedInstance.merchandisingGreatValue = [UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:79.0/255.0 alpha:1.0];
        sharedInstance.merchandisingSpecialOffer = [UIColor colorWithRed:254/255.0 green:107/255.0 blue:19/255.0 alpha:1.0];

        sharedInstance.vehicleCellTint = [UIColor colorWithRed:32.0/255.0 green:145.0/255.0 blue:235.0/255.0 alpha:1.0];
        
    });
    return sharedInstance;
}
    
    //RYR 32, 145, 235 bright blue

@end
