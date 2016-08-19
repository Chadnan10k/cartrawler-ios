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

#import "VehicleSelectionViewController.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
#error This version (1.0.0) of CartrawlerSDK for iOS supports iOS 7.0 upwards.
#endif

NS_ASSUME_NONNULL_BEGIN

@interface CartrawlerSDK : NSObject

@property (nonatomic, strong, readonly) CTViewController *searchDetailsViewController;
@property (nonatomic, strong, readonly) CTViewController *vehicleSelectionViewController;
@property (nonatomic, strong, readonly) CTViewController *vehicleDetailsViewController;
@property (nonatomic, strong, readonly) CTViewController *insuranceExtrasViewController;
@property (nonatomic, strong, readonly) CTViewController *paymentSummaryViewController;
@property (nonatomic, strong, readonly) CTViewController *driverDetialsViewController;
@property (nonatomic, strong, readonly) CTViewController *paymentViewController;
@property (nonatomic, strong, readonly) CTViewController *paymentCompletionViewController;

/**
 *  Initialize the CartrawlerAPI
 *
 *  @param requestorID  Your requester ID
 *  @param languageCode The initial language code eg. EN
 *  @param isDebug      Flag to indicate if you want to point to test or production endpoints
 *
 */
- (instancetype)initWithRequestorID:(NSString *)requestorID
                       languageCode:(NSString *)languageCode
                            isDebug:(BOOL)isDebug;

/**
 *  Use CTAppearance for overriding the preset views color scheme
 *
 */
+ (CTAppearance *)appearance;

/**
 *  Presents the car rental engine modally in the designated UIViewController
 *
 *  @param viewController The parent view controller
 */
- (void)presentCarRentalInViewController:(UIViewController *)viewController;

/**
 *  Presents the ground transport engine modally in the designated UIViewController
 *
 *  @param viewController
 */
- (void)presentGroundTransportInViewController:(UIViewController *)viewController;

/*  ----------------------------------------------------------------------------
 *  View Controller Overriding:
 *  You can set a custom view for any step of the user journey by subclassing
 *  the designated step view controller.
 *
 *  You must set all of the properties of the step view controller in order to
 *  push to the next view.
 *  ----------------------------------------------------------------------------
 */

/**
 *  Override the initial Search Details View Controller
 *
 *  @param viewController A CTViewController subclass with its viewType set to ViewTypeSearchDetails
 */
- (void)overrideSearchDetailsViewController:(CTViewController *)viewController;

/**
 *  Override the vehicle selection view controller
 *
 *  @param viewController A CTViewController subclass with its viewType set to ViewTypeVehicleSelection
 */
- (void)overrideVehicleSelectionViewController:(CTViewController *)viewController;

/**
 *  Override the vehicle details view controller
 *
 *  @param viewController A CTViewController subclass with its viewType set to ViewTypeGeneric
 */
- (void)overrideVehicleDetailsViewController:(CTViewController *)viewController;

/**
 *  Override the insurance & extras view controller
 *
 *  @param viewController A CTViewController subclass with its viewType set to ViewTypeInsurance
 */
- (void)overrideInsuranceExtrasViewController:(CTViewController *)viewController;

/**
 *  Override the payment summary view controller
 *
 *  @param viewController A CTViewController subclass with its viewType set to ViewTypeGeneric
 */
- (void)overridePaymentSummaryViewController:(CTViewController *)viewController;

/**
 *  Override the driver details view controller
 *
 *  @param viewController A CTViewController subclass with its viewType set to ViewTypeDriverDetails
 */
- (void)overrideDriverDetialsViewController:(CTViewController *)viewController;

/**
 *  Override the success / failure view for payment
 *
 *  @param viewController A CTViewController subclass with its viewType set to ViewTypeGeneric
 */
- (void)overridePaymentCompletionViewController:(CTViewController *)viewController;

/**
 *  If you have created every view from scratch you can set them easily by passing them all into an array
 *  The array MUST however contain these ViewTypes:
 *
 *  ViewTypeSearchDetails,
 *  ViewTypeVehicleSelection,
 *  ViewTypeInsurance,
 *  ViewTypeDriverDetails,
 *
 *
 * @param carRentalViews An array of CTViewController's
 */
- (void)setCarRentalViewsFromArray:(NSArray <CTViewController *> *)carRentalViews;

- (void)rerouteViewController:(CTViewController *)viewController
                  destination:(CTViewController *)destination
                     fallback:(CTViewController *)fallback;

@end

NS_ASSUME_NONNULL_END
