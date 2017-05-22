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
#import "CartrawlerSDK/CartrawlerSDK+NSNumber.h"

@interface CartrawlerInPath() <CTViewControllerDelegate, CTInPathViewDelegate>

@property (nonatomic, strong) CartrawlerRental *rental;
@property (nonatomic, strong) CTInPathView *cardView;
@property (nonatomic, strong) CTRentalSearch *defaultSearch;
@property (nonatomic, strong) NSString *defaultCountryCode;
@property (nonatomic, strong) NSString *defaultCountryName;
@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, weak) UIViewController *parentViewController;

@property (nonatomic) BOOL isReturnTrip;
@property (nonatomic) BOOL didFailToFetchResults;
@property (nonatomic) BOOL didFetchResults;

@property (nonatomic, strong) CTAvailabilityItem *cachedVehicle;

@end

@implementation CartrawlerInPath


+ (CartrawlerInPath *)initWithCartrawlerRental:(nonnull CartrawlerRental *)cartrawlerRental
{
    CartrawlerInPath *inPath = [CartrawlerInPath new];
    inPath.rental = cartrawlerRental;
    return inPath;
}

- (void)performSearchWithIATACode:(nonnull NSString *)IATACode
                       pickupDate:(nonnull NSDate *)pickupDate
                       returnDate:(nullable NSDate *)returnDate
                     flightNumber:(nullable NSString *)flightNumber
                         currency:(nonnull NSString *)currency
                        passegers:(nonnull NSArray<CTPassenger *> *)passegers
                         clientID:(nonnull NSString *)clientID
             parentViewController:(nonnull UIViewController *)parentViewController;
{
    [[CTSDKSettings instance] setClientId:clientID];
    _clientID = clientID;
    [self renderDefaultState];
    _parentViewController = parentViewController;
    [self setSearchDetails:currency flightNo:flightNumber passengers:passegers pickupDate:pickupDate returnDate:returnDate];
    [self performLocationSearch:IATACode ?: @""];
}

- (void)setSearchDetails:(NSString *)currency
                flightNo:(NSString *)flightNo
              passengers:(NSArray <CTPassenger *> *)passengers
              pickupDate:(nonnull NSDate *)pickupDate
              returnDate:(nullable NSDate *)returnDate
{
    //First, lets check if we have any passengers
    CTPassenger *primaryPassenger;
    
    for (CTPassenger *p in passengers) {
        if (p.isPrimaryDriver) {
            primaryPassenger = p;
        }
    }
    
    [[CTRentalSearch instance] reset];

    [[CTSDKSettings instance] setCurrencyCode:currency];
    [[CTSDKSettings instance] setCurrencyName:currency];

    if (!primaryPassenger.countryCode) {
        _defaultCountryCode = [CTSDKSettings instance].homeCountryCode;
        _defaultCountryName = [CTSDKSettings instance].homeCountryName;
        [CTRentalSearch instance].country = [CTSDKSettings instance].homeCountryCode;
    } else {
        NSString *countryName = [[CTSDKSettings instance] countryName:primaryPassenger.countryCode];
        _defaultCountryCode = primaryPassenger.countryCode;
        _defaultCountryName = countryName;
        [[CTSDKSettings instance] setHomeCountryCode:primaryPassenger.countryCode];
        [[CTSDKSettings instance] setHomeCountryName:countryName];
        [CTRentalSearch instance].country = primaryPassenger.countryCode;
    }
    
    if (returnDate) {
        _isReturnTrip = YES;
        [CTRentalSearch instance].dropoffDate = returnDate;
    } else {
        _isReturnTrip = NO;
        [CTRentalSearch instance].dropoffDate = [pickupDate dateByAddingTimeInterval:259200];//3 days
    }
    
    [CTRentalSearch instance].pickupDate = pickupDate;
    [CTRentalSearch instance].firstName = primaryPassenger.firstName;
    [CTRentalSearch instance].surname = primaryPassenger.lastName;
    [CTRentalSearch instance].passengerQty = @(passengers.count);
    [CTRentalSearch instance].email = primaryPassenger.email;
    [CTRentalSearch instance].phone = primaryPassenger.phone;
    [CTRentalSearch instance].flightNumber = [flightNo stringByReplacingOccurrencesOfString:@" " withString:@""];
    [CTRentalSearch instance].addressLine1 = primaryPassenger.addressLine1;
    [CTRentalSearch instance].addressLine2 = primaryPassenger.addressLine2;
    [CTRentalSearch instance].city = primaryPassenger.city;
    [CTRentalSearch instance].postcode = primaryPassenger.postcode;

    if (!primaryPassenger.age) {
        [CTRentalSearch instance].driverAge = @30;
    } else {
        [CTRentalSearch instance].driverAge = primaryPassenger.age;
    }
    
    _defaultSearch = [[CTRentalSearch instance] copy];//copy over the user details first
    
}

- (void)performLocationSearch:(NSString *)IATACode
{
    [self.rental.cartrawlerSDK.cartrawlerAPI changeClientKey:self.clientID];

    __weak typeof (self) weakSelf = self;
    _didFailToFetchResults = YES;//set to yes until someone sends a response
    [self.rental.cartrawlerSDK.cartrawlerAPI locationSearchWithAirportCode:IATACode
                                                                completion:^(CTLocationSearch *response, CTErrorResponse *error)
    {
            if (error) {
                [[CTAnalytics instance] tagError:@"inpath" event:@"no location" message:[NSString stringWithFormat:@"cannot get in path location: %@", IATACode]];
                _didFailToFetchResults = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf renderFailState];
                });
            } else {
                if (response) {
                    _didFailToFetchResults = NO;
                    if(response.matchedLocations.count > 0) {
                        [CTRentalSearch instance].pickupLocation = response.matchedLocations.firstObject;
                        [CTRentalSearch instance].dropoffLocation = response.matchedLocations.firstObject;
                        _defaultSearch = [[CTRentalSearch instance] copy];
                        [weakSelf performVehicleSearch];
                    }
                }
            }
    }];

}

- (void)performVehicleSearch
{
    __weak typeof (self) weakSelf = self;
     [self.rental.cartrawlerSDK.cartrawlerAPI requestVehicleAvailabilityForLocation:[CTRentalSearch instance].pickupLocation.code
                                                                 returnLocationCode:[CTRentalSearch instance].dropoffLocation.code
                                                                customerCountryCode:[CTSDKSettings instance].homeCountryCode
                                                                       passengerQty:[CTRentalSearch instance].passengerQty
                                                                          driverAge:[CTRentalSearch instance].driverAge
                                                                     pickUpDateTime:[CTRentalSearch instance].pickupDate
                                                                     returnDateTime:[CTRentalSearch instance].dropoffDate
                                                                       currencyCode:[CTSDKSettings instance].currencyCode
                                                                         completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
     if (error) {
         [[CTAnalytics instance] tagError:@"inpath" event:@"Avail fail" message:error.errorMessage];
         _didFailToFetchResults = YES;
         dispatch_async(dispatch_get_main_queue(), ^{
             [weakSelf renderFailState];
         });
     } else if (response.items.count > 0) {
         [CTRentalSearch instance].vehicleAvailability = response;
         [[CTRentalSearch instance] setEngineInfoFromAvail];
         _defaultSearch = [[CTRentalSearch instance] copy];
         _didFetchResults = YES;
         dispatch_async(dispatch_get_main_queue(), ^{
             [weakSelf renderReadyState];
         });
     } else {
         [[CTAnalytics instance] tagError:@"inpath" event:@"no items" message:@"no vehicles available"];
         _didFailToFetchResults = YES;
         dispatch_async(dispatch_get_main_queue(), ^{
             [weakSelf renderFailState];
         });
     }
    }];
}

- (NSNumber *)dailyRate:(CTAvailabilityItem *)vehicleItem
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:[CTRentalSearch instance].pickupDate
                                                          toDate:[CTRentalSearch instance].dropoffDate
                                                         options:0];
    return [NSNumber numberWithFloat:
                    vehicleItem.vehicle.totalPriceForThisVehicle.floatValue / ([components day] ?: 1)];
}

- (void)presentAllCars:(nonnull UIViewController *)parentViewController
{
    [[CTSDKSettings instance] setHomeCountryCode: self.defaultCountryCode];
    [[CTSDKSettings instance] setHomeCountryName: self.defaultCountryName];
    [CTSDKSettings instance].disableCurrencySelection = YES;
    [[CTRentalSearch instance] setFromCopy:self.defaultSearch];
    [CTRentalSearch instance].selectedVehicle = nil;
    [self configureViews];
    [self presentRentalNavigationController:parentViewController showSelection:YES];
    [[CTAnalytics instance] tagScreen:@"visit" detail:@"inflow" step:@1];
}

- (void)presentSelectedVehicle:(nonnull UIViewController *)parentViewController selectedVehicleItem:(CTAvailabilityItem *)vehicleItem;
{
    [[CTSDKSettings instance] setHomeCountryCode: self.defaultCountryCode];
    [[CTSDKSettings instance] setHomeCountryName: self.defaultCountryName];
    [CTSDKSettings instance].disableCurrencySelection = YES;
    [[CTRentalSearch instance] setFromCopy:self.defaultSearch];
    [CTRentalSearch instance].selectedVehicle = vehicleItem;
    [self configureViews];
    [self presentRentalNavigationController:parentViewController showSelection:NO];
    [[CTAnalytics instance] tagScreen:@"visit" detail:@"inflow" step:@1];
}

//Lets take what views we need for the nav stack
- (void)configureViews
{
    //The sdk handles most of the routing, but for in path we only need to display up to payment summary,
    self.rental.vehicleSelectionViewController.destinationViewController = nil;
    self.rental.vehicleSelectionViewController.delegate = self;
    
}

- (void)presentRentalNavigationController:(UIViewController *)parent showSelection:(BOOL)showSelection
{
    CTNavigationController *navController = [[CTNavigationController alloc] init];
    navController.navigationBar.hidden = YES;
    navController.modalPresentationStyle = [CTAppearance instance].modalPresentationStyle;
    navController.modalTransitionStyle = [CTAppearance instance].modalTransitionStyle;
    
    if (self.didFailToFetchResults) {
        [navController setViewControllers:@[self.rental.vehicleSelectionViewController]];
    } else {
        if (showSelection) {
            [navController setViewControllers:@[self.rental.vehicleSelectionViewController]];
        } else {
            [navController setViewControllers:@[self.rental.vehicleSelectionViewController]];
        }
    }
    
    [parent presentViewController:navController animated:[CTAppearance instance].presentAnimated completion:nil];
    
    CTAnalyticsEvent *event = [[CTAnalyticsEvent alloc] init];
    event.params = @{@"smartblockName" : @"NEW *"};
    event.eventName = @"Flight Path";
    event.eventType = @"UserAction";
    [self.rental.cartrawlerSDK sendAnalyticsEvent:event];
}

//MARK : View Rendering

- (void)renderDefaultState
{
    if (self.cardView) {
        [self.cardView showLoadingState];
    }
}

- (void)renderReadyState
{
    if (self.cardView) {
        [self.cardView showVehicleSelection:self.defaultSearch.vehicleAvailability
                                 pickupDate:self.defaultSearch.pickupDate
                                dropoffDate:self.defaultSearch.dropoffDate];
    }
}

- (void)renderFailState
{
    if (self.cardView) {
        [self.cardView showErrorState];
    }
}

- (void)renderSelectedState
{
    if (self.cardView) {
        [self.cardView showVehicleDetails:self.cachedVehicle];
    }
}

- (void)addInPathCarouselToContainer:(UIView *)view
{
    if (!self.cardView) {
        _cardView = [CTInPathView new];
        self.cardView.delegate = self;
    }
    
    if (self.cachedVehicle) {
        [self renderSelectedState];
    } else if (self.defaultSearch.vehicleAvailability) {
        [self renderReadyState];
    } else {
        [self renderDefaultState];
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
    [CTDataStore deletePotentialInPathBooking];
    _cachedVehicle = nil;
    if (self.cardView) {
        [self renderReadyState];
    }
}

- (void)didReceiveBookingConfirmationID:(NSString *)confirmationID
{
    if (confirmationID) {
        
        NSString *vehName = [NSString stringWithFormat:@"%@ %@", [CTRentalSearch instance].selectedVehicle.vehicle.makeModelName,
                             [CTRentalSearch instance].selectedVehicle.vehicle.orSimilar];
        
        CTAnalyticsEvent *event = [CTAnalyticsEvent new];
        event.eventName = @"Booking";
        event.eventType = @"Booking";
        event.params = @{@"eventName" : @"Booking",
                           @"reservationID" : confirmationID,
                           @"insuranceOffered" : [CTRentalSearch instance].insurance ? @"true" : @"false",
                           @"insurancePurchased" : [CTRentalSearch instance].isBuyingInsurance ? @"true" : @"false",
                           @"age" : [CTRentalSearch instance].driverAge.stringValue,
                           @"clientID" : [CTSDKSettings instance].clientId,
                           @"residenceID" : [CTSDKSettings instance].homeCountryCode,
                           @"pickupName" : [CTRentalSearch instance].pickupLocation.name,
                           @"pickupDate" : [[CTRentalSearch instance].pickupDate stringFromDateWithFormat:@"dd/MM/yyyy"],
                           @"returnName" : [CTRentalSearch instance].dropoffLocation.name,
                           @"returnDate" : [[CTRentalSearch instance].dropoffDate stringFromDateWithFormat:@"dd/MM/yyyy"],
                           @"carSelected" : vehName
                           };
        
        CTAnalyticsEvent *saleEvent = [CTAnalyticsEvent new];
        saleEvent.saleType = @"InPath";
        saleEvent.orderID = confirmationID;
        saleEvent.quantity = @1;
        saleEvent.metricItem = [CTRentalSearch instance].pickupLocation.name;
        
        if ([CTRentalSearch instance].isBuyingInsurance) {
            saleEvent.value = @([CTRentalSearch instance].selectedVehicle.vehicle.totalPriceForThisVehicle.doubleValue +
                                [CTRentalSearch instance].insurance.premiumAmount.doubleValue);
        } else {
            saleEvent.value = [CTRentalSearch instance].selectedVehicle.vehicle.totalPriceForThisVehicle;
        }
        
        [self.rental.cartrawlerSDK sendAnalyticsEvent:event];
        [self.rental.cartrawlerSDK sendAnalyticsSaleEvent:saleEvent];
        [CTDataStore didMakeInPathBooking:confirmationID];
    }
}

// MARK: CTViewController Delegate

- (void)didDismissViewController:(NSString *)identifier
{
    if (![CTRentalSearch instance].selectedVehicle)
        return;
    
    CTRentalSearch *search = [CTRentalSearch instance];
    CTRentalBooking *booking = [[CTRentalBooking alloc] initFromSearch:search];
    CTInPathVehicle *vehicle = [[CTInPathVehicle alloc] init:search];
    _cachedVehicle = search.selectedVehicle;
    [self renderSelectedState];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didProduceInPathPaymentRequest:vehicle:)]) {
        [CTDataStore cachePotentialInPathBooking:booking];
        [self.delegate didProduceInPathPaymentRequest:[CTInPathPayment createInPathRequest:search]
                                       vehicle:vehicle];
    }
}

// MARK : CTInPathViewDelegate

- (void)didTapVehicle:(CTAvailabilityItem *)item atIndex:(NSUInteger)index
{
    if (self.delegate) {
        [self.delegate didTapVehicleAtIndex:index vehicleItem:item];
    }
}

- (void)didDisplayVehicle:(CTAvailabilityItem *)item atIndex:(NSUInteger)index
{
    if (self.delegate) {
        NSNumber *pricePerDay = [item.vehicle.totalPriceForThisVehicle pricePerDayValue:self.defaultSearch.pickupDate
                                                                                dropoff:self.defaultSearch.dropoffDate];
        [self.delegate didDisplayVehicleAtIndex:index vehicleItem:item pricePerDay:pricePerDay];
    }
}


@end
