//
//  CartrawlerSDK.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "CTAppearance.h"
#import "CTViewController.h"
#import "CTRentalBooking.h"

FOUNDATION_EXPORT double CartrawlerSDKVersionNumber;

FOUNDATION_EXPORT const unsigned char CartrawlerSDKVersionString[];

NS_ASSUME_NONNULL_BEGIN

@protocol CartrawlerSDKDelegate <NSObject>

@optional
//Standalone
- (void)didBookVehicle:(CTBooking *)booking;
- (void)didCancelVehicleBooking;
//In Path
- (void)didGenerateInPathRequest:(NSDictionary *)request vehicle:(CTInPathVehicle *)vehicle;


@end

@interface CartrawlerSDK : NSObject

//---CarRentalWithFlightDetails---
typedef void (^CarRentalWithFlightDetailsCompletion)(BOOL success, NSString *errorMessage);

//--Delegate--
@property (nonatomic, weak) id<CartrawlerSDKDelegate> delegate;

//Shared instance
+ (instancetype)instance;

/**
 *  Initialize the CartrawlerAPI
 *
 *  @param requestorID  Your requester ID
 *  @param languageCode The initial language code eg. EN
 *  @param sandboxMode      Flag to indicate if you want to point to test or production endpoints
 *
 */
- (void)setRequestorID:(NSString *)requestorID
          languageCode:(NSString *)languageCode
           sandboxMode:(BOOL)sandboxMode;

/**
 *  Use CTAppearance for overriding the preset views color scheme
 */
+ (CTAppearance *)appearance;

/**
 *  Presents the car rental engine modally in the designated UIViewController
 *
 *  @param viewController The parent view controller
 */
- (void)presentCarRentalInViewController:(UIViewController *)viewController;

/**
 *  Presents the car rental engine modally in the designated UIViewController, with predefined user details
 *
 *  @param viewController The parent view controller
 */
- (void)presentCarRentalWithFlightDetails:(nonnull NSString *)IATACode
                               pickupDate:(nullable NSDate *)pickupDate
                               returnDate:(nullable NSDate *)returnDate
                                firstName:(nullable NSString *)firstName
                                  surname:(nullable NSString *)surname
                                driverAge:(nullable NSNumber *)driverAge
                     additionalPassengers:(nullable NSNumber *)additionalPassengers
                                    email:(nullable NSString *)email
                                    phone:(nullable NSString *)phone
                                 flightNo:(nullable NSString *)flightNo
                             addressLine1:(nullable NSString *)addressLine1
                             addressLine2:(nullable NSString *)addressLine2
                                     city:(nullable NSString *)city
                                 postcode:(nullable NSString *)postcode
                              countryCode:(nullable NSString *)countryCode
                              countryName:(nullable NSString *)countryName
                          isInPathBooking:(BOOL)isInPathBooking
                       overViewController:(nonnull UIViewController *)viewController
                               completion:(CarRentalWithFlightDetailsCompletion)completion;

- (void)didMakeInPathBooking:(NSDictionary *)cartrawlerResponse;

@end

NS_ASSUME_NONNULL_END
