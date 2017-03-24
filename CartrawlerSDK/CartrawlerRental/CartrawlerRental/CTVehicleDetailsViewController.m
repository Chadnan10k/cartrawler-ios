//
//  CTVehicleDetailsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleDetailsViewController.h"
#import "CTVehicleDetailsView.h"
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTSDKSettings.h>
#import <CartrawlerSDK/CTLayoutManager.h>
#import <CartrawlerSDK/CTInfoTip.h>
#import <CartrawlerSDK/CTAlertViewController.h>
#import "CTInsuranceView.h"

@interface CTVehicleDetailsViewController () <CTVehicleDetailsDelegate, CTInfoTipDelegate, CTInsuranceDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet CTNextButton *nextButton;
@property (strong, nonatomic) CTAlertViewController *alertView;
@property (strong, nonatomic) CTLayoutManager *layoutManager;

//Nested views
@property (nonatomic, strong) CTVehicleDetailsView *vehicleDetailsView;
@property (nonatomic, strong) CTInfoTip *vehicleInfoTip;
@property (nonatomic, strong) CTInfoTip *extrasInfoTip;
@property (nonatomic, strong) CTInsuranceView *insuranceView;

@end

@implementation CTVehicleDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nextButton setText:@"Test Next"];
    
    _layoutManager = [CTLayoutManager layoutManagerWithContainer:self.containerView];
    
    [self initVehicleDetailsView];
    [self initVehicleDetailsInfoTip];
    [self initInsuranceView];
    [self initExtrasInfoTip];
    [self initAlertView];
      
    [self.layoutManager layoutViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.vehicleDetailsView setVehicle:self.search.selectedVehicle.vehicle
                             pickupDate:self.search.pickupDate
                            dropoffDate:self.search.dropoffDate];
    
    [self.insuranceView retrieveInsurance:self.cartrawlerAPI
                                   search:self.search];

}

/**
 View Creation
 */

//MARK: Alert View Init

- (void)initAlertView
{
    _alertView = [CTAlertViewController alertControllerWithTitle:@"Test" message:@"Test"];
    self.alertView.backgroundTapDismissalGestureEnabled = YES;
    
    [self.alertView addAction:[CTAlertAction actionWithTitle:@"Test OK" handler:^(CTAlertAction *action) {
        
    }]];
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
    _vehicleInfoTip = [[CTInfoTip alloc] initWithIcon:nil text:@"test test test test test"];
    _vehicleInfoTip.delegate = self;
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.vehicleInfoTip];
}

// MARK: Vehicle Info Tip
- (void)initExtrasInfoTip
{
    _extrasInfoTip = [[CTInfoTip alloc] initWithIcon:nil text:@"Add extras to your vehicle"];
    _extrasInfoTip.delegate = self;
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.extrasInfoTip];
}

// MARK: Insurance View
- (void)initInsuranceView
{
    _insuranceView = [CTInsuranceView new];
    self.insuranceView.delegate = self;
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 0, 8, 0) view:self.insuranceView];
}


/**
 View Delegates
 */

// MARK: CTVehicleDetailsDelegate
- (void)didTapMoreDetailsView
{
    [self presentViewController:self.alertView animated:YES completion:nil];
}

// MARK: CTInfoTipDelegate
- (void)infoTipWasTapped:(CTInfoTip *)infoTip
{
    if (infoTip == self.extrasInfoTip) {
        [self.navigationController pushViewController:self.optionalRoute animated:YES];
    }
}

// MARK: CTInsurance Delegate
- (void)didAddInsurance:(CTInsurance *)insurance
{
    self.search.insurance = insurance;
    self.search.isBuyingInsurance = YES;
}

- (void)didRemoveInsurance
{
    self.search.insurance = nil;
    self.search.isBuyingInsurance = NO;
}


- (void)didTapTermsAndConditions:(NSURL *)termsURL
{
    
}

// MARK: Actions
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


@end
