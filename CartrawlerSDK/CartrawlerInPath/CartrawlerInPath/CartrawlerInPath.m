//
//  CartrawlerInPath.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 15/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerInPath.h"
#import <CartrawlerSDK/CTSDKSettings.h>
#import <CartrawlerRental/CTSearchDetailsViewController.h>
#import <CartrawlerSDK/CTNavigationController.h>
#import <CartrawlerSDK/CTDataStore.h>
#import "CTInPathPayment.h"
#import "CTInPathView.h"

@interface CartrawlerInPath()

@property (nonatomic, strong) CartrawlerRental *rental;
@property (nonatomic, strong) CTInPathView *cardView;

@end

@implementation CartrawlerInPath

- (instancetype)initWithCartrawlerRental:(nonnull CartrawlerRental *)cartrawlerRental
{
    self = [super init];
    _rental = cartrawlerRental;
    return self;
}

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
                               completion:(nonnull CarRentalWithFlightDetailsCompletion)completion
{
    [[CTRentalSearch instance] reset];
    
    [[CTSDKSettings instance] setHomeCountryCode:countryCode];
    [[CTSDKSettings instance] setHomeCountryName:countryName];
    
    [CTRentalSearch instance].pickupDate = pickupDate;
    [CTRentalSearch instance].dropoffDate = returnDate;
    [CTRentalSearch instance].firstName = firstName;
    [CTRentalSearch instance].surname = surname;
    [CTRentalSearch instance].passengerQty = [NSNumber numberWithInt:1 + additionalPassengers.intValue];
    [CTRentalSearch instance].driverAge = driverAge;
    [CTRentalSearch instance].email = email;
    [CTRentalSearch instance].phone = phone;
    [CTRentalSearch instance].flightNumber = flightNo;
    [CTRentalSearch instance].addressLine1 = addressLine1;
    [CTRentalSearch instance].addressLine2 = addressLine2;
    [CTRentalSearch instance].city = city;
    [CTRentalSearch instance].postcode = postcode;
    [CTRentalSearch instance].country = countryCode;
    
    [self.rental.cartrawlerSDK.cartrawlerAPI locationSearchWithAirportCode:IATACode completion:^(CTLocationSearch *response, CTErrorResponse *error) {
        if (error) {
            if (completion) {
                completion(NO, error.errorMessage);
            }
        } else {
            if (response) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(response.matchedLocations.count > 0) {
                        [CTRentalSearch instance].pickupLocation = response.matchedLocations.firstObject;
                        [CTRentalSearch instance].dropoffLocation = response.matchedLocations.firstObject;
                        [self configureViews];
                        [self presentRentalNavigationController:viewController];
                        
                        if (completion) {
                            completion(YES, @"");
                        }
                        
                    } else {
                        if (completion) {
                            completion(NO, @"Airport not found");
                        }
                    }
                });
            }
        }
    }];

}
 
//Lets take what views we need for the nav stack
- (void)configureViews
{
    //The sdk handles most of the routing, but for in path we only need to display up to payment summary,
    //so lets nil the summary destination so it will dismiss
    self.rental.paymentSummaryViewController.destinationViewController = nil;
    self.rental.paymentSummaryViewController.fallbackViewController = nil;
    self.rental.paymentSummaryViewController.optionalRoute = nil;
    self.rental.paymentSummaryViewController.delegate = self;
}

- (void)presentRentalNavigationController:(UIViewController *)parent
{
    CTNavigationController *navController = [[CTNavigationController alloc] init];
    navController.navigationBar.hidden = YES;
    navController.modalPresentationStyle = [CTAppearance instance].modalPresentationStyle;
    navController.modalTransitionStyle = [CTAppearance instance].modalTransitionStyle;
    [navController setViewControllers:@[self.rental.searchDetailsViewController]];
    [parent presentViewController:navController animated:[CTAppearance instance].presentAnimated completion:nil];
    if ([CTRentalSearch instance].pickupDate && [CTRentalSearch instance].dropoffDate) {
        [(CTSearchDetailsViewController *)self.rental.searchDetailsViewController performSearch];
    }
}

- (void)addCrossSellCardToView:(UIView *)view
{
    if (!self.cardView) {
        _cardView = [[CTInPathView alloc] initWithFrame:CGRectZero];
        self.cardView.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:self.cardView];
        [self.cardView renderDefault];
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"view" : self.cardView}]];
        
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"view" : self.cardView}]];
    }
}

- (void)removeVehicle
{
    if (self.cardView) {
        [self.cardView renderDefault];
    }
}

- (void)didReceiveBookingResponse:(NSDictionary *)response
{
    NSString *testRes = response[@"bookingId"];
    [CTDataStore didMakeInPathBooking:testRes];
}

#pragma mark CTViewController Delegate

- (void)didDismissViewController:(NSString *)identifier
{
    CTRentalSearch *search = [CTRentalSearch instance];
    CTRentalBooking *booking = [[CTRentalBooking alloc] initFromSearch:search];
    CTInPathVehicle *vehicle = [[CTInPathVehicle alloc] init:search];
    [self.cardView renderVehicleDetails:vehicle];

    if (self.delegate && [self.delegate respondsToSelector:@selector(didProduceInPathRequest:vehicle:)]) {
        [CTDataStore cachePotentialInPathBooking:booking];
        [self.delegate didProduceInPathRequest:[CTInPathPayment createInPathRequest:search]
                                       vehicle:[[CTInPathVehicle alloc] init:search]];
    }
}

@end
