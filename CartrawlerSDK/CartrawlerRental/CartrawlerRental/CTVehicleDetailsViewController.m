//
//  CTVehicleDetailsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleDetailsViewController.h"
#import <CartrawlerSDK/CTHeaders.h>
#import "CTRentalConstants.h"
#import "CTVehicleInfoView.h"
#import "CTPaymentSummaryExpandedView.h"
#import "CTRentalLocalizationConstants.h"

@interface CTVehicleDetailsViewController () <CTVehicleInfoDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet CTPaymentSummaryExpandedView *paymentSummaryView;
@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint  *summaryViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *dimmingView;

@property (strong, nonatomic) CTVehicleInfoView *vehicleInfoView;



//Temporary variables
@property (nonatomic, strong) NSString *tempCountryCode;

@end

@implementation CTVehicleDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = CTLocalizedString(CTRentalTitleDetails);
    
    _vehicleInfoView = [CTVehicleInfoView new];
    self.vehicleInfoView.search = self.search;
    self.vehicleInfoView.cartrawlerAPI = self.cartrawlerAPI;
    self.vehicleInfoView.isStandalone = YES;
    self.vehicleInfoView.delegate = self;
    
    [self.containerView addSubview:self.vehicleInfoView];
    
    [CTLayoutManager pinView:self.vehicleInfoView
                 toSuperView:self.containerView
                     padding:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.vehicleInfoView refreshView];
    
    [self updateDetailedPriceSummary];
}

//MARK: CTVehicleInfoDelegate

- (void)infoViewPresentViewController:(UIViewController *)viewController
{
    [self presentModalViewController:viewController];
}

- (void)infoViewPushToExtraDetail
{
    
}

- (void)infoViewPushViewController:(UIViewController *)viewController
{
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)infoViewRequestNewVehiclePrice:(CTNewVehiclePriceCompeltion)completion
{
    [self requestNewVehiclePrice:completion];
}

- (void)infoViewPresentVehicleSelection
{
//    [self presentVehicleSelection];
}

- (void)infoViewAddInsuranceTapped:(BOOL)didAddInsurance
{
//    [self updatePriceSummary:didAddInsurance];
}

- (void)infoViewPushToNextStep
{
    if (self.navigationController.viewControllers.firstObject == self) {
        [self dismiss];
    } else {
        [self pushToDestination];
    }
}


- (void)updateDetailedPriceSummary
{
    [self.paymentSummaryView updateWithSearch:self.search];
    self.summaryViewHeightConstraint.constant = self.paymentSummaryView.desiredHeight;
    self.summaryViewTopConstraint.constant = -self.paymentSummaryView.desiredHeight;
    [self.view layoutIfNeeded];
}

- (void)showDetailedPriceSummary
{
    [self updateDetailedPriceSummary];
    self.summaryViewTopConstraint.constant = 0;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.dimmingView.alpha = 0.3;
                         [self.view layoutIfNeeded];
                     }];
}

- (void)hideDetailedPriceSummary
{
    self.summaryViewTopConstraint.constant = -self.paymentSummaryView.desiredHeight;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.dimmingView.alpha = 0;
                         [self.view layoutIfNeeded];
                     }];
}

- (IBAction)didInteractWithDetailedPriceSummary:(UIGestureRecognizer *)gestureRecognizer {
    [self hideDetailedPriceSummary];
}


// MARK: Actions

- (IBAction)openSummary:(id)sender
{
    [self showDetailedPriceSummary];
}

- (IBAction)backTapped:(id)sender
{
    if (self.navigationController.viewControllers.firstObject == self) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)nextTapped:(id)sender
{
    if (self.destinationViewController) {
        [self pushToDestination];
    } else {
        [self dismiss];
    }
}

- (void)didDismissViewController:(NSString *)identifier
{
//    [self dismissViewControllerAnimated:YES completion:nil];
}

// MARK: CTvehicle details delegate

@end
