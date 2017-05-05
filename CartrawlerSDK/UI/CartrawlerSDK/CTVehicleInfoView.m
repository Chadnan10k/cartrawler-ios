//
//  CTVehicleInfoView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 21/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleInfoView.h"
#import "CTVehicleDetailsView.h"
#import "CTInsuranceView.h"
#import "CTRentalConstants.h"
#import "CTInsuranceDetailViewController.h"
#import "CTCountryPickerView.h"
#import "CTVehicleSelectionViewController.h"
#import <CartrawlerSDK/CTLoadingView.h>
#import <CartrawlerSDK/CartrawlerSDK+UIView.h>
#import "CTExtrasCarouselView.h"
#import "CTExtrasListViewController.h"
#import "CTRentalLocalizationConstants.h"
#import "CTVehicleInfoTabView.h"

@interface CTVehicleInfoView () <CTVehicleDetailsDelegate, CTInfoTipDelegate, CTInsuranceDelegate, CTInsuranceDetailDelegate, CTCountryPickerDelegate, CTViewControllerDelegate, CTExtrasCarouselViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) CTNextButton *nextButton;
@property (strong, nonatomic) CTAlertViewController *alertView;
@property (strong, nonatomic) CTLayoutManager *layoutManager;

//Nested views
@property (nonatomic, strong) CTVehicleDetailsView *vehicleDetailsView;
@property (nonatomic, strong) CTInfoTip *vehicleInfoTip;
@property (nonatomic, strong) CTInfoTip *extrasInfoTip;
@property (nonatomic, strong) CTInsuranceView *insuranceView;
@property (nonatomic, strong) CTExtrasCarouselView *extrasView;
@property (nonatomic, strong) CTVehicleInfoTabView *tabView;

//Alert view custom views
@property (nonatomic, strong) CTCountryPickerView *countryPicker;

//Temporary variables
@property (nonatomic, strong) NSString *tempCountryCode;

@end

@implementation CTVehicleInfoView

- (instancetype)init
{
    self = [super init];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self initNextButton];
    [self initContainerView];

    _layoutManager = [CTLayoutManager layoutManagerWithContainer:self.containerView];

    [self initVehicleDetailsView];
    [self initVehicleDetailsInfoTip];
    [self initInsuranceView];
    [self initAlertView];
    [self initExtrasView];

    [self.layoutManager layoutViews];
    return self;
}

- (void)refreshView
{
    _tempCountryCode = [CTSDKSettings instance].homeCountryCode;
    self.search.isBuyingInsurance = NO;
    self.search.insurance = nil;
    [self.vehicleDetailsView setVehicle:self.search.selectedVehicle.vehicle
                             pickupDate:self.search.pickupDate
                            dropoffDate:self.search.dropoffDate];
    __weak typeof(self) weakSelf = self;
    [self.insuranceView retrieveInsurance:self.cartrawlerAPI
                                   search:self.search
                               completion:^(CTInsurance *insurance) {
                                   weakSelf.search.insurance = insurance;
                               }];
    
    [self.extrasView updateWithExtras:self.search.selectedVehicle.vehicle.extraEquipment];
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    
    if (self.tabView) {
        NSInteger index = [self.layoutManager indexOfObject:self.tabView].integerValue;
        [self.layoutManager removeAtIndex:index];
        [self.tabView removeFromSuperview];
    }
    self.tabView = [[CTVehicleInfoTabView alloc] initWithAvailabilityItem:self.search.selectedVehicle containerView:self];
    [self.layoutManager insertViewAtIndex:2 padding:UIEdgeInsetsMake(8, 0, 8, 0) view:self.tabView];
    [self.layoutManager layoutViews];
}

/**
 View Creation
 */

- (void)initContainerView
{
    _scrollView = [UIScrollView new];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollView];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[scrollView]-0-[button(80)]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"scrollView" : self.scrollView,
                                                                           @"button" : self.nextButton}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"scrollView" : self.scrollView,
                                                                           @"button" : self.nextButton}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[button]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"scrollView" : self.scrollView,
                                                                           @"button" : self.nextButton}]];
    
    _containerView = [UIView new];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.containerView];
    [CTLayoutManager pinView:self.containerView toSuperView:self.scrollView padding:UIEdgeInsetsZero];
    [self.containerView setHeightConstraint:@100 priority:@100];
    
    NSLayoutConstraint *equalWidth = [NSLayoutConstraint constraintWithItem:self.containerView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.scrollView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1
                                                                   constant:0];
    [self.scrollView addConstraint:equalWidth];
}

- (void)initNextButton
{
    _nextButton = [CTNextButton new];
    self.nextButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.nextButton setText:@"Test Next"];
    [self addSubview:self.nextButton];
    [self.nextButton addTarget:self action:@selector(pushToDestination) forControlEvents:UIControlEventTouchUpInside];
}

//MARK: Alert View Init

- (void)initAlertView
{
    _alertView = [CTAlertViewController alertControllerWithTitle:@"Test" message:@"Test"];
    self.alertView.backgroundTapDismissalGestureEnabled = YES;
    
    [self.alertView addAction:[CTAlertAction actionWithTitle:@"Test OK" handler:^(CTAlertAction *action) {
        
    }]];
    
    _countryPicker = [CTCountryPickerView new];
    self.countryPicker.delegate = self;
}


// MARK: Vehicle Details View Init
- (void)initVehicleDetailsView
{
    _vehicleDetailsView = [CTVehicleDetailsView new];
    self.vehicleDetailsView.delegate = self;
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 0, 8, 0) view:self.vehicleDetailsView];
}

// MARK: Vehicle Info Tip
- (void)initVehicleDetailsInfoTip
{
    _vehicleInfoTip = [[CTInfoTip alloc] initWithIcon:nil text:@"Good news. Free cancellation and amendments with your booking."];
    _vehicleInfoTip.delegate = self;
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.vehicleInfoTip];
}


- (NSAttributedString *)attributedStringWithBlackText:(NSString *)blackText blueText:(NSString *)blueText {
    NSDictionary *blackAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18.0],
                                      NSForegroundColorAttributeName : [UIColor blackColor]};
    NSDictionary *blueAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18.0],
                                     NSForegroundColorAttributeName : [UIColor colorWithRed:42.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0]};
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:blackText attributes:blackAttributes];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:blueText attributes:blueAttributes]];
    
    return string.copy;
}

// MARK: Insurance View
- (void)initInsuranceView
{
    _insuranceView = [CTInsuranceView new];
    self.insuranceView.delegate = self;
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 0, 8, 0) view:self.insuranceView];
}

// MARK: Extras View

- (void)initExtrasView {
    self.extrasView = [CTExtrasCarouselView new];
    [self.extrasView updateWithExtras:self.search.selectedVehicle.vehicle.extraEquipment];
    self.extrasView.delegate = self;
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 0, 8, 0) view:self.extrasView];
}

- (void)extrasViewDidTapViewAll:(CTExtrasCarouselView *)extrasView {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:CTRentalExtrasStoryboard bundle:bundle];
    CTExtrasListViewController *controller = (CTExtrasListViewController *)[storyboard instantiateViewControllerWithIdentifier:CTRentalExtrasVerticalViewIdentifier];
    [controller updateWithExtras:self.search.selectedVehicle.vehicle.extraEquipment];
    if (self.delegate) {
        [self.delegate infoViewPushViewController:controller];
    }
}

/**
 View Delegates
 */

// MARK: CTVehicleDetailsDelegate
- (void)didTapMoreDetailsView:(UIView *)view
{
    if (self.delegate) {
        [self.alertView setTitle:CTLocalizedString(CTRentalFeatureTitle) message:nil];
        [self.alertView removeAllActions];
        __weak typeof(self) weakSelf = self;
        [self.alertView addAction:[CTAlertAction actionWithTitle:CTLocalizedString(CTRentalCTADone)
                                                         handler:^(CTAlertAction *action) {
                                                             [weakSelf.alertView dismissViewControllerAnimated:YES completion:nil];
                                                         }]];
        self.alertView.customView = view;
        [self.delegate infoViewPresentViewController:self.alertView];
    }
}

// MARK: CTInfoTipDelegate
- (void)infoTipWasTapped:(CTInfoTip *)infoTip
{
    if (infoTip == self.extrasInfoTip) {
        if (self.delegate) {
            [self.delegate infoViewPushToExtraDetail];
        }
    }
}

// MARK: CTInsurance Delegate
- (void)didAddInsurance:(CTInsurance *)insurance
{
    [self presentInsuranceAlert];
}

- (void)didRemoveInsurance
{
    self.search.insurance = nil;
    self.search.isBuyingInsurance = NO;
}

- (void)didTapMoreInsuranceDetail
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:CTRentalExtrasStoryboard bundle:bundle];
    CTInsuranceDetailViewController *detailViewController = [storyboard instantiateViewControllerWithIdentifier:CTRentalInsuranceViewIdentifier];
    detailViewController.search = self.search;
    detailViewController.insuranceDetailDelegate = self;
    if (self.delegate) {
        [self.delegate infoViewPushViewController:detailViewController];
    }
}

- (void)didTapAddInsurance:(CTInsuranceDetailViewController *)detailViewController
{
    [self presentInsuranceAlert];
}

- (void)presentInsuranceAlert
{
    CTAlertViewController *alert = [CTAlertViewController alertControllerWithTitle:@"Yo!" message:@"We need to confirm this is the country you were born in."];
    
    [alert addAction:[CTAlertAction actionWithTitle:@"Cancel" handler:^(CTAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alert addAction:[CTAlertAction actionWithTitle:@"Confirm" handler:^(CTAlertAction *action) {
        [self checkIfNeedsRefresh:alert];
    }]];
    
    alert.customView = self.countryPicker;
    
    if (self.delegate) {
        [self.delegate infoViewPresentViewController:alert];
    }
}

- (void)didChangeCountrySelection:(NSString *)countryCode
{
    _tempCountryCode = countryCode;
}

- (void)checkIfNeedsRefresh:(CTAlertViewController *)alert
{
    if (![self.tempCountryCode isEqualToString:[CTSDKSettings instance].homeCountryCode]) {
        
        //remove
        [alert setTitle:@"Loading" message:@"Finding best price"];
        [alert removeAllActions];
        alert.customView = [CTLoadingView new];
        
        [[CTSDKSettings instance] setHomeCountryCode:self.tempCountryCode];
        [[CTSDKSettings instance] setHomeCountryName:[[CTSDKSettings instance] countryName:self.tempCountryCode]];
        __weak typeof(self) weakSelf = self;
        
        if (self.delegate) {
            [self.delegate infoViewRequestNewVehiclePrice:^(BOOL success, NSString *error) {
                if (success) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [alert dismissViewControllerAnimated:YES completion:nil];
                        [weakSelf refreshView];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [alert dismissViewControllerAnimated:YES completion:nil];
                        [weakSelf presentVehicleSelection];
                    });
                }
            }];
        }
        

    } else {
        NSLog(@"no refresh needed");
        [alert dismissViewControllerAnimated:YES completion:nil];
        self.search.isBuyingInsurance = YES;
        [self.insuranceView presentSelectedState];
    }
}

- (void)pushToDestination
{
    if (self.delegate) {
        [self.delegate infoViewPushToNextStep];
    }
}

// MARK: Actions
- (IBAction)backTapped:(id)sender
{
//    if (self.navigationController.viewControllers.firstObject == self) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    } else {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}

- (IBAction)nextTapped:(id)sender
{
//    if (self.destinationViewController) {
//        [self pushToDestination];
//    } else {
//        [self dismiss];
//    }
}

// MARK: Presentation

- (void)presentVehicleSelection
{
    if (self.delegate) {
        [self.delegate infoViewPresentVehicleSelection];
    }
}

- (void)didDismissViewController:(NSString *)identifier
{
    
}

@end
