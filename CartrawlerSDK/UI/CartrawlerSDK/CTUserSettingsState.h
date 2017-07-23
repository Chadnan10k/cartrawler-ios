//
//  CTUserSettingsState.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/18/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTUserSettingsState : NSObject

@property (nonatomic) NSString *clientID;

@property (nonatomic) NSString *languageCode;
@property (nonatomic) NSString *currencyCode;
@property (nonatomic) NSString *countryCode;

@property (nonatomic) BOOL debugMode;
@property (nonatomic) BOOL loggingEnabled;

@end
