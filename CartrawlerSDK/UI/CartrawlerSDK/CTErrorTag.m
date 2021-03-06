//
//  CTErrorTag.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 09/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTErrorTag.h"
#import "CTSDKSettings.h"

@implementation CTErrorTag
/*
https://ct-errs.cartrawler.com/
 v5log?app=MO&ver=5.2.50-2&lvl=info&dv=Andriod&action=step1&subAction=search&desc=SocketTimeout&elID=0106135906047112110&clientID=424084&target=Production
 */

- (instancetype)init:(NSString *)version
                step:(NSString *)step
               event:(NSString *)event
             message:(NSString *)message
        engineLoadID:(NSString *)engineLoadID
            clientId:(NSString *)clientId
              target:(NSString *)target
{
    self = [super init];
    
    _version = version;
    _step = step;
    _event = event;
    _message = message;
    _engineLoadID = engineLoadID;
    _clientId = clientId;
    _target = target;
    
    return self;
}


- (NSURL *)produceURL
{
    NSString *escapedStep = [self.step stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *escapedEvent = [self.event stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *escapedMessage = [self.message stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *url = [NSString stringWithFormat:@"%@?app=MO&ver=%@&lvl=%@&dv=iOS&action=%@&subAction=%@&desc=%@&elID=%@&clientID=%@&target=%@&lang=%@&debug=%@",
                     @"https://ct-errs.cartrawler.com/v5log",
                     self.version,
                     [self levelString:self.level],
                     escapedStep,
                     escapedEvent,
                     escapedMessage,
                     self.engineLoadID,
                     self.clientId,
                     self.target,
                     [CTSDKSettings instance].languageCode,
                     ([CTSDKSettings instance].isDebug ? @"DEBUG" : @"PRODUCTION")];
    
    return [NSURL URLWithString:url];
}

- (NSString *)levelString:(CTErrorLevel)level
{
    switch (level) {
    case CTErrorLevelInfo:
        return @"Info";
    case CTErrorLevelError:
        return @"Error";
    }
}

@end
