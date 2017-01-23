//
//  CTSDKSettings.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 17/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTSDKSettings : NSObject

@property (nonatomic, strong) NSString *clientId;

@property (nonatomic, strong) NSString *languageCode;
@property (nonatomic, strong) NSString *languageName;

@property (nonatomic, strong) NSString *currencyCode;
@property (nonatomic, strong) NSString *currencyName;

@property (nonatomic, strong) NSString *homeCountryCode;
@property (nonatomic, strong) NSString *homeCountryName;

@property (nonatomic, strong) NSString *target;

@property (nonatomic, strong, readonly) NSString *version;

@property (nonatomic, strong) NSString *engineLoadID;
@property (nonatomic, strong) NSString *queryID;
@property (nonatomic, strong) NSString *customerID;

@property (nonatomic) BOOL disableCurrencySelection;

@property (nonatomic) BOOL isDebug;

+ (instancetype)instance;

- (void)setClientId:(NSString *)clientId
       languageCode:(NSString *)languageCode
            isDebug:(BOOL)isDebug;

- (void)resetCountryToDeviceLocale;

- (void)setLanguageCode:(NSString *)languageCode;
- (void)setCurrencyCode:(NSString *)currencyCode;
- (void)setHomeCountryCode:(NSString *)homeCountryCode;

- (void)setLanguageName:(NSString *)languageName;
- (void)setCurrencyName:(NSString *)currencyName;
- (void)setHomeCountryName:(NSString *)homeCountryName;

@end
