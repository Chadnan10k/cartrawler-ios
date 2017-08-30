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


@interface CartrawlerInPath() <CTViewControllerDelegate>

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
@property (nonatomic) NSDate *fetchStartTime;

@property (nonatomic, strong) CTInPathVehicle *cachedVehicle;

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
    [self.rental.cartrawlerSDK setNewSession];
    _parentViewController = parentViewController;
    [self setSearchDetails:currency flightNo:flightNumber passengers:passegers pickupDate:pickupDate returnDate:returnDate];
    
    self.fetchStartTime = [NSDate date];
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
    self.didFailToFetchResults = YES;
    
    [self.rental.cartrawlerSDK.cartrawlerAPI locationSearchWithAirportCode:IATACode
                                                                completion:^(CTLocationSearch *response, CTErrorResponse *error)
    {
            if (error) {
                [[CTAnalytics instance] tagError:@"inpath" event:@"no location" message:[NSString stringWithFormat:@"cannot get in path location: %@", IATACode]];
                self.didFailToFetchResults = YES;
            } else {
                if (response) {
                    self.didFailToFetchResults = NO;
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
	
	NSString *myAppId = [[CTSDKSettings instance].customAttributes valueForKey:CTMyAccountID] != nil && ![[[CTSDKSettings instance].customAttributes valueForKey:CTMyAccountID] isEqualToString:@""] ? [[CTSDKSettings instance].customAttributes valueForKey:CTMyAccountID] : @"[ACCOUNTID]";
	NSString *visitorId = [[CTSDKSettings instance].customAttributes valueForKey:CTVisitorId] != nil ? [[CTSDKSettings instance].customAttributes valueForKey:CTVisitorId] : @"";
	NSString *orderId = [[CTSDKSettings instance].customAttributes valueForKey:CTOrderId] != nil && ![[[CTSDKSettings instance].customAttributes valueForKey:CTOrderId] isEqualToString:@""] ? [[CTSDKSettings instance].customAttributes valueForKey:CTOrderId] : @"[FLIGHTPNR]";
	
    __weak typeof (self) weakSelf = self;
    [self.rental.cartrawlerSDK.cartrawlerAPI requestVehicleAvailabilityForLocation:[CTRentalSearch instance].pickupLocation.code
                                                                returnLocationCode:[CTRentalSearch instance].dropoffLocation.code
                                                               customerCountryCode:[CTSDKSettings instance].homeCountryCode
                                                                      passengerQty:[CTRentalSearch instance].passengerQty
                                                                         driverAge:[CTRentalSearch instance].driverAge
                                                                    pickUpDateTime:[CTRentalSearch instance].pickupDate
                                                                    returnDateTime:[CTRentalSearch instance].dropoffDate
                                                                      currencyCode:[CTSDKSettings instance].currencyCode
																		   orderId:orderId
																		 accountId:myAppId
																		 visitorId:visitorId
																	  isStandAlone:[CTSDKSettings instance].isStandalone
                                                                        completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                                                                            [weakSelf processVehicleAvailability:response error:error];
                                                                        }];
}

- (void)processVehicleAvailability:(CTVehicleAvailability *)availability error:(CTErrorResponse *)error {
    if (error) {
        [self vehicleSearchDidFailWithError:error];
    } else if (availability.items.count > 0) {
        [self vehicleSearchDidSucceedWithVehicleAvailability:availability];
    } else {
        [self vehicleSearchDidSucceedWithNoAvailableVehicles];
    }
}

- (void)vehicleSearchDidFailWithError:(CTErrorResponse *)error {
    [[CTAnalytics instance] tagError:@"inpath" event:@"Avail fail" message:error.errorMessage];
    _didFailToFetchResults = YES;
}

- (void)vehicleSearchDidSucceedWithVehicleAvailability:(CTVehicleAvailability *)availability {
    [CTRentalSearch instance].vehicleAvailability = availability;
    [[CTRentalSearch instance] setEngineInfoFromAvail];
    _defaultSearch = [[CTRentalSearch instance] copy];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:[CTRentalSearch instance].pickupDate
                                                          toDate:[CTRentalSearch instance].dropoffDate
                                                         options:0];
    
    CTAvailabilityItem *cheapestvehicle = [self cheapestVehicleinVehicleAvailability:availability];
    
    _didFetchResults = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveBestDailyRate:currency:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSNumber *dailyRate = [NSNumber numberWithFloat:
                                   cheapestvehicle.vehicle.totalPriceForThisVehicle.floatValue / ([components day] ?: 1)];
            [self.delegate didReceiveBestDailyRate:dailyRate currency:cheapestvehicle.vehicle.currencyCode];
        });
    }
}

- (CTAvailabilityItem *)cheapestVehicleinVehicleAvailability:(CTVehicleAvailability *)availability {
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"vehicle.totalPriceForThisVehicle"
                                                                 ascending:YES];
    return ((CTAvailabilityItem *)[availability.items sortedArrayUsingDescriptors:@[descriptor]].firstObject);
}

- (void)vehicleSearchDidSucceedWithNoAvailableVehicles {
    [[CTAnalytics instance] tagError:@"inpath" event:@"no items" message:@"no vehicles available"];
    _didFailToFetchResults = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFailToReceiveBestDailyRate)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didFailToReceiveBestDailyRate];
        });
    }
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
    [self presentRentalNavigationController:parentViewController];
    [[CTAnalytics instance] tagScreen:@"click_WI" detail:@"see_all" step:nil];
}


//Lets take what views we need for the nav stack
- (void)configureViews
{
    //The sdk handles most of the routing, but for in path we only need to display up to payment summary,
    self.rental.vehicleSelectionViewController.destinationViewController = nil;
    self.rental.vehicleSelectionViewController.delegate = self;
    
}

- (void)presentRentalNavigationController:(UIViewController *)parent
{
    CTNavigationController *navController = [[CTNavigationController alloc] init];
    navController.navigationBar.hidden = YES;
    navController.modalPresentationStyle = [CTAppearance instance].modalPresentationStyle;
    navController.modalTransitionStyle = [CTAppearance instance].modalTransitionStyle;
    [CTSDKSettings instance].isStandalone = NO;
    
    if (self.didFailToFetchResults) {
        [navController setViewControllers:@[self.rental.searchDetailsViewController]];
    } else {
        [navController setViewControllers:@[self.rental.vehicleSelectionViewController]];
    }
    
    [parent presentViewController:navController animated:[CTAppearance instance].presentAnimated completion:nil];
    
    CTAnalyticsEvent *event = [[CTAnalyticsEvent alloc] init];
    event.params = @{@"smartblockName" : @"NEW *"};
    event.eventName = @"Flight Path";
    event.eventType = @"UserAction";
    [self.rental.cartrawlerSDK sendAnalyticsEvent:event];
}

- (void)addCrossSellCardToView:(UIView *)view
{
    //check what state we are in first
    if (!self.cardView) {
        _cardView = [[CTInPathView alloc] initWithFrame:CGRectZero];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCardView:)];
        [_cardView addGestureRecognizer:recognizer];
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

- (void)didTapCardView:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(didTapCrossSellCard)]) {
        [self.delegate didTapCrossSellCard];
    }
}

- (void)removeVehicle
{
    [[CTAnalytics instance] tagScreen:@"display_WI" detail:@"removed" step:nil];
    [CTDataStore deletePotentialInPathBooking];
    _cachedVehicle = nil;
    if (self.cardView) {
        [self.cardView renderDefault:YES];
    }
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:self.defaultSearch.pickupDate
                                                          toDate:self.defaultSearch.dropoffDate
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
        
        [[CTAnalytics instance] tagScreen:@"step" detail:@"confirmati" step:nil];
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
    [self.cardView renderVehicleDetails:vehicle animated:YES];
    _cachedVehicle = vehicle;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didProduceInPathPaymentRequest:vehicle:)]) {
        [[CTAnalytics instance] tagScreen:@"display_WI" detail:@"added" step:nil];
        [CTDataStore cachePotentialInPathBooking:booking];
        [self.delegate didProduceInPathPaymentRequest:[CTInPathPayment createInPathRequest:search]
                                       vehicle:vehicle];
    }
    [search resetUserSelections];
}

@end
