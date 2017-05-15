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
#import "CTTermsViewController.h"

@interface CTVehicleInfoView () <CTVehicleDetailsDelegate, CTInfoTipDelegate, CTInsuranceDelegate, CTViewControllerDelegate, CTExtrasCarouselViewDelegate>

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
@property (nonatomic, strong) CTButton *termsButton;

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
    [self initTermsAndConditionsView];

    [self.layoutManager layoutViews];
    return self;
}

- (void)refreshView
{
    _tempCountryCode = [CTSDKSettings instance].homeCountryCode;
    self.search.isBuyingInsurance = NO;
    self.search.insurance = nil;
    [self.vehicleDetailsView setItem:self.search.selectedVehicle
                             pickupDate:self.search.pickupDate
                            dropoffDate:self.search.dropoffDate];
    __weak typeof(self) weakSelf = self;
    [self.insuranceView retrieveInsurance:self.cartrawlerAPI
                                   search:self.search
                               completion:^(CTInsurance *insurance) {
                                   weakSelf.search.insurance = insurance;
                               }];
    
    [self.extrasView updateWithExtras:self.search.selectedVehicle.vehicle.extraEquipment];
    
    NSNumber *extrasIndex = [self.layoutManager indexOfObject:self.extrasView];
    NSNumber *termsIndex = [self.layoutManager indexOfObject:self.termsButton];

    if (self.search.selectedVehicle.vehicle.extraEquipment.count > 0 && termsIndex && !extrasIndex) {
        [self.layoutManager insertViewAtIndex:termsIndex.intValue padding:UIEdgeInsetsMake(8, 0, 8, 0) view:self.extrasView];
    } else if (extrasIndex) {
        [self.layoutManager removeAtIndex:extrasIndex.intValue];
    }
    
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
    
    if (self.isStandalone) {
        [self.nextButton setText:CTLocalizedString(CTRentalCTAContinue)];
    } else {
        [self.nextButton setText:CTLocalizedString(CTRentalCTAAddVehicleToBasket)];
    }
    
    [self addSubview:self.nextButton];
    [self.nextButton addTarget:self action:@selector(pushToDestination) forControlEvents:UIControlEventTouchUpInside];
}

//MARK: Alert View Init

- (void)initAlertView
{
    _alertView = [CTAlertViewController alertControllerWithTitle:@"" message:@""];
    self.alertView.backgroundTapDismissalGestureEnabled = YES;
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
    _vehicleInfoTip = [[CTInfoTip alloc] initWithIcon:nil text:CTLocalizedString(CTRentalFreeCancelationDetail)];
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

//MARK: terms and conditions

- (void)initTermsAndConditionsView
{
    _termsButton = [[CTButton alloc] init:[UIColor clearColor] fontColor:[CTAppearance instance].buttonTextColor boldFont:YES borderColor:nil];
    [self.termsButton setTitle:CTLocalizedString(CTRentalIncludedTerms) forState:UIControlStateNormal];
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 0, 8, 0) view:self.termsButton];
    [self.termsButton addTarget:self action:@selector(openTermsAndConditons) forControlEvents:UIControlEventTouchUpInside];
}

- (void)openTermsAndConditons
{
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:CTRentalVehicleDetailsStoryboard bundle:bundle];
    UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"CTTermsViewControllerNav"];
    CTTermsViewController *vc = (CTTermsViewController *)nav.topViewController;
    [vc setData:self.search cartrawlerAPI:self.cartrawlerAPI];
    
    if (self.delegate) {
        [self.delegate infoViewPresentViewController:nav];
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
    self.search.isBuyingInsurance = YES;
    if (self.delegate) {
        [self.delegate infoViewAddInsuranceTapped:YES];
    }
}

- (void)didRemoveInsurance
{
    self.search.isBuyingInsurance = NO;
    if (self.delegate) {
        [self.delegate infoViewAddInsuranceTapped:NO];
    }
}

- (void)didTapMoreInsuranceDetail
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:CTRentalExtrasStoryboard bundle:bundle];
    CTInsuranceDetailViewController *detailViewController = [storyboard instantiateViewControllerWithIdentifier:CTRentalInsuranceViewIdentifier];
    detailViewController.search = self.search;
    if (self.delegate) {
        [self.delegate infoViewPushViewController:detailViewController];
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
