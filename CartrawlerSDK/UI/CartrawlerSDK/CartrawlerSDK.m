//
//  CartrawlerSDK.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//


#import "CartrawlerSDK.h"
#import "CTSDKSettings.h"
#import "CTNavigationController.h"
#import "CarRentalSearch.h"
#import "CTValidation.h"
#import "GTSearchValidation.h"
#import "GTSelectionValidation.h"
#import "GTPassengerDetailsValidation.h"
#import "GTGenericValidation.h"
#import "GenericValidation.h"
#import "InsuranceValidation.h"
#import "PaymentValidation.h"
#import "SearchValidation.h"
#import "GTBookingCompletionValidation.h"
#import "BookingCompletionValidation.h"
#import "RentalBookingsViewController.h"
#import "GTBookingsViewController.h"
#import "CTDataStore.h"
#import "CTBasketValidation.h"
#import "CTDriverDetailsValidation.h"

#define kSearchViewStoryboard           @"StepOne"
#define kSearchResultsViewStoryboard    @"StepTwo"
#define kVehicleDetailsViewStoryboard   @"StepThree"
#define kExtrasViewStoryboard           @"StepFour"
#define kSummaryViewStoryboard          @"StepFive"
#define kDetailsViewStoryboard          @"StepSix"
#define kPaymentViewStoryboard          @"Payment"
#define kGroundTransportStoryboard      @"GroundTransport"

#define kGTViewStoryboard @"GroundTransport"

@interface CartrawlerSDK() <CTViewControllerDelegate>

@property (nonatomic, strong, readonly) CTViewController *searchDetailsViewControllerOverride;

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic, strong) NSArray <CTViewController *> *customViewControllers;

@property (nonatomic, strong) NSBundle *bundle;

@property (nonatomic) BOOL isCarRental;

//---Ground Transport View Controllers---
@property (nonatomic, strong, nonnull, readonly) CTViewController *gtSearchDetailsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *gtServiceSelectionViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *gtPassengerDetailsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *gtAddressDetailsViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *gtPaymentViewController;
@property (nonatomic, strong, nonnull, readonly) CTViewController *gtPaymentCompletionViewController;
//---------------------------------------


@end

@implementation CartrawlerSDK

- (instancetype)initWithRequestorID:(NSString *)requestorID
             languageCode:(NSString *)languageCode
              sandboxMode:(BOOL)sandboxMode;
{
    self = [super init];
    
    [[CTSDKSettings instance] setClientId:requestorID languageCode:languageCode isDebug:sandboxMode];
    
    _cartrawlerAPI = [[CartrawlerAPI alloc] initWithClientKey:[CTSDKSettings instance].clientId
                                                     language:[CTSDKSettings instance].languageCode
                                                        debug:[CTSDKSettings instance].isDebug];
    
    _bundle = [NSBundle bundleForClass:[self class]];
    
    if (sandboxMode) {
        [self.cartrawlerAPI enableLogging:YES];
    }
    
    [self setDefaultViews];
    [self configureViews];
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);

    return self;
}

+ (CTAppearance *)appearance
{
    return [CTAppearance instance];
}

- (void)presentCarRentalInViewController:(UIViewController *)viewController;
{
    _isCarRental = YES;
    [[CTSDKSettings instance] resetCountryToDeviceLocale];
    [[CarRentalSearch instance] reset];
    [self configureViews];
    [self presentRentalNavigationController:viewController isInPath:NO];

}

- (void)presentCarRentalWithFlightDetails:(NSString *)IATACode
                               pickupDate:(NSDate *)pickupDate
                               returnDate:(NSDate *)returnDate
                                firstName:(NSString *)firstName
                                  surname:(NSString *)surname
                                driverAge:(NSNumber *)driverAge
                     additionalPassengers:(NSNumber *)additionalPassengers
                                    email:(NSString *)email
                                    phone:(NSString *)phone
                                 flightNo:(NSString *)flightNo
                             addressLine1:(NSString *)addressLine1
                             addressLine2:(NSString *)addressLine2
                                     city:(NSString *)city
                                 postcode:(NSString *)postcode
                              countryCode:(NSString *)countryCode
                              countryName:(NSString *)countryName
                          isInPathBooking:(BOOL)isInPathBooking
                       overViewController:(UIViewController *)viewController
                               completion:(CarRentalWithFlightDetailsCompletion)completion;
{
    
    _isCarRental = YES;
    
    [[CarRentalSearch instance] reset];
    
    [[CTSDKSettings instance] setHomeCountryCode:countryCode];
    [[CTSDKSettings instance] setHomeCountryName:countryName];
    
    [CarRentalSearch instance].pickupDate = pickupDate;
    [CarRentalSearch instance].dropoffDate = returnDate;
    [CarRentalSearch instance].firstName = firstName;
    [CarRentalSearch instance].surname = surname;
    [CarRentalSearch instance].passengerQty = [NSNumber numberWithInt:1 + additionalPassengers.intValue];
    [CarRentalSearch instance].driverAge = driverAge;
    [CarRentalSearch instance].email = email;
    [CarRentalSearch instance].phone = phone;
    [CarRentalSearch instance].flightNumber = flightNo;
    [CarRentalSearch instance].addressLine1 = addressLine1;
    [CarRentalSearch instance].addressLine2 = addressLine2;
    [CarRentalSearch instance].city = city;
    [CarRentalSearch instance].postcode = postcode;
    [CarRentalSearch instance].country = countryCode;
    [self configureViews];
    
    self.paymentSummaryViewController.inPathEnabled = isInPathBooking;

    __weak typeof(self) weakself = self;
    [self.cartrawlerAPI locationSearchWithAirportCode:IATACode completion:^(CTLocationSearch *response, CTErrorResponse *error) {
        if (error) {
            if (completion) {
                completion(NO, error.errorMessage);
            }
        } else {
            if (response) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if(response.matchedLocations.count > 0) {
                        [CarRentalSearch instance].pickupLocation =  response.matchedLocations.firstObject;
                        [CarRentalSearch instance].dropoffLocation =  response.matchedLocations.firstObject;
                        [weakself presentRentalNavigationController:viewController isInPath:isInPathBooking];

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

- (void)presentRentalNavigationController:(UIViewController *)parent isInPath:(BOOL)isInPath
{
    CTNavigationController *navController = [[CTNavigationController alloc] init];
    navController.navigationBar.hidden = YES;
    navController.modalPresentationStyle = [CTAppearance instance].modalPresentationStyle;
    navController.modalTransitionStyle = [CTAppearance instance].modalTransitionStyle;
    
    if ([CTDataStore checkHasUpcomingBookings] && !isInPath) {
        
        UIStoryboard *landingStoryboard = [UIStoryboard storyboardWithName:@"Landing" bundle:self.bundle];
        RentalBookingsViewController *upcomingBookingsVC = [landingStoryboard instantiateViewControllerWithIdentifier:@"RentalBookingsViewController"];
        
        [self configureViewController:upcomingBookingsVC
                 validationController:[[CTBasketValidation alloc] init]
                          destination:self.searchDetailsViewController];
        
        [navController setViewControllers:@[upcomingBookingsVC]];
        [parent presentViewController:navController animated:[CTAppearance instance].presentAnimated completion:nil];
        
    } else {
        [navController setViewControllers:@[self.searchDetailsViewController]];
        [parent presentViewController:navController animated:[CTAppearance instance].presentAnimated completion:nil];
    }
}

- (void)presentGroundTransportInViewController:(UIViewController *)viewController
{
    _isCarRental = NO;
    
    [[GroundTransportSearch instance] reset];
    
    [self configureViews];
    
    CTNavigationController *navController;
    
    navController = [[CTNavigationController alloc] initWithRootViewController: self.gtSearchDetailsViewController];
    
    navController.navigationBar.hidden = YES;
    
    navController.modalPresentationStyle = [CTAppearance instance].modalPresentationStyle;
    navController.modalTransitionStyle = [CTAppearance instance].modalTransitionStyle;
    
    [viewController presentViewController:navController animated:[CTAppearance instance].presentAnimated completion:nil];
}

- (void)setDefaultViews
{
    
    //---SET DEFAULT CAR RENTAL VIEWS---
    UIStoryboard *searchStoryboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:self.bundle];
    _searchDetailsViewController = [searchStoryboard instantiateViewControllerWithIdentifier:@"SearchDetailsViewController"];
    
    UIStoryboard *searchResultsStoryboard = [UIStoryboard storyboardWithName:kSearchResultsViewStoryboard bundle:self.bundle];
    _vehicleSelectionViewController = [searchResultsStoryboard instantiateViewControllerWithIdentifier:@"SearchResultsViewController"];
    
    UIStoryboard *vehicleDetailsStoryboard = [UIStoryboard storyboardWithName:kVehicleDetailsViewStoryboard bundle:self.bundle];
    _vehicleDetailsViewController = [vehicleDetailsStoryboard instantiateViewControllerWithIdentifier:@"VehicleDetailsViewController"];
    
    UIStoryboard *extrasStoryboard = [UIStoryboard storyboardWithName:kExtrasViewStoryboard bundle:self.bundle];
    _insuranceExtrasViewController = [extrasStoryboard instantiateViewControllerWithIdentifier:@"ExtrasViewController"];
    _extrasViewController = [extrasStoryboard instantiateViewControllerWithIdentifier:@"OptionalExtrasViewController"];
    
    UIStoryboard *summaryStoryboard = [UIStoryboard storyboardWithName:kSummaryViewStoryboard bundle:self.bundle];
    _paymentSummaryViewController = [summaryStoryboard instantiateViewControllerWithIdentifier:@"PaymentSummaryViewController"];
    
    UIStoryboard *detailsStoryboard = [UIStoryboard storyboardWithName:kDetailsViewStoryboard bundle:self.bundle];
    _driverDetialsViewController = [detailsStoryboard instantiateViewControllerWithIdentifier:@"DriverDetailsViewController"];
    _addressDetialsViewController = [detailsStoryboard instantiateViewControllerWithIdentifier:@"AddressDetailsViewController"];

    UIStoryboard *paymentStoryboard = [UIStoryboard storyboardWithName:kPaymentViewStoryboard bundle:self.bundle];
    _paymentViewController = [paymentStoryboard instantiateViewControllerWithIdentifier:@"PaymentViewController"];
    _paymentCompletionViewController = [paymentStoryboard instantiateViewControllerWithIdentifier:@"PaymentCompletionViewController"];
    
    //---------------------------------
    
    //---SET DEFAULT GROUND TRANSPORT VIEWS---
    UIStoryboard *groundTransportStoryboard = [UIStoryboard storyboardWithName:kGroundTransportStoryboard bundle:self.bundle];
    _gtSearchDetailsViewController = [groundTransportStoryboard instantiateViewControllerWithIdentifier:@"GTSearchViewController"];
    
    _gtServiceSelectionViewController = [groundTransportStoryboard instantiateViewControllerWithIdentifier:@"GroundServicesViewController"];
    
    _gtPassengerDetailsViewController = [groundTransportStoryboard instantiateViewControllerWithIdentifier:@"DriverDetailsViewController"];
    
    _gtAddressDetailsViewController = [groundTransportStoryboard instantiateViewControllerWithIdentifier:@"AddressDetailsViewController"];
    
    _gtPaymentViewController = [groundTransportStoryboard instantiateViewControllerWithIdentifier:@"PaymentViewController"];
    
    _gtPaymentCompletionViewController = [groundTransportStoryboard instantiateViewControllerWithIdentifier:@"PaymentCompletionViewController"];
    
    //----------------------------------------
}

- (void)configureViews
{
    //CAR RENTAL
    [self configureViewController:self.searchDetailsViewController
             validationController:[[SearchValidation alloc] init]
                      destination:self.vehicleSelectionViewController];
    
    [self configureViewController:self.vehicleSelectionViewController
             validationController:[[GenericValidation alloc] init]
                      destination:self.vehicleDetailsViewController];

    [self configureViewController:self.vehicleDetailsViewController
             validationController:[[InsuranceValidation alloc] init]
                      destination:self.insuranceExtrasViewController
                         fallback:self.driverDetialsViewController
                    optionalRoute:self.extrasViewController];
    
    [self configureViewController:self.insuranceExtrasViewController
             validationController:[[GenericValidation alloc] init]
                      destination:self.driverDetialsViewController];
    
    [self configureViewController:self.extrasViewController
             validationController:[[GenericValidation alloc] init]
                      destination:self.driverDetialsViewController];
    
    [self configureViewController:self.driverDetialsViewController
             validationController:[[CTDriverDetailsValidation alloc] init]
                      destination:self.addressDetialsViewController
                         fallback:self.paymentSummaryViewController
                    optionalRoute:nil];
    
    [self configureViewController:self.addressDetialsViewController
             validationController:[[PaymentValidation alloc] init]
                      destination:self.paymentSummaryViewController];
    
    [self configureViewController:self.paymentSummaryViewController
             validationController:[[GenericValidation alloc] init]
                      destination:self.paymentViewController];
    
    [self configureViewController:self.paymentViewController
             validationController:[[BookingCompletionValidation alloc] init]
                      destination:self.paymentCompletionViewController];
    
    [self configureViewController:self.paymentCompletionViewController
             validationController:nil destination:nil];

    
    //GROUND TRANSPORT
    [self configureViewController:self.gtSearchDetailsViewController
             validationController:[[GTSearchValidation alloc] init]
                      destination:self.gtServiceSelectionViewController];
    
    [self configureViewController:self.gtServiceSelectionViewController
             validationController:[[GTSelectionValidation alloc] init]
                      destination:self.gtPassengerDetailsViewController];
    
    [self configureViewController:self.gtPassengerDetailsViewController
             validationController:[[GTGenericValidation alloc] init]
                      destination:self.gtAddressDetailsViewController];
    
    [self configureViewController:self.gtAddressDetailsViewController
             validationController:[[GTPassengerDetailsValidation alloc] init]
                      destination:self.gtPaymentViewController];
    
    [self configureViewController:self.gtPaymentViewController
             validationController:[[GTBookingCompletionValidation alloc] init]
                      destination:self.gtPaymentCompletionViewController];
    
    [self configureViewController:self.gtPaymentCompletionViewController
             validationController:nil
                      destination:nil];

}

- (void)overrideSearchDetailsViewController:(CTViewController *)viewController
{
    _searchDetailsViewControllerOverride = viewController;
    [self configureViews];
}

- (void)overrideVehicleSelectionViewController:(CTViewController *)viewController
{
    _vehicleSelectionViewController = viewController;
    [self configureViews];
}

- (void)overrideVehicleDetailsViewController:(CTViewController *)viewController
{
    _vehicleDetailsViewController = viewController;
    [self configureViews];
}

- (void)overrideInsuranceExtrasViewController:(CTViewController *)viewController
{
    _insuranceExtrasViewController = viewController;
    [self configureViews];
}

- (void)overrideExtrasViewController:(CTViewController *)viewController
{
    _extrasViewController = viewController;
    [self configureViews];
}

- (void)overridePaymentSummaryViewController:(CTViewController *)viewController
{
    _paymentSummaryViewController = viewController;
    [self configureViews];
}

- (void)overrideDriverDetialsViewController:(CTViewController *)viewController
{
    _driverDetialsViewController = viewController;
    [self configureViews];
}

- (void)overrideAddressDetialsViewController:(CTViewController *)viewController
{
    _addressDetialsViewController = viewController;
    [self configureViews];
}

- (void)overridePaymentCompletionViewController:(CTViewController *)viewController
{
    _paymentCompletionViewController = viewController;
    [self configureViews];
}

- (CTViewController *)configureViewController:(CTViewController *)viewController
                         validationController:(CTValidation *)validationController
                                  destination:(CTViewController *)destination
                                  fallback:(CTViewController *)fallback
                             optionalRoute:(CTViewController *)optionalRoute
{
    viewController.destinationViewController = destination;
    viewController.fallbackViewController = fallback;
    viewController.optionalRoute = optionalRoute;

    viewController.cartrawlerAPI = self.cartrawlerAPI;
    viewController.delegate = self;
    
    if (self.isCarRental) {
        viewController.search = [CarRentalSearch instance];
        viewController.groundSearch = nil;
    } else {
        viewController.groundSearch = [GroundTransportSearch instance];
        viewController.search = nil;
    }
    
    viewController.validationController = validationController;
    
    return viewController;
}

- (CTViewController *)configureViewController:(CTViewController *)viewController
                         validationController:(CTValidation *)validationController
                                  destination:(CTViewController *)destination
{
    viewController.destinationViewController = destination;
    viewController.cartrawlerAPI = self.cartrawlerAPI;
    viewController.delegate = self;
    
    if (self.isCarRental) {
        viewController.search = [CarRentalSearch instance];
        viewController.groundSearch = nil;
    } else {
        viewController.groundSearch = [GroundTransportSearch instance];
        viewController.search = nil;
    }
    
    viewController.validationController = validationController;
    
    return viewController;
}

- (void)rerouteViewController:(CTViewController *)viewController
                  destination:(CTViewController *)destination
{
    viewController.destinationViewController = destination;
}


#pragma mark Push Notifications

+ (void)registerForPushNotifications:(NSData *)deviceToken
{
    //send call to server
}

+ (void)didReceivePushNotification:(NSDictionary *)notification
{
    //open booking info
}

#pragma Crash handling

void uncaughtExceptionHandler(NSException *exception)
{
    NSLog(@"\n\n\nCartrawlerSDK Crash:\n%@\n\n\n", exception);
    NSLog(@"\n\n\nCartrawlerSDK Stack Trace:\n\n\n%@", exception.callStackSymbols);
}

#pragma CTViewControllerDelegate

- (void)didDismissViewController
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didCancelVehicleBooking)]) {
        [self.delegate didCancelVehicleBooking];
    }
}

- (void)didBookVehicle:(CTBooking *)booking
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didBookVehicle:)]) {
        [self.delegate didBookVehicle:booking];
    }
}

- (void)didBookGroundTransport:(CTRentalBooking *)booking
{
    if (self.delegate) {
        
    }
}

- (void)didProduceInPathRequest:(NSDictionary *)request vehicle:(CTInPathVehicle *)vehicle
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didGenerateInPathRequest:vehicle:)]) {
        [self.delegate didGenerateInPathRequest:request vehicle:vehicle];
    }
}


@end
