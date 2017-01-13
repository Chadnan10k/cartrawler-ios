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

@interface CartrawlerInPath() <CTViewControllerDelegate>

@property (nonatomic, strong) CartrawlerRental *rental;
@property (nonatomic, strong) CTInPathView *cardView;
@property (nonatomic, strong) CTRentalSearch *defaultSearch;

@end

@implementation CartrawlerInPath

- (instancetype)initWithCartrawlerRental:(nonnull CartrawlerRental *)cartrawlerRental
                                IATACode:(nonnull NSString *)IATACode
                              pickupDate:(nullable NSDate *)pickupDate
                              returnDate:(nullable NSDate *)returnDate
                             userDetails:(nullable CTUserDetails *)userDetails
{
    self = [super init];
    _rental = cartrawlerRental;
    
    [[CTRentalSearch instance] reset];
    
    if (userDetails.currency) {
        [[CTSDKSettings instance] setCurrencyCode:userDetails.currency];
        [[CTSDKSettings instance] setCurrencyName:userDetails.currency];
    }
    
    if (!userDetails.countryCode || !userDetails.countryName) {
        [CTRentalSearch instance].country = [CTSDKSettings instance].homeCountryCode;
    } else {
        [[CTSDKSettings instance] setHomeCountryCode:userDetails.countryCode];
        [[CTSDKSettings instance] setHomeCountryName:userDetails.countryName];
        [CTRentalSearch instance].country = userDetails.countryCode;
    }

    if (returnDate) {
        [CTRentalSearch instance].dropoffDate = returnDate;
    } else {
        [CTRentalSearch instance].dropoffDate = [pickupDate dateByAddingTimeInterval:259200];//3 days
    }
    
    [CTRentalSearch instance].pickupDate = pickupDate;
    [CTRentalSearch instance].firstName = userDetails.firstName;
    [CTRentalSearch instance].surname = userDetails.surname;
    [CTRentalSearch instance].passengerQty = [NSNumber numberWithInt:1 + userDetails.additionalPassengers.intValue];
    [CTRentalSearch instance].driverAge = userDetails.driverAge;
    [CTRentalSearch instance].email = userDetails.email;
    [CTRentalSearch instance].phone = userDetails.phone;
    [CTRentalSearch instance].flightNumber = [userDetails.flightNo stringByReplacingOccurrencesOfString:@" " withString:@""];
    [CTRentalSearch instance].addressLine1 = userDetails.addressLine1;
    [CTRentalSearch instance].addressLine2 = userDetails.addressLine2;
    [CTRentalSearch instance].city = userDetails.city;
    [CTRentalSearch instance].postcode = userDetails.postcode;
    _defaultSearch = [[CTRentalSearch instance] copy];//copy over the user details first

    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:[CTRentalSearch instance].pickupDate
                                                          toDate:[CTRentalSearch instance].dropoffDate
                                                         options:0];
    
    [self.rental.cartrawlerSDK.cartrawlerAPI locationSearchWithAirportCode:IATACode
                                                                completion:^(CTLocationSearch *response, CTErrorResponse *error) {
        if (error) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(didFailToReceiveBestDailyRate)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate didFailToReceiveBestDailyRate];
                });
            }
        } else {
            if (response) {
                
                if(response.matchedLocations.count > 0) {
                    [CTRentalSearch instance].pickupLocation = response.matchedLocations.firstObject;
                    [CTRentalSearch instance].dropoffLocation = response.matchedLocations.firstObject;
                    _defaultSearch = [[CTRentalSearch instance] copy];

                    [self.rental.cartrawlerSDK.cartrawlerAPI requestVehicleAvailabilityForLocation:[CTRentalSearch instance].pickupLocation.code
                                                                                returnLocationCode:[CTRentalSearch instance].dropoffLocation.code
                                                                               customerCountryCode:[CTSDKSettings instance].homeCountryCode
                                                                                      passengerQty:@1
                                                                                         driverAge:userDetails.driverAge ?: @30
                                                                                    pickUpDateTime:[CTRentalSearch instance].pickupDate
                                                                                    returnDateTime:[CTRentalSearch instance].dropoffDate
                                                                                      currencyCode:[CTSDKSettings instance].currencyCode
                                                                                        completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                    if (error) {
                        [CTAnalytics tagError:@"inpath" event:@"Avail fail" message:error.errorMessage];
                    }
                                                                                            
                    if (response.items.count > 0) {
                        [CTRentalSearch instance].vehicleAvailability = response;
                        [[CTRentalSearch instance] setEngineInfoFromAvail];
                        _defaultSearch = [[CTRentalSearch instance] copy];
                        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"vehicle.totalPriceForThisVehicle"
                                                                                     ascending:YES];
                        CTAvailabilityItem *cheapestvehicle =
                        ((CTAvailabilityItem *)[response.items sortedArrayUsingDescriptors:@[descriptor]].firstObject);
                        
                        if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveBestDailyRate:currency:)]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSNumber *dailyRate = [NSNumber numberWithFloat:
                                                       cheapestvehicle.vehicle.totalPriceForThisVehicle.floatValue / ([components day] ?: 1)];
                                [self.delegate didReceiveBestDailyRate:dailyRate currency:cheapestvehicle.vehicle.currencyCode];
                            });
                        }
                    } else {
                        [CTAnalytics tagError:@"inpath" event:@"no items" message:@"no vehicles available"];
                        if (self.delegate && [self.delegate respondsToSelector:@selector(didFailToReceiveBestDailyRate)]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.delegate didFailToReceiveBestDailyRate];
                            });
                        }
                    }
                }];
                    
                } else {
                    [CTAnalytics tagError:@"inpath" event:@"get location" message:[NSString stringWithFormat:@"no location for %@", IATACode]];
                        if (self.delegate && [self.delegate respondsToSelector:@selector(didFailToReceiveBestDailyRate)]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.delegate didFailToReceiveBestDailyRate];
                            });
                        }
                    }
            }
        }
    }];

    return self;
}

- (void)presentCarRentalWithFlightDetails:(nonnull UIViewController *)parentViewController
{
    [CTSDKSettings instance].disableCurrencySelection = YES;
    [[CTRentalSearch instance] setFromCopy:self.defaultSearch];
    [self configureViews];
    [self presentRentalNavigationController:parentViewController];
    [CTAnalytics tagScreen:@"Visit" detail:@"inflow" step:@1];
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
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:[CTRentalSearch instance].pickupDate
                                                          toDate:[CTRentalSearch instance].dropoffDate
                                                         options:0];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"vehicle.totalPriceForThisVehicle"
                                                                 ascending:YES];
    if (self.defaultSearch.vehicleAvailability) {
        CTAvailabilityItem *cheapestvehicle = ((CTAvailabilityItem *)[self.defaultSearch.vehicleAvailability.items sortedArrayUsingDescriptors:@[descriptor]].firstObject);
        if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveBestDailyRate:currency:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSNumber *dailyRate = [NSNumber numberWithFloat:cheapestvehicle.vehicle.totalPriceForThisVehicle.floatValue / ([components day] ?: 1)];
                [self.delegate didReceiveBestDailyRate:dailyRate currency:cheapestvehicle.vehicle.currencyCode];
            });
        }
    }
}

- (void)didReceiveBookingConfirmationID:(NSString *)confirmationID
{
    if (confirmationID) {
        [CTDataStore didMakeInPathBooking:confirmationID];
    }
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
