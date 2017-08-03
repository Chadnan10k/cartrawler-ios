//
//  CTUserSettingsState.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/18/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CTUserSettingsStyle) {
    CTUserSettingsStyleNoStyle,
    CTUserSettingsStyleGeneric,
    CTUserSettingsStyleRyanair
};

@interface CTUserSettingsState : NSObject

@property (nonatomic) NSString *clientID;

@property (nonatomic) NSString *languageCode;
@property (nonatomic) NSString *currencyCode;
@property (nonatomic) NSString *countryCode;

@property (nonatomic) BOOL debugMode;
@property (nonatomic) BOOL loggingEnabled;

@property (nonatomic) CTUserSettingsStyle selectedStyle;
@property (nonatomic) UIColor *primaryColor;
@property (nonatomic) UIColor *secondaryColor;
@property (nonatomic) UIColor *illustrationColor;

@property (nonatomic) BOOL scrollAboveKeyboard;
@property (nonatomic) BOOL keyboardShowing;
@property (nonatomic) NSNumber *keyboardHeight;

@end
