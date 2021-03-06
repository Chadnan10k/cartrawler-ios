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

@property (nonatomic, strong) NSMutableArray <CTExternalAnalyticsDelegate> *analyticsProviders;

@end

@implementation CartrawlerSDK

- (instancetype)initWithlanguageCode:(NSString *)languageCode
                         sandboxMode:(BOOL)sandboxMode
{
    self = [super init];
    [[CTSDKSettings instance] setClientId:@"" languageCode:languageCode isDebug:sandboxMode];
    
    _cartrawlerAPI = [[CartrawlerAPI alloc] initWithClientKey:[CTSDKSettings instance].clientId
                                                     language:[CTSDKSettings instance].languageCode
                                                        debug:[CTSDKSettings instance].isDebug];
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    return self;
}

- (void)enableLogs:(BOOL)enable
{
    [self.cartrawlerAPI enableLogging:enable];
}

- (void)setNewSession
{
    [self.cartrawlerAPI changeClientKey:[CTSDKSettings instance].clientId];
    
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

#pragma mark Analytics

- (void)addAnalyticsProvider:(NSObject<CTExternalAnalyticsDelegate> *)analyticsProvider
{
    if (self.analyticsProviders) {
        //check doesnt already exist
        for (NSObject<CTExternalAnalyticsDelegate> *obj in self.analyticsProviders) {
            //check for memory reference
            if (obj == analyticsProvider) {
                return;
            }
            //check for class name
            if ([NSStringFromClass([obj class]) isEqualToString:NSStringFromClass([analyticsProvider class])]) {
                return;
            }
        }
        [self.analyticsProviders addObject:analyticsProvider];
        
    } else {
        _analyticsProviders = [NSMutableArray<CTExternalAnalyticsDelegate> new];
        [self.analyticsProviders addObject:analyticsProvider];
    }
}

#pragma mark CTExternalAnalyticsDelegate

- (void)sendAnalyticsEvent:(CTAnalyticsEvent *)event
{
    if (self.analyticsProviders) {
        for (NSObject<CTExternalAnalyticsDelegate> *obj in self.analyticsProviders) {
            if (obj && [obj respondsToSelector:@selector(didReceiveEvent:)]) {
                [obj didReceiveEvent:event];
            }
        }
    }
}

- (void)sendAnalyticsSaleEvent:(CTAnalyticsEvent *)event
{
    if (self.analyticsProviders) {
        for (NSObject<CTExternalAnalyticsDelegate> *obj in self.analyticsProviders) {
            if (obj && [obj respondsToSelector:@selector(didReceiveSaleEvent:)]) {
                [obj didReceiveSaleEvent:event];
            }
        }
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
