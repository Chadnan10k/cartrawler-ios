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

@property (nonatomic, strong, readonly) UIColor  *navigationItemTint;
@property (nonatomic, strong, readonly) UIColor  *navigationBarTint;
@property (nonatomic, strong, readonly) UIImage  *navigationBarImage;
@property (nonatomic, strong, readonly) UIColor  *buttonColor;
@property (nonatomic, strong, readonly) UIColor  *buttonTextColor;
@property (nonatomic, readonly)         CGFloat  buttonCornerRadius;
@property (nonatomic, readonly)         BOOL     buttonShadowEnabled;
@property (nonatomic, strong, readonly) NSString *fontName;
@property (nonatomic, strong, readonly) UIColor  *viewBackgroundColor;
@property (nonatomic, readonly)         CGFloat  textFieldCornerRadius;
@property (nonatomic, strong, readonly) UIColor  *textFieldTint;
@property (nonatomic, strong, readonly) UIColor  *textFieldBackgroundColor;
@property (nonatomic, strong, readonly) UIColor  *locationSelectionBarColor;

@property (nonatomic, strong, readonly) UIColor  *calendarHeaderTopSectionColor;
@property (nonatomic, strong, readonly) UIColor  *calendarHeaderBottomSectionColor;
@property (nonatomic, strong, readonly) UIColor  *calendarStartCellColor;
@property (nonatomic, strong, readonly) UIColor  *calendarMidCellColor;
@property (nonatomic, strong, readonly) UIColor  *calendarEndCellColor;

+ (instancetype)instance;

/**
 *  Navigation Bar
 */

- (void)setNavigationItemTint:(UIColor *)color;
- (void)setNavigationBarTint:(UIColor *)color;
- (void)setNavigationBarImage:(UIImage *)image;

/**
 *   Button
 */

- (void)setButtonColor:(UIColor *)color;
- (void)setButtonTextColor:(UIColor *)color;
- (void)setButtonCornerRadius:(CGFloat)radius;
- (void)setButtonShadowEnabled:(BOOL)isEnabled;

/**
 *  Global font
 */

- (void)setFontName:(NSString *)fontName;

/**
 *  Background view
 */

- (void)setViewBackgroundColor:(UIColor *)color;

/**
 *  TextField
 */

- (void)setTextFieldCornerRadius:(CGFloat)radius;
- (void)setTextFieldTint:(UIColor *)color;
- (void)setTextFieldBackgroundColor:(UIColor *)color;

/**
 *  Location Selection View
 */

- (void)setLocationSelectionBarColor:(UIColor *)color;

/**
 *  Calendar
 */

- (void)setCalendarHeaderTopSectionColor:(UIColor *)color;
- (void)setCalendarHeaderBottomSectionColor:(UIColor *)color;
- (void)setCalendarStartCellColor:(UIColor *)color;
- (void)setCalendarMidCellColor:(UIColor *)color;
- (void)setCalendarEndCellColor:(UIColor *)color;

/**
 *  Slider
 */

/**
 *  Stepper
 */

/**
 *  Segment
 */

@end
