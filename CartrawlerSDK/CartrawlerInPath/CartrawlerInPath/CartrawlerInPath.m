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
@property (nonatomic, strong) NSString *defaultCountryCode;
@property (nonatomic, strong) NSString *defaultCountryName;
@property (nonatomic) BOOL isReturnTrip;
@property (nonatomic) BOOL didFailToFetchResults;
@property (nonatomic) BOOL didFetchResults;

@property (nonatomic, strong) CTInPathVehicle *cachedVehicle;

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
        _defaultCountryCode = [CTSDKSettings instance].homeCountryCode;
        _defaultCountryName = [CTSDKSettings instance].homeCountryName;
        [CTRentalSearch instance].country = [CTSDKSettings instance].homeCountryCode;
    } else {
        _defaultCountryCode = userDetails.countryCode;
        _defaultCountryName = userDetails.countryName;
        [[CTSDKSettings instance] setHomeCountryCode:userDetails.countryCode];
        [[CTSDKSettings instance] setHomeCountryName:userDetails.countryName];
        [CTRentalSearch instance].country = userDetails.countryCode;
    }
    
    if (returnDate) {
        _isReturnTrip = YES;
        [CTRentalSearch instance].dropoffDate = returnDate;
    } else {
        _isReturnTrip = NO;
        [CTRentalSearch instance].dropoffDate = [pickupDate dateByAddingTimeInterval:259200];//3 days
    }
    
    [CTRentalSearch instance].pickupDate = pickupDate;
    [CTRentalSearch instance].firstName = userDetails.firstName;
    [CTRentalSearch instance].surname = userDetails.surname;
    [CTRentalSearch instance].passengerQty = [NSNumber numberWithInt:1 + userDetails.additionalPassengers.intValue];
    [CTRentalSearch instance].email = userDetails.email;
    [CTRentalSearch instance].phone = userDetails.phone;
    [CTRentalSearch instance].flightNumber = [userDetails.flightNo stringByReplacingOccurrencesOfString:@" " withString:@""];
    [CTRentalSearch instance].addressLine1 = userDetails.addressLine1;
    [CTRentalSearch instance].addressLine2 = userDetails.addressLine2;
    [CTRentalSearch instance].city = userDetails.city;
    [CTRentalSearch instance].postcode = userDetails.postcode;
    
    if (!userDetails.driverAge) {
        [CTRentalSearch instance].driverAge = @30;
    } else {
        [CTRentalSearch instance].driverAge = userDetails.driverAge;
    }
    
    _defaultSearch = [[CTRentalSearch instance] copy];//copy over the user details first
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:[CTRentalSearch instance].pickupDate
                                                          toDate:[CTRentalSearch instance].dropoffDate
                                                         options:0];
    _didFailToFetchResults = YES;//set to yes until someone sends a response
    [self.rental.cartrawlerSDK.cartrawlerAPI locationSearchWithAirportCode:IATACode
                                                                completion:^(CTLocationSearch *response, CTErrorResponse *error) {
        if (error) {
            [[CTAnalytics instance] tagError:@"inpath" event:@"no location" message:@"failed to get location"];
            _didFailToFetchResults = YES;
            if (self.delegate && [self.delegate respondsToSelector:@selector(didFailToReceiveBestDailyRate)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate didFailToReceiveBestDailyRate];
                });
            }
        } else {
            if (response) {
                _didFailToFetchResults = NO;
                if(response.matchedLocations.count > 0) {
                    [CTRentalSearch instance].pickupLocation = response.matchedLocations.firstObject;
                    [CTRentalSearch instance].dropoffLocation = response.matchedLocations.firstObject;
                    _defaultSearch = [[CTRentalSearch instance] copy];

                    [self.rental.cartrawlerSDK.cartrawlerAPI requestVehicleAvailabilityForLocation:[CTRentalSearch instance].pickupLocation.code
                                                                                returnLocationCode:[CTRentalSearch instance].dropoffLocation.code
                                                                               customerCountryCode:[CTSDKSettings instance].homeCountryCode
                                                                                      passengerQty:@1
                                                                                         driverAge:[CTRentalSearch instance].driverAge
                                                                                    pickUpDateTime:[CTRentalSearch instance].pickupDate
                                                                                    returnDateTime:[CTRentalSearch instance].dropoffDate
                                                                                      currencyCode:[CTSDKSettings instance].currencyCode
                                                                                        completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                    if (error) {
                        [[CTAnalytics instance] tagError:@"inpath" event:@"Avail fail" message:error.errorMessage];
                        _didFailToFetchResults = YES;
                    } else if (response.items.count > 0) {
                        [CTRentalSearch instance].vehicleAvailability = response;
                        [[CTRentalSearch instance] setEngineInfoFromAvail];
                        _defaultSearch = [[CTRentalSearch instance] copy];
                        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"vehicle.totalPriceForThisVehicle"
                                                                                     ascending:YES];
                        CTAvailabilityItem *cheapestvehicle =
                        ((CTAvailabilityItem *)[response.items sortedArrayUsingDescriptors:@[descriptor]].firstObject);
                        _didFetchResults = YES;
                        if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveBestDailyRate:currency:)]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSNumber *dailyRate = [NSNumber numberWithFloat:
                                                       cheapestvehicle.vehicle.totalPriceForThisVehicle.floatValue / ([components day] ?: 1)];
                                [self.delegate didReceiveBestDailyRate:dailyRate currency:cheapestvehicle.vehicle.currencyCode];
                            });
                        }
                    } else {
                        [[CTAnalytics instance] tagError:@"inpath" event:@"no items" message:@"no vehicles available"];
                        _didFailToFetchResults = YES;
                        if (self.delegate && [self.delegate respondsToSelector:@selector(didFailToReceiveBestDailyRate)]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.delegate didFailToReceiveBestDailyRate];
                            });
                        }
                    }
                }];
                    
                } else {
                    [[CTAnalytics instance] tagError:@"inpath"
                                               event:@"get location"
                                             message:[NSString stringWithFormat:@"no location for %@", IATACode]];
                    _didFailToFetchResults = YES;
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
    [[CTSDKSettings instance] setHomeCountryCode: self.defaultCountryCode];
    [[CTSDKSettings instance] setHomeCountryName: self.defaultCountryName];
    [CTSDKSettings instance].disableCurrencySelection = YES;
    [[CTRentalSearch instance] setFromCopy:self.defaultSearch];
    [self configureViews];
    [self presentRentalNavigationController:parentViewController];
    [[CTAnalytics instance] tagScreen:@"visit" detail:@"inflow" step:@1];
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
    
    if (self.didFailToFetchResults) {
        [navController setViewControllers:@[self.rental.searchDetailsViewController]];
    } else {
        if (self.didFetchResults) {
            [navController setViewControllers:@[self.rental.vehicleSelectionViewController]];
        } else {
            [navController setViewControllers:@[self.rental.vehicleSelectionViewController]];
        }
    }
    
    [parent presentViewController:navController animated:[CTAppearance instance].presentAnimated completion:nil];
}

- (void)addCrossSellCardToView:(UIView *)view
{
    //check what state we are in first
    if (!self.cardView) {
        _cardView = [[CTInPathView alloc] initWithFrame:CGRectZero];
    }
    
    if (self.cachedVehicle) {
        [self.cardView renderVehicleDetails:self.cachedVehicle animated:NO];
    } else {
        [self.cardView renderDefault:NO];
    }
    
    self.cardView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:self.cardView];

    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.cardView}]];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.cardView}]];
    
}

- (void)removeVehicle
{
    _cachedVehicle = nil;
    if (self.cardView) {
        [self.cardView renderDefault:YES];
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
    [self.cardView renderVehicleDetails:vehicle animated:YES];
    _cachedVehicle = vehicle;

    if (self.delegate && [self.delegate respondsToSelector:@selector(didProduceInPathRequest:vehicle:)]) {
        [CTDataStore cachePotentialInPathBooking:booking];
        [self.delegate didProduceInPathRequest:[CTInPathPayment createInPathRequest:search]
                                       vehicle:[[CTInPathVehicle alloc] init:search]];
    }
}

@end
