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
#import "CTRentalScrollingLogic.h"

@interface CTVehicleDetailsViewController () <CTVehicleInfoDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *totalView;
@property (nonatomic, strong) CTRentalScrollingLogic *scrollingLogic;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *totalViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *totalViewTopConstraint;
@property (weak, nonatomic) IBOutlet CTPaymentSummaryExpandedView *paymentSummaryView;
@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *dimmingView;
@property (weak, nonatomic) IBOutlet CTButton *carTotalButton;

@property (strong, nonatomic) CTVehicleInfoView *vehicleInfoView;

@end

@implementation CTVehicleDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = CTLocalizedString(CTRentalTitleDetails);
    
    _vehicleInfoView = [[CTVehicleInfoView alloc] initWithVerticalOffset:self.totalViewHeightConstraint.constant];
    self.vehicleInfoView.search = self.search;
    self.vehicleInfoView.cartrawlerAPI = self.cartrawlerAPI;
    self.vehicleInfoView.isStandalone = YES;
    self.vehicleInfoView.delegate = self;
    
    [self.containerView addSubview:self.vehicleInfoView];
    
    [CTLayoutManager pinView:self.vehicleInfoView
                 toSuperView:self.containerView
                     padding:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    self.scrollingLogic = [[CTRentalScrollingLogic alloc] initWithTopViewHeight:self.totalViewHeightConstraint.constant];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.vehicleInfoView refreshViewWithVehicle:self.search.selectedVehicle];
    
    [self updateDetailedPriceSummary];
    [self updatePriceSummary:self.search.isBuyingInsurance];
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
    [self updatePriceSummary:didAddInsurance];
}

- (void)infoViewDidScroll:(CGFloat)verticalOffset
{
    self.totalViewTopConstraint.constant = [self.scrollingLogic offsetForDesiredOffset:verticalOffset
                                                                         currentOffset:self.totalViewTopConstraint.constant];
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

- (void)updatePriceSummary:(BOOL)isBuyingInsurance
{
    NSString *price = @"";
    
    if (isBuyingInsurance) {
        price = [[NSNumber numberWithFloat:self.search.selectedVehicle.vehicle.totalPriceForThisVehicle.floatValue + self.search.insurance.premiumAmount.floatValue] numberStringWithCurrencyCode];
    } else {
        price = [self.search.selectedVehicle.vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode];
    }
    
    NSAttributedString *priceString = [NSString attributedText:CTLocalizedString(CTRentalCarRentalTotal)
                                                     boldColor:[UIColor whiteColor]
                                                      boldSize:17
                                                   regularText:price
                                                  regularColor:[UIColor whiteColor]
                                                   regularSize:17
                                                      useSpace:YES];
    
    [self.carTotalButton setAttributedTitle:priceString forState:UIControlStateNormal];
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
    [self.vehicleInfoView refreshViewWithVehicle:nil];
    
    if (self.navigationController.viewControllers.firstObject == self) {
        if (self.vehicleInfoView.insuranceViewDidAppear) {
            [[CTAnalytics instance] tagScreen:@"back_btn" detail:@"vehicle-e" step:nil];
        } else {
            [[CTAnalytics instance] tagScreen:@"back_btn" detail:@"vehicle-v" step:nil];
        }
        
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
