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

@end

@interface CartrawlerInPath : NSObject

typedef void (^CarRentalWithFlightDetailsCompletion)(BOOL success, NSString *errorMessage);

@property (nonatomic, weak) id<CartrawlerInPathDelegate> delegate;

- (instancetype)initWithCartrawlerRental:(nonnull CartrawlerRental *)cartrawlerRental
                                IATACode:(nonnull NSString *)IATACode
                              pickupDate:(nullable NSDate *)pickupDate
                              returnDate:(nullable NSDate *)returnDate
                             userDetails:(nullable CTUserDetails *)userDetails
                            completion:(nullable CarRentalWithFlightDetailsCompletion)completion;

- (void)presentCarRentalWithFlightDetails:(nonnull UIViewController *)parentViewController;

- (void)addCrossSellCardToView:(UIView *)view;

- (void)removeVehicle;

- (void)didReceiveBookingResponse:(NSDictionary *)response;

@end

NS_ASSUME_NONNULL_END

