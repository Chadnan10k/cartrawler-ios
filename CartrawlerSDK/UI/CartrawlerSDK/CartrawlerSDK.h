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

/**
 *  Presents the car rental engine modally in the designated UIViewController
 *
 *  @param viewController The parent view controller
 */
- (void)presentCarRentalInViewController:(UIViewController *)viewController;

/**
 * If you made a successfull in path booking,
 */
- (void)didMakeInPathBooking:(NSDictionary *)cartrawlerResponse;

@end

NS_ASSUME_NONNULL_END
