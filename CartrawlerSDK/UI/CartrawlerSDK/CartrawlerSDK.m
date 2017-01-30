//
//  CartrawlerSDK.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//


#import "CartrawlerSDK.h"
#import "CTSDKSettings.h"

@interface CartrawlerSDK() <CTAnalyticsDelegate>

@end

@implementation CartrawlerSDK

- (instancetype)initWithRequestorID:(NSString *)requestorID
                       languageCode:(NSString *)languageCode
                        sandboxMode:(BOOL)sandboxMode;
{
    self = [super init];
    [[CTSDKSettings instance] setClientId:requestorID languageCode:languageCode isDebug:sandboxMode];
    
    _cartrawlerAPI = [[CartrawlerAPI alloc] initWithClientKey:[CTSDKSettings instance].clientId
                                                     language:[CTSDKSettings instance].languageCode
                                                        debug:[CTSDKSettings instance].isDebug];
    [self setNewSession];

    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    return self;
}

- (void)enableLogs:(BOOL)enable
{
    [self.cartrawlerAPI enableLogging:enable];
}

- (void)setNewSession
{
    static int trys;
    [self.cartrawlerAPI requestNewSession:[CTSDKSettings instance].currencyCode
                             languageCode:[CTSDKSettings instance].languageCode
                              countryCode:[CTSDKSettings instance].homeCountryCode
                               completion:^(CT_IpToCountryRS *response, CTErrorResponse *error) {
                                   if (response) {
                                       [CTSDKSettings instance].engineLoadID = response.engineLoadID;
                                       [CTSDKSettings instance].customerID = response.customerID;
                                   } else {
                                       //retry
                                       if (trys < 3) {
                                           [self setNewSession];
                                           ++trys;
                                       }
                                       [[CTAnalytics instance] tagError:@"sdk init" event:@"requestNewSession" message:error.errorMessage];
                                   }
                               }];
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
                                       search:(CTRentalSearch *)search
                                       target:(id)target
{
    viewController.destinationViewController = destination;
    viewController.fallbackViewController = fallback;
    viewController.optionalRoute = optionalRoute;
    viewController.cartrawlerAPI = self.cartrawlerAPI;
    viewController.delegate = target;
    viewController.search = search;
    viewController.validationController = validationController;
    viewController.analyticsDelegate = self;
    return viewController;
}

#pragma mark CTExternalAnalyticsDelegate

- (void)didSendEvent:(CTAnalyticsEvent *)event
{
    if (self.analyticsDelegate && [self.analyticsDelegate respondsToSelector:@selector(didReceiveEvent:)]) {
        [self.analyticsDelegate didReceiveEvent:event];
    }
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
    [[CTAnalytics instance] tagError:@"stepX" event:@"SDK CRASH" message:[NSString stringWithFormat:@"%@", exception.callStackSymbols]];
}

@end
