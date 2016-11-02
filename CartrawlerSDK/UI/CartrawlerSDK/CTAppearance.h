//
//  CTTheme.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 20/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CTAppearance : NSObject

//Buttons
@property (nonatomic, strong) UIColor  *buttonColor;
@property (nonatomic, strong) UIColor  *buttonTextColor;
@property (nonatomic)         CGFloat  buttonCornerRadius;
@property (nonatomic)         BOOL     enableShadows;

//Views
@property (nonatomic, strong) UIColor  *viewBackgroundColor;
@property (nonatomic, strong) UIColor  *navigationBarColor;
@property (nonatomic, strong) UIColor  *tabBarTint;

//Text
@property (nonatomic)         CGFloat  textFieldCornerRadius;
@property (nonatomic, strong) UIColor  *textFieldTint;
@property (nonatomic, strong) UIColor  *textFieldBackgroundColor;
@property (nonatomic, strong) NSString *fontName;
@property (nonatomic, strong) NSString *boldFontName;

//Calendar
@property (nonatomic, strong) UIColor  *calendarStartCellColor;
@property (nonatomic, strong) UIColor  *calendarMidCellColor;
@property (nonatomic, strong) UIColor  *calendarEndCellColor;
@property (nonatomic, strong) UIColor  *calendarSummaryViewColor;
@property (nonatomic, strong) UIColor  *calendarSummaryTitleLabelColor;


//Presentation
@property (nonatomic)         UIModalPresentationStyle modalPresentationStyle;
@property (nonatomic)         UIModalTransitionStyle   modalTransitionStyle;
@property (nonatomic)         BOOL                     presentAnimated;

//Merchandising Banner
@property (nonatomic, strong) UIColor  *merchandisingBestSeller;
@property (nonatomic, strong) UIColor  *merchandisingGreatValue;

+ (instancetype)instance;

@end
