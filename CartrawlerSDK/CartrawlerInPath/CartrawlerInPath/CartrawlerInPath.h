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
#import <CartrawlerSDK/CTPassenger.h>
#import "CTInPathError.h"

//! Project version number for CartrawlerInPath.
FOUNDATION_EXPORT double CartrawlerInPathVersionNumber;

//! Project version string for CartrawlerInPath.
FOUNDATION_EXPORT const unsigned char CartrawlerInPathVersionString[];

NS_ASSUME_NONNULL_BEGIN

@protocol CartrawlerInPathDelegate <NSObject>

@required

/**
 Called when the user chooses to add the vehicle to their basket

 @param request A dictionary containing information about the vehicle and the Cartrawler OTA payment request
 @param vehicle The vehicle that was selected
 */
- (void)didProduceInPathPaymentRequest:(nonnull NSDictionary *)request vehicle:(nonnull CTInPathVehicle *)vehicle;

@optional

/**
 Called when the user taps on the cross sell card
 */
- (void)didTapCrossSellCard;

/**
 Called when the vehicles have been fetched and the best daily rate has been calculated

 @param price the best daily rate
 @param currency the currency
 */
- (void)didReceiveBestDailyRate:(NSNumber *)price currency:(NSString *)currency;

/**
 Called when the call to fetch vehicles fails and the best daily rate cannot be calculated
 */
- (void)didFailToReceiveBestDailyRate;

@end

@interface CartrawlerInPath : NSObject

@property (nonatomic, weak) id<CartrawlerInPathDelegate> delegate;

/**
 Convienience initialiser

 @param cartrawlerRental CartrawlerRental library object
 @return Initialised CartrawlerInPath library
 */
+ (CartrawlerInPath *)initWithCartrawlerRental:(nonnull CartrawlerRental *)cartrawlerRental;

/**
 Performs a search for cars with the provided details

 @param IATACode The pickup airport IATA code
 @param pickupDate The pickup date
 @param returnDate The return date
 @param flightNumber The flight number
 @param currency The currency
 @param passegers An array if CTPassenger's
 @param clientID The client ID you want to do a search request with
 @param parentViewController The view controller you want to display the Cartrawler Engine over
 */
- (void)performSearchWithIATACode:(nonnull NSString *)IATACode
                       pickupDate:(nonnull NSDate *)pickupDate
                       returnDate:(nullable NSDate *)returnDate
                     flightNumber:(nullable NSString *)flightNumber
                         currency:(nonnull NSString *)currency
                        passegers:(nonnull NSArray<CTPassenger *> *)passegers
                         clientID:(nonnull NSString *)clientID
             parentViewController:(nonnull UIViewController *)parentViewController;

/**
 Adds the cross sell card to the view

 @param view a card view
 */
- (void)addCrossSellCardToView:(UIView *)view;

/**
 Presents a modal view controller containing a list of all vehicles available for a search request

 @param parentViewController The view controller you want to display the Cartrawler Engine over
 */
- (void)presentAllCars:(nonnull UIViewController *)parentViewController;

/**
 Removes a vehicle if selected
 */
- (void)removeVehicle;

/**
 Used for when the master app has a successful cartrawler payment request and needs to pass the booking reference back to the In Path library.

 @param confirmationID The confirmation ID or 'Booking reference'
 */
- (void)didReceiveBookingConfirmationID:(NSString *)confirmationID;

@end

NS_ASSUME_NONNULL_END

