//
//  CartrawlerRental.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 16/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CartrawlerSDK/CartrawlerSDK.h"
#import "CTSearchDetailsViewController.h"

FOUNDATION_EXPORT double CartrawlerRentalVersionNumber;

FOUNDATION_EXPORT const unsigned char CartrawlerRentalVersionString[];

NS_ASSUME_NONNULL_BEGIN

@protocol CartrawlerRentalDelegate <NSObject>

@optional
- (void)didBookVehicle:(CTBooking *)booking;

@end

@interface CartrawlerRental : NSObject

//---Car Rental View Controllers ---
@property (nonatomic, strong, nonnull, readonly) CTViewController *searchDetailsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *vehicleSelectionViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *vehicleDetailsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *insuranceViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *extrasViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *driverDetialsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *addressDetialsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *paymentSummaryViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *paymentCompletionViewController;
//----------------------------------

@property (nonatomic, strong, nonnull, readonly) CartrawlerSDK *cartrawlerSDK;

//---CarRentalWithFlightDetails---
typedef void (^CarRentalWithFlightDetailsCompletion)(BOOL success, NSString *errorMessage);

//--Delegate--
@property (nonatomic, weak) id<CartrawlerRentalDelegate> delegate;


/**
 Designated initialiser

 @param cartrawlerSDK The Cartrawler SDK object
 @return CartrawlerRental
 */
- (instancetype)initWithCartrawlerSDK:(nonnull CartrawlerSDK *)cartrawlerSDK;

/**
 *  Presents the car rental engine modally in the designated UIViewController
 *
 *  @param viewController The parent view controller
 *  @param clientID Your Client ID
 */
- (void)presentCarRentalInViewController:(UIViewController *)viewController withClientID:(NSString *)clientID;

@end

NS_ASSUME_NONNULL_END
