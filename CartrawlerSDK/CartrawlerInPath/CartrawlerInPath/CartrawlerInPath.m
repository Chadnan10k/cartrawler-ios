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
@property (nonatomic, strong) CTRentalSearch *defaultSearch;

@end

@implementation CartrawlerInPath

- (instancetype)initWithCartrawlerRental:(nonnull CartrawlerRental *)cartrawlerRental
                                IATACode:(nonnull NSString *)IATACode
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
                              completion:(nullable CarRentalWithFlightDetailsCompletion)completion
{
    self = [super init];
    _rental = cartrawlerRental;
    
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
                
                if(response.matchedLocations.count > 0) {
                    [CTRentalSearch instance].pickupLocation = response.matchedLocations.firstObject;
                    [CTRentalSearch instance].dropoffLocation = response.matchedLocations.firstObject;

                    [self.rental.cartrawlerSDK.cartrawlerAPI requestVehicleAvailabilityForLocation:[CTRentalSearch instance].pickupLocation.code
                                                                                returnLocationCode:[CTRentalSearch instance].dropoffLocation.code
                                                                               customerCountryCode:countryCode
                                                                                      passengerQty:@1
                                                                                         driverAge:driverAge
                                                                                    pickUpDateTime:pickupDate
                                                                                    returnDateTime:returnDate
                                                                                      currencyCode:@"EUR"
                                                                                        completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                                                                                            if (response.items.count > 0) {
                                                                                                [CTRentalSearch instance].vehicleAvailability = response;
                                                                                                _defaultSearch = [[CTRentalSearch instance] copy];
                                                                                                NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"vehicle.totalPriceForThisVehicle"
                                                                                                                                                             ascending:YES];
                                                                                                CTAvailabilityItem *cheapestvehicle = ((CTAvailabilityItem *)[response.items sortedArrayUsingDescriptors:@[descriptor]].firstObject);
                                                                                                if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveBestDailyRate:currency:)]) {
                                                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                        [self.delegate didReceiveBestDailyRate:cheapestvehicle.vehicle.totalPriceForThisVehicle currency:cheapestvehicle.vehicle.currencyCode];
                                                                                                    });
                                                                                                }
                                                                                                if (completion) {
                                                                                                    completion(YES, nil);
                                                                                                }
                                                                                            } else {
                                                                                                if (completion) {
                                                                                                    completion(NO, @"No results for car hire");
                                                                                                }
                                                                                            }
                                                                                        }];
                } else {
                    if (completion) {
                        completion(NO, @"Airport not found");
                    }
                }
            }
        }
    }];

    return self;
}

- (void)presentCarRentalWithFlightDetails:(nonnull UIViewController *)parentViewController
{
    [[CTRentalSearch instance] setFromCopy:self.defaultSearch];
    [self configureViews];
    [self presentRentalNavigationController:parentViewController];
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
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"view" : self.cardView}]];
        
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
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
