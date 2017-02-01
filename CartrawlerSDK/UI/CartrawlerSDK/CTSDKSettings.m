//
//  CTSDKSettings.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 17/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSDKSettings.h"

@implementation CTSDKSettings

+ (instancetype)instance
{
    static CTSDKSettings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CTSDKSettings alloc] init];
    });
    return sharedInstance;
}

- (void)setClientId:(NSString *)clientId
       languageCode:(NSString *)languageCode
            isDebug:(BOOL)isDebug
{
    
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
    
    NSString *country = [locale displayNameForKey: NSLocaleCountryCode value: countryCode];
    NSString *currency = [locale objectForKey:NSLocaleCurrencyCode];
    
    _clientId = clientId;
    _isDebug = isDebug;
    
    _languageCode = languageCode;
    _currencyCode = currency;
    _homeCountryCode = countryCode;
    
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    NSDictionary *languageDictionary = [NSLocale componentsFromLocaleIdentifier:language];
    _deviceLanguageCode = [languageDictionary objectForKey:NSLocaleLanguageCode];
    
    _homeCountryName = country;
    _currencyName = currency;
    
    NSArray *languages = [NSLocale preferredLanguages];
    _languageName = [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:languages.firstObject];
    
    if (isDebug) {
        _target = @"Test";
    } else {
        _target = @"Production";
    }
}

- (void)resetCountryToDeviceLocale
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
    NSString *country = [locale displayNameForKey: NSLocaleCountryCode value: countryCode];

    _homeCountryCode = countryCode;
    _homeCountryName = country;
}

- (void)setLanguageCode:(NSString *)languageCode
{
    _languageCode = languageCode;
    [self setItem:languageCode key:@"languageCode"];
}

- (void)setCurrencyCode:(NSString *)currencyCode
{
    _currencyCode = currencyCode;
    [self setItem:currencyCode key:@"currencyCode"];
}

- (void)setHomeCountryCode:(NSString *)homeCountryCode
{
    _homeCountryCode = homeCountryCode;
    [self setItem:homeCountryCode key:@"homeCountryCode"];
}

- (void)setLanguageName:(NSString *)languageName
{
    _languageName = languageName;
    [self setItem:languageName key:@"languageName"];
}

- (void)setCurrencyName:(NSString *)currencyName
{
    _currencyName = currencyName;
    [self setItem:currencyName key:@"currencyName"];
}

- (void)setHomeCountryName:(NSString *)homeCountryName
{
    _homeCountryName = homeCountryName;
    [self setItem:homeCountryName key:@"homeCountryName"];
}

- (NSString *)languageCode_
{
    return [self itemForKey:@"languageCode"];
}

- (NSString *)currencyCode_
{
    return [self itemForKey:@"currencyCode"];
}

- (NSString *)homeCountryCode_
{
    return [self itemForKey:@"homeCountryCode"];
}

- (NSString *)languageName_
{
    return [self itemForKey:@"languageCode"];
}

- (NSString *)currencyName_
{
    return [self itemForKey:@"currencyName"];
}

- (NSString *)homeCountryName_
{
    return [self itemForKey:@"homeCountryName"];
}

- (void)setItem:(NSString *)item key:(NSString *)key
{
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    [d setObject:item forKey:key];
    [d synchronize];
}

- (NSString *)itemForKey:(NSString *)key
{
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    return [d objectForKey:key];
}

- (NSString *)version
{
    NSDictionary *info = [[NSBundle bundleForClass:[self class]] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleShortVersionString"];
    return version;
}

@end
