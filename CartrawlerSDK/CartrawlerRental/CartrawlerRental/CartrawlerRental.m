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
#import "CTRentalBookingsViewController.h"
#import "CTBasketValidation.h"
#import "CTSearchValidation.h"
#import "CTGenericValidation.h"
#import "CTInsuranceValidation.h"
#import "CTDriverDetailsValidation.h"
#import "CTBookingCompletionValidation.h"
#import "CTPaymentValidation.h"
#import "CTRentalConstants.h"

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
    [CTSDKSettings instance].disableCurrencySelection = NO;
    [[CTSDKSettings instance] resetCountryToDeviceLocale];
    [[CTRentalSearch instance] reset];
    [self configureViews];
    [self presentRentalNavigationController:viewController];
    [[CTAnalytics instance] tagScreen:@"Visit" detail:@"stand" step:@1];
}

- (void)presentRentalNavigationController:(UIViewController *)parent
{
    CTNavigationController *navController = [[CTNavigationController alloc] init];
    navController.navigationBar.hidden = YES;
    navController.modalPresentationStyle = [CTAppearance instance].modalPresentationStyle;
    navController.modalTransitionStyle = [CTAppearance instance].modalTransitionStyle;
    
    if ([CTDataStore checkHasUpcomingBookings]) {
        UIStoryboard *landingStoryboard = [UIStoryboard storyboardWithName:CTRentalBookingManagerStoryboard bundle:self.bundle];
        CTRentalBookingsViewController *upcomingBookingsVC = [landingStoryboard instantiateViewControllerWithIdentifier:CTRentalBookingManagerViewIdentifier];
        
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
            [(CTSearchDetailsViewController *)self.searchDetailsViewController performSearch];
        }
    }
}

#pragma mark View Config
- (void)setDefaultViews
{
    UIStoryboard *searchStoryboard = [UIStoryboard storyboardWithName:CTRentalSearchStoryboard bundle:self.bundle];
    _searchDetailsViewController = [searchStoryboard instantiateViewControllerWithIdentifier:CTRentalSearchViewIdentifier];
    
    UIStoryboard *searchResultsStoryboard = [UIStoryboard storyboardWithName:CTRentalResultsStoryboard bundle:self.bundle];
    _vehicleSelectionViewController = [searchResultsStoryboard instantiateViewControllerWithIdentifier:CTRentalResultsViewIdentifier];
    
    UIStoryboard *vehicleDetailsStoryboard = [UIStoryboard storyboardWithName:CTRentalVehicleDetailsStoryboard bundle:self.bundle];
    _vehicleDetailsViewController = [vehicleDetailsStoryboard instantiateViewControllerWithIdentifier:CTRentalVehicleDetailsViewIdentifier];
    
    UIStoryboard *extrasStoryboard = [UIStoryboard storyboardWithName:CTRentalExtrasStoryboard bundle:self.bundle];
    _insuranceCTExtrasViewController = [extrasStoryboard instantiateViewControllerWithIdentifier:CTRentalInsuranceViewIdentifier];
    _extrasViewController = [extrasStoryboard instantiateViewControllerWithIdentifier:CTRentalExtrasViewIdentifier];
    
    UIStoryboard *summaryStoryboard = [UIStoryboard storyboardWithName:CTRentalBookingSummaryStoryboard bundle:self.bundle];
    _paymentSummaryViewController = [summaryStoryboard instantiateViewControllerWithIdentifier:CTRentalBookingSummaryViewIdentifier];
    
    UIStoryboard *detailsStoryboard = [UIStoryboard storyboardWithName:CTRentalDriverDetailsStoryboard bundle:self.bundle];
    _driverDetialsViewController = [detailsStoryboard instantiateViewControllerWithIdentifier:CTRentalDriverDetailsViewIdentifier];
    _addressDetialsViewController = [detailsStoryboard instantiateViewControllerWithIdentifier:CTRentalDriverAddressViewIdentifier];
    
    UIStoryboard *paymentStoryboard = [UIStoryboard storyboardWithName:CTRentalPaymentStoryboard bundle:self.bundle];
    _paymentViewController = [paymentStoryboard instantiateViewControllerWithIdentifier:CTRentalPaymentViewIdentifier];
    _paymentCompletionViewController = [paymentStoryboard instantiateViewControllerWithIdentifier:CTRentalPaymentCompletionViewIdentifier];
}

- (void)configureViews
{
    [self.cartrawlerSDK configureViewController:self.searchDetailsViewController
                           validationController:[[CTSearchValidation alloc] init]
                                    destination:self.vehicleSelectionViewController
                                       fallback:nil
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.vehicleSelectionViewController
                           validationController:[[CTGenericValidation alloc] init]
                                    destination:self.vehicleDetailsViewController
                                       fallback:nil
                                  optionalRoute:self.searchDetailsViewController
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.vehicleDetailsViewController
                           validationController:[[CTInsuranceValidation alloc] init]
                                    destination:self.insuranceCTExtrasViewController
                                       fallback:self.driverDetialsViewController
                                  optionalRoute:self.extrasViewController
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.insuranceCTExtrasViewController
                           validationController:[[CTGenericValidation alloc] init]
                                    destination:self.driverDetialsViewController
                                       fallback:nil
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.extrasViewController
                           validationController:[[CTGenericValidation alloc] init]
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
                           validationController:[[CTPaymentValidation alloc] init]
                                    destination:self.paymentSummaryViewController
                                       fallback:nil
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.paymentSummaryViewController
                           validationController:[[CTGenericValidation alloc] init]
                                    destination:self.paymentViewController
                                       fallback:nil
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.paymentViewController
                           validationController:[[CTBookingCompletionValidation alloc] init]
                                    destination:self.paymentCompletionViewController
                                       fallback:nil
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    [self.cartrawlerSDK configureViewController:self.paymentCompletionViewController
                           validationController:[[CTGenericValidation alloc] init]
                                    destination:nil
                                       fallback:nil
                                  optionalRoute:nil
                                         search:[CTRentalSearch instance]
                                         target:self];
    
    
}

#pragma CTViewControllerDelegate

- (void)didDismissViewController:(NSString *)identifier
{

}

- (void)didBookVehicle:(CTBooking *)booking
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didBookVehicle:)]) {
        [self.delegate didBookVehicle:booking];
    }
}

@end
