//
//  CartrawlerSDK.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CTHeaders.h"

FOUNDATION_EXPORT double CartrawlerSDKVersionNumber;

FOUNDATION_EXPORT const unsigned char CartrawlerSDKVersionString[];

NS_ASSUME_NONNULL_BEGIN

@protocol CartrawlerSDKDelegate <NSObject>

@optional
//Standalone
- (void)didBookVehicle:(CTBooking *)booking;

@end

@protocol CTExternalAnalyticsDelegate <NSObject>

- (void)didReceiveEvent:(CTAnalyticsEvent *)event;

- (void)didReceiveSaleEvent:(CTAnalyticsEvent *)event;

@end

@interface CartrawlerSDK : NSObject

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

//---CarRentalWithFlightDetails---
typedef void (^CarRentalWithFlightDetailsCompletion)(BOOL success, NSString *errorMessage);

//--Delegate--
@property (nonatomic, weak) id<CartrawlerSDKDelegate> delegate;

/**
 *  Initialize the CartrawlerAPI
 *
 *  @param requestorID  Your requester ID
 *  @param languageCode The initial language code eg. EN
 *  @param sandboxMode  Flag to indicate if you want to point to test or production endpoints
 *
 */
- (instancetype)initWithRequestorID:(NSString *)requestorID
                  languageCode:(NSString *)languageCode
                   sandboxMode:(BOOL)sandboxMode;

- (void)enableLogs:(BOOL)enable;

- (void)addAnalyticsProvider:(NSObject<CTExternalAnalyticsDelegate> *)analyticsProvider;

/**
 *  Manual way of sending an analytics event
 *
 *  @param event The analytics event
 *
 */
- (void)sendAnalyticsEvent:(CTAnalyticsEvent *)event;

/**
 *  Manual way of sending a sale event for analytics purposes
 *
 *  @param event The analytics event
 *
 */
- (void)sendAnalyticsSaleEvent:(CTAnalyticsEvent *)event;

/**
 *  Use CTAppearance for overriding the preset views color scheme
 */
+ (CTAppearance *)appearance;

- (CTViewController *)configureViewController:(nonnull CTViewController *)viewController
                         validationController:(nonnull CTValidation *)validationController
                                  destination:(nullable CTViewController *)destination
                                     fallback:(nullable CTViewController *)fallback
                                optionalRoute:(nullable CTViewController *)optionalRoute
                                       search:(CTRentalSearch *)search
                                       target:(id)target;

@end

NS_ASSUME_NONNULL_END
