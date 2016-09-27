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

@property (nonatomic, strong)       UIColor  *buttonColor;
@property (nonatomic, strong)       UIColor  *buttonTextColor;
@property (nonatomic)               CGFloat  buttonCornerRadius;
@property (nonatomic)               BOOL     buttonShadowEnabled;
@property (nonatomic, strong)       NSString *fontName;
@property (nonatomic, strong)       NSString *boldFontName;
@property (nonatomic, strong)       UIColor  *viewBackgroundColor;
@property (nonatomic)               CGFloat  textFieldCornerRadius;
@property (nonatomic, strong)       UIColor  *textFieldTint;
@property (nonatomic, strong)       UIColor  *textFieldBackgroundColor;
@property (nonatomic, strong)       UIColor  *locationSelectionBarColor;

@property (nonatomic, strong)       UIColor  *calendarHeaderTopSectionColor;
@property (nonatomic, strong)       UIColor  *calendarHeaderBottomSectionColor;
@property (nonatomic, strong)       UIColor  *calendarStartCellColor;
@property (nonatomic, strong)       UIColor  *calendarMidCellColor;
@property (nonatomic, strong)       UIColor  *calendarEndCellColor;

+ (instancetype)instance;

@end
