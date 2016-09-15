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
        [sharedInstance setClientId:@"" languageCode:@"" isDebug:YES];
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
    
    self.languageCode = languageCode;
    self.currencyCode = currency;
    self.homeCountryCode = countryCode;
    
    self.homeCountryName = country;
    self.currencyName = currency;
    self.languageName = languageCode;
    
    if (isDebug) {
        _target = @"Test";
    } else {
        _target = @"Production";
    }
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
@end
