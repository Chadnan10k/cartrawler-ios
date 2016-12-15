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
#import "CTRentalSearch.h"
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
#import "SearchDetailsViewController.h"

#define kSearchViewStoryboard           @"StepOne"
#define kSearchResultsViewStoryboard    @"StepTwo"
#define kVehicleDetailsViewStoryboard   @"StepThree"
#define kExtrasViewStoryboard           @"StepFour"
#define kSummaryViewStoryboard          @"StepFive"
#define kDetailsViewStoryboard          @"StepSix"
#define kPaymentViewStoryboard          @"Payment"

#define kGTViewStoryboard @"GroundTransport"

@interface CartrawlerSDK() <CTViewControllerDelegate>

@property (nonatomic, strong, readonly) CTViewController *searchDetailsViewControllerOverride;

@property (nonatomic, strong) NSArray <CTViewController *> *customViewControllers;

@property (nonatomic, strong) NSBundle *bundle;

@end

@implementation CartrawlerSDK

+ (instancetype)instance
{
    static CartrawlerSDK *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CartrawlerSDK alloc] init];
    });
    return sharedInstance;
}

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
    [[CTSDKSettings instance] resetCountryToDeviceLocale];
    [[CTRentalSearch instance] reset];
    [self configureViews];
    [self presentRentalNavigationController:viewController];

}

- (void)presentRentalNavigationController:(UIViewController *)parent
{
    CTNavigationController *navController = [[CTNavigationController alloc] init];
    navController.navigationBar.hidden = YES;
    navController.modalPresentationStyle = [CTAppearance instance].modalPresentationStyle;
    navController.modalTransitionStyle = [CTAppearance instance].modalTransitionStyle;
    
    if ([CTDataStore checkHasUpcomingBookings]) {
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
        if ([CTRentalSearch instance].pickupDate && [CTRentalSearch instance].dropoffDate) {
            [(SearchDetailsViewController *)self.searchDetailsViewController performSearch];
        }
    }
}

#pragma mark View Config
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
    _paymentSummaryViewController = [summaryStoryboard instantiateViewControllerWithIdentifier:@"CTBookingSummaryViewController"];
    
    UIStoryboard *detailsStoryboard = [UIStoryboard storyboardWithName:kDetailsViewStoryboard bundle:self.bundle];
    _driverDetialsViewController = [detailsStoryboard instantiateViewControllerWithIdentifier:@"DriverDetailsViewController"];
    _addressDetialsViewController = [detailsStoryboard instantiateViewControllerWithIdentifier:@"AddressDetailsViewController"];

    UIStoryboard *paymentStoryboard = [UIStoryboard storyboardWithName:kPaymentViewStoryboard bundle:self.bundle];
    _paymentViewController = [paymentStoryboard instantiateViewControllerWithIdentifier:@"PaymentViewController"];
    _paymentCompletionViewController = [paymentStoryboard instantiateViewControllerWithIdentifier:@"PaymentCompletionViewController"];
    
    //---------------------------------
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

    viewController.search = [CTRentalSearch instance];
    viewController.groundSearch = nil;

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

    viewController.search = [CTRentalSearch instance];
    viewController.groundSearch = nil;
    
    viewController.validationController = validationController;
    
    return viewController;
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

- (void)didDismissViewController:(NSString *)identifier
{
    NSLog(@"CTViewController dismisse at: %@", identifier);
}

- (void)didBookVehicle:(CTBooking *)booking
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didBookVehicle:)]) {
        [self.delegate didBookVehicle:booking];
    }
}

@end
