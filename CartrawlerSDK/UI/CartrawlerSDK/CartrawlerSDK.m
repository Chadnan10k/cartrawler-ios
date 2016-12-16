//
//  CartrawlerSDK.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//


#import "CartrawlerSDK.h"
#import "CTSDKSettings.h"

@interface CartrawlerSDK()

@end

@implementation CartrawlerSDK

+ (instancetype)instance
{
    static CartrawlerSDK *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CartrawlerSDK alloc] init];
    });
    return sharedInstance;
}

- (instancetype)initWithRequestorID:(NSString *)requestorID
                       languageCode:(NSString *)languageCode
                        sandboxMode:(BOOL)sandboxMode;
{
    self = [super init];
    [[CTSDKSettings instance] setClientId:requestorID languageCode:languageCode isDebug:sandboxMode];
    
    _cartrawlerAPI = [[CartrawlerAPI alloc] initWithClientKey:[CTSDKSettings instance].clientId
                                                     language:[CTSDKSettings instance].languageCode
                                                        debug:[CTSDKSettings instance].isDebug];
    if (sandboxMode) {
        [self.cartrawlerAPI enableLogging:YES];
    }

    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    return self;
}

+ (CTAppearance *)appearance
{
    return [CTAppearance instance];
}

- (CTViewController *)configureViewController:(nonnull CTViewController *)viewController
                         validationController:(nonnull CTValidation *)validationController
                                  destination:(nullable CTViewController *)destination
                                     fallback:(nullable CTViewController *)fallback
                                optionalRoute:(nullable CTViewController *)optionalRoute
                                       search:(nonnull id<NSObject>)search
                                       target:(id)target
{
    viewController.destinationViewController = destination;
    viewController.fallbackViewController = fallback;
    viewController.optionalRoute = optionalRoute;
    viewController.cartrawlerAPI = self.cartrawlerAPI;
    viewController.delegate = target;
    viewController.search = search;
    viewController.validationController = validationController;
    return viewController;
}

#pragma mark Push Notifications

+ (void)registerForPushNotifications:(NSData *)deviceToken
{
    //send call to server
}

+ (void)didReceivePushNotification:(NSDictionary *)notification
{
    //open booking info
}

#pragma Crash handling

void uncaughtExceptionHandler(NSException *exception)
{
    NSLog(@"\n\n\nCartrawlerSDK Crash:\n%@\n\n\n", exception);
    NSLog(@"\n\n\nCartrawlerSDK Stack Trace:\n\n\n%@", exception.callStackSymbols);
}


@end
