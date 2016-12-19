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
#import "CTLabel.h"
#import "CTNextButton.h"
#import "CTSDKSettings.h"
#import "CartrawlerSDK+NSNumber.h"
#import "CTImageView.h"
#import "CartrawlerSDK+UIImageView.h"
#import "CTImageCache.h"
#import "CTLocalisedStrings.h"
#import "CTRentalBooking.h"
#import "CTCalendarViewController.h"
#import "Reachability.h"
#import "PaymentRequest.h"
#import "CTTextField.h"
#import "NSStringUtils.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CartrawlerSDK+UIColor.h"
#import "CartrawlerSDK+UITextField.h"
#import "CartrawlerSDK+UIView.h"
#import "CartrawlerSDK+WKWebView.h"
#import "CTButton.h"
#import "CTCheckbox.h"
#import "CTCSVItem.h"
#import "CTDataStore.h"
#import "CTFlightNumberValidation.h"
#import "CTHTMLParser.h"
#import "CTLayoutConstraint.h"
#import "CTNavigationBar.h"
#import "CTNavigationItem.h"
#import "CTNavigationView.h"
#import "CTView.h"
#import "CTNavigationController.h"
#import "CTPaymentCheck.h"
#import "CTPaymentView.h"
#import "CTPlaceholderView.h"
#import "CTSegmentedControl.h"
#import "CTSelectView.h"
#import "CTStepper.h"
#import "CTPickerView.h"
#import "CTTagManager.h"
#import "CTTextView.h"
#import "CTTimePickerView.h"
#import "CTToolTip.h"
#import "CTToolTipButton.h"
#import "CTToolTipViewController.h"


FOUNDATION_EXPORT double CartrawlerSDKVersionNumber;

FOUNDATION_EXPORT const unsigned char CartrawlerSDKVersionString[];

NS_ASSUME_NONNULL_BEGIN

@protocol CartrawlerSDKDelegate <NSObject>

@optional
//Standalone
- (void)didBookVehicle:(CTBooking *)booking;

@end

@interface CartrawlerSDK : NSObject

//---Car Rental View Controllers ---
@property (nonatomic, strong, nonnull, readonly) CTViewController *searchDetailsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *vehicleSelectionViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *vehicleDetailsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *insuranceExtrasViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *extrasViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *driverDetialsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *addressDetialsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *paymentSummaryViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *paymentViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *paymentCompletionViewController;
//----------------------------------

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

- (CTViewController *)configureViewController:(nonnull CTViewController *)viewController
                         validationController:(nonnull CTValidation *)validationController
                                  destination:(nullable CTViewController *)destination
                                     fallback:(nullable CTViewController *)fallback
                                optionalRoute:(nullable CTViewController *)optionalRoute
                                       search:(nonnull id<NSObject>)search
                                       target:(id)target;

@end

NS_ASSUME_NONNULL_END
