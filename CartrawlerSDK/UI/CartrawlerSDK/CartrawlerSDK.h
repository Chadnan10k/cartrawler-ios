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

@end

@interface CartrawlerSDK : NSObject

//---CarRentalWithFlightDetails---
typedef void (^CarRentalWithFlightDetailsCompletion)(BOOL success, NSString *errorMessage);

//--Delegate--
@property (nonatomic, weak) id<CartrawlerSDKDelegate> delegate;

//---Car Rental View Controllers ---
@property (nonatomic, strong, nonnull, readonly) CTViewController *searchDetailsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *vehicleSelectionViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *vehicleDetailsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *insuranceExtrasViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *driverDetialsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *addressDetialsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *paymentSummaryViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *paymentViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *paymentCompletionViewController;
//----------------------------------

//---Ground Transport View Controllers---
@property (nonatomic, strong, nonnull, readonly) CTViewController *gtSearchDetailsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *gtServiceSelectionViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *gtPassengerDetailsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *gtAddressDetailsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *gtPaymentViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *gtPaymentCompletionViewController;
//---------------------------------------


/**
 *  Initialize the CartrawlerAPI
 *
 *  @param requestorID  Your requester ID
 *  @param languageCode The initial language code eg. EN
 *  @param sandboxMode      Flag to indicate if you want to point to test or production endpoints
 *
 */
- (instancetype)initWithRequestorID:(NSString *)requestorID
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
- (void)presentCarRentalInViewController:(UIViewController *)viewController
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
                                postcode:(NSString *)postcode;

/**
 *  Presents the ground transport engine modally in the designated UIViewController
 *
 *  @param viewController The parent view controller
 */
- (void)presentGroundTransportInViewController:(UIViewController *)viewController;

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
                       overViewController:(UIViewController *)viewController
                               completion:(CarRentalWithFlightDetailsCompletion)completion;

/**
 *  Register the CartrawlerSDK to use push notifications so information can be sent to your customer about their booking
 *
 *  @param deviceToken The iOS device token taken from the AppDelegate
 */
+ (void)registerForPushNotifications:(NSData *)deviceToken;

/**
 *  Presents a view showing the user information about their upcoming booking
 *
 *  @param notification The dictionary with notification information
 */
+ (void)didReceivePushNotification:(NSDictionary *)notification;


/*  ----------------------------------------------------------------------------
 *  View Controller Overriding:
 *  You can set a custom view for any step of the user journey by subclassing
 *  CTViewController
 *
 *  You must set all of the required properties of the search in order to
 *  push to the next view.
 *  ----------------------------------------------------------------------------
 */

/**
 *  Override the initial Search Details View Controller
 *
 *  @param viewController A CTViewController subclass
 */
- (void)overrideSearchDetailsViewController:(CTViewController *)viewController;

/**
 *  Override the vehicle selection view controller
 *
 *  @param viewController A CTViewController subclass
 */
- (void)overrideVehicleSelectionViewController:(CTViewController *)viewController;

/**
 *  Override the vehicle details view controller
 *
 *  @param viewController A CTViewController subclass
 */
- (void)overrideVehicleDetailsViewController:(CTViewController *)viewController;

/**
 *  Override the insurance & extras view controller
 *
 *  @param viewController A CTViewController subclass
 */
- (void)overrideInsuranceExtrasViewController:(CTViewController *)viewController;

/**
 *  Override the payment summary view controller
 *
 *  @param viewController A CTViewController subclass
 */
- (void)overridePaymentSummaryViewController:(CTViewController *)viewController;

/**
 *  Override the driver details view controller
 *
 *  @param viewController A CTViewController subclass
 */
- (void)overrideDriverDetialsViewController:(CTViewController *)viewController;

/**
 *  Override the address details view controller
 *
 *  @param viewController A CTViewController subclass
 */
- (void)overrideAddressDetialsViewController:(CTViewController *)viewController;

/**
 *  Override the success view for payment
 *
 *  @param viewController A CTViewController subclass
 */
- (void)overridePaymentCompletionViewController:(CTViewController *)viewController;

/**
 *  Reroute the destination of a CTViewController
 *
 *  @param viewController The CTViewController you would like to edit
 *  @param destination    The destination for this CTViewController
 */
- (void)rerouteViewController:(CTViewController *)viewController
                  destination:(CTViewController *)destination;

@end

NS_ASSUME_NONNULL_END
