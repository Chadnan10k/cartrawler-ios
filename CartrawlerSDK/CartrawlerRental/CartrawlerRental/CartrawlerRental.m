//
//  CartrawlerRental.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 16/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerRental.h"
#import <CartrawlerSDK/CTSDKSettings.h>
#import <CartrawlerSDK/CTNavigationController.h>
#import <CartrawlerSDK/CTDataStore.h>
#import "RentalBookingsViewController.h"
#import "CTBasketValidation.h"
#import "SearchDetailsViewController.h"
#import "SearchValidation.h"
#import "GenericValidation.h"
#import "InsuranceValidation.h"
#import "CTDriverDetailsValidation.h"
#import "BookingCompletionValidation.h"
#import "PaymentValidation.h"

#define kSearchViewStoryboard           @"StepOne"
#define kSearchResultsViewStoryboard    @"StepTwo"
#define kVehicleDetailsViewStoryboard   @"StepThree"
#define kExtrasViewStoryboard           @"StepFour"
#define kSummaryViewStoryboard          @"StepFive"
#define kDetailsViewStoryboard          @"StepSix"
#define kPaymentViewStoryboard          @"Payment"

@interface CartrawlerRental() <CTViewControllerDelegate>

@property (nonatomic, strong, nonnull, readonly) NSBundle *bundle;

@end

@implementation CartrawlerRental

- (instancetype)initWithCartrawlerSDK:(nonnull CartrawlerSDK *)cartrawlerSDK
{
    self = [super init];
    _bundle = [NSBundle bundleForClass:[self class]];
    _cartrawlerSDK = cartrawlerSDK;
    [self setDefaultViews];
    [self configureViews];
    return self;
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
        
        [self.cartrawlerSDK configureViewController:upcomingBookingsVC
                               validationController:[[CTBasketValidation alloc] init]
                                        destination:self.searchDetailsViewController
                                           fallback:nil
                                      optionalRoute:nil
                                             search:[CTRentalSearch instance]
                                             target:self];
        
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
}

- (void)configureViews
{
    [self.cartrawlerSDK configureViewController:self.searchDetailsViewController
                           validationController:[[SearchValidation alloc] init]
                                    destination:self.vehicleSelectionViewController
                                       fallback:nil
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.vehicleSelectionViewController
                           validationController:[[GenericValidation alloc] init]
                                    destination:self.vehicleDetailsViewController
                                       fallback:nil
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.vehicleDetailsViewController
                           validationController:[[InsuranceValidation alloc] init]
                                    destination:self.insuranceExtrasViewController
                                       fallback:self.driverDetialsViewController
                                  optionalRoute:self.extrasViewController
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.insuranceExtrasViewController
                           validationController:[[GenericValidation alloc] init]
                                    destination:self.driverDetialsViewController
                                       fallback:nil
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.extrasViewController
                           validationController:[[GenericValidation alloc] init]
                                    destination:self.driverDetialsViewController
                                       fallback:nil
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.driverDetialsViewController
                           validationController:[[CTDriverDetailsValidation alloc] init]
                                    destination:self.addressDetialsViewController
                                       fallback:self.paymentSummaryViewController
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.addressDetialsViewController
                           validationController:[[PaymentValidation alloc] init]
                                    destination:self.paymentSummaryViewController
                                       fallback:nil
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.paymentSummaryViewController
                           validationController:[[GenericValidation alloc] init]
                                    destination:self.paymentViewController
                                       fallback:nil
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.paymentViewController
                           validationController:[[BookingCompletionValidation alloc] init]
                                    destination:self.paymentCompletionViewController
                                       fallback:nil
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.paymentCompletionViewController
                           validationController:[[GenericValidation alloc] init]
                                    destination:nil
                                       fallback:nil
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    
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
