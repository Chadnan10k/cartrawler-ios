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
    _clientId = clientId;
    _languageCode = languageCode;
    _isDebug = isDebug;
}

- (void)setLanguageCode:(NSString *)languageCode
{
    _languageCode = languageCode;
}

@end
