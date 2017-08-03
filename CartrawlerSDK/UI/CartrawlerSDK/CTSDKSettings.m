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
    
    _languageCode = languageCode ?: @"en";
    _currencyCode = currency;
    _homeCountryCode = countryCode;
    
    _homeCountryName = country;
    _currencyName = currency;
    _languageName = [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:self.languageCode];
	

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
    [self setItem:languageCode key:@"CT_languageCode"];
}

- (void)setCurrencyCode:(NSString *)currencyCode
{
    _currencyCode = currencyCode;
    [self setItem:currencyCode key:@"CT_currencyCode"];
}

- (void)setHomeCountryCode:(NSString *)homeCountryCode
{
    _homeCountryCode = homeCountryCode;
    [self setItem:homeCountryCode key:@"CT_homeCountryCode"];
}

- (void)setLanguageName:(NSString *)languageName
{
    _languageName = languageName;
    [self setItem:languageName key:@"CT_languageName"];
}

- (void)setCurrencyName:(NSString *)currencyName
{
    _currencyName = currencyName;
    [self setItem:currencyName key:@"CT_currencyName"];
}

- (void)setHomeCountryName:(NSString *)homeCountryName
{
    _homeCountryName = homeCountryName;
    [self setItem:homeCountryName key:@"CT_homeCountryName"];
}

- (void)setCustomAttributes:(NSMutableDictionary *)customAttributes {
	_customAttributes = customAttributes;
}

- (NSString *)countryName:(NSString *)countryCode
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *country = [locale displayNameForKey: NSLocaleCountryCode value: countryCode];
    
    _homeCountryName = country;
    [self setItem:country key:@"CT_homeCountryName"];
    
    return country;
}

- (NSString *)languageCode_
{
    return [self itemForKey:@"CT_languageCode"];
}

- (NSString *)currencyCode_
{
    return [self itemForKey:@"CT_currencyCode"];
}

- (NSString *)homeCountryCode_
{
    return [self itemForKey:@"CT_homeCountryCode"];
}

- (NSString *)languageName_
{
    return [self itemForKey:@"CT_languageCode"];
}

- (NSString *)currencyName_
{
    return [self itemForKey:@"CT_currencyName"];
}

- (NSString *)homeCountryName_
{
    return [self itemForKey:@"CT_homeCountryName"];
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
