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
- (void)didBookVehicle:(CTBooking *)booking;
- (void)didCancelVehicleBooking;
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
- (void)presentCarRentalWithFlightDetails:(NSString *)IATACode
                               pickupDate:(NSDate *)pickupDate
                               returnDate:(NSDate *)returnDate
                                firstName:(NSString *)firstName
                                  surname:(NSString *)surname
                                driverAge:(NSNumber *)driverAge
                     additionalPassengers:(NSNumber *)additionalPassengers
                                    email:(NSString *)email
                                    phone:(NSString *)phone
                                 flightNo:(NSString *)flightNo
                             addressLine1:(NSString *)addressLine1
                             addressLine2:(NSString *)addressLine2
                                     city:(NSString *)city
                                 postcode:(NSString *)postcode
                              countryCode:(NSString *)countryCode
                              countryName:(NSString *)countryName
                          isInPathBooking:(BOOL)isInPathBooking
                       overViewController:(UIViewController *)viewController
                               completion:(CarRentalWithFlightDetailsCompletion)completion;

@end

NS_ASSUME_NONNULL_END
