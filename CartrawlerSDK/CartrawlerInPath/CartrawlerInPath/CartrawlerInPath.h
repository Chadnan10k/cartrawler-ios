//
//  CartrawlerInPath.h
//  CartrawlerInPath
//
//  Created by Lee Maguire on 14/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerSDK/CartrawlerSDK.h>
#import "CTInPathVehicle.h"

//! Project version number for CartrawlerInPath.
FOUNDATION_EXPORT double CartrawlerInPathVersionNumber;

//! Project version string for CartrawlerInPath.
FOUNDATION_EXPORT const unsigned char CartrawlerInPathVersionString[];

NS_ASSUME_NONNULL_BEGIN

@protocol CartrawlerInPathDelegate <NSObject>

@required
- (void)didProduceInPathRequest:(nonnull NSDictionary *)request vehicle:(nonnull CTInPathVehicle *)vehicle;

@end

@interface CartrawlerInPath : NSObject

@property (nonatomic, weak) id<CartrawlerInPathDelegate> delegate;

- (instancetype)initWithCartrawlerSDK:(nonnull CartrawlerSDK *)cartrawlerSDK;

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
                       overViewController:(nonnull UIViewController *)viewController
                               completion:(nonnull CarRentalWithFlightDetailsCompletion)completion;

- (void)addCrossSellCardToView:(UIView *)view;
- (void)removeVehicle;

- (void)didReceiveBookingResponse:(NSDictionary *)response;

@end

NS_ASSUME_NONNULL_END

