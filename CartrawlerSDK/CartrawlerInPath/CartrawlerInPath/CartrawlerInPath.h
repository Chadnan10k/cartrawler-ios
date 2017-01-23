//
//  CartrawlerInPath.h
//  CartrawlerInPath
//
//  Created by Lee Maguire on 14/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerRental/CartrawlerRental.h>
#import "CTInPathVehicle.h"
#import "CTInPathPayment.h"

//! Project version number for CartrawlerInPath.
FOUNDATION_EXPORT double CartrawlerInPathVersionNumber;

//! Project version string for CartrawlerInPath.
FOUNDATION_EXPORT const unsigned char CartrawlerInPathVersionString[];

NS_ASSUME_NONNULL_BEGIN

@protocol CartrawlerInPathDelegate <NSObject>

@required
- (void)didProduceInPathRequest:(nonnull NSDictionary *)request vehicle:(nonnull CTInPathVehicle *)vehicle;

@optional
- (void)didReceiveBestDailyRate:(NSNumber *)price currency:(NSString *)currency;
- (void)didFailToReceiveBestDailyRate;

@end

@interface CartrawlerInPath : NSObject

@property (nonatomic, weak) id<CartrawlerInPathDelegate> delegate;

- (instancetype)initWithCartrawlerRental:(nonnull CartrawlerRental *)cartrawlerRental
                                IATACode:(nonnull NSString *)IATACode
                              pickupDate:(nullable NSDate *)pickupDate
                              returnDate:(nullable NSDate *)returnDate
                             userDetails:(nullable CTUserDetails *)userDetails;

- (void)presentCarRentalWithFlightDetails:(nonnull UIViewController *)parentViewController;

- (void)addCrossSellCardToView:(UIView *)view;

- (void)removeVehicle;

- (void)didReceiveBookingConfirmationID:(NSString *)confirmationID;

@end

NS_ASSUME_NONNULL_END

