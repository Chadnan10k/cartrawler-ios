//
//  CTVehicleDetailsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleDetailsViewController.h"
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTSDKSettings.h>
#import "CTVehicleDetailsView.h"
#import "CTInsuranceView.h"

@interface CTVehicleDetailsViewController () <CTVehicleDetailsDelegate, CTInsuranceDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

//Nested views
@property (nonatomic, strong) CTVehicleDetailsView *vehicleDetailsView;
@property (nonatomic, strong) CTInsuranceView *insuranceView;

@end

@implementation CTVehicleDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVehicleDetailsView];
    [self initInsuranceView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.vehicleDetailsView setVehicle:self.search.selectedVehicle.vehicle
                             pickupDate:self.search.pickupDate
                            dropoffDate:self.search.dropoffDate];
    
    [self.insuranceView retrieveInsurance:self.cartrawlerAPI search:self.search];

}

// MARK: Vehicle Details View Init
- (void)initVehicleDetailsView
{
    _vehicleDetailsView = [CTVehicleDetailsView new];
    self.vehicleDetailsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.vehicleDetailsView];
    self.vehicleDetailsView.delegate = self;

    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[vehicleDetailsView]"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:@{@"vehicleDetailsView" : self.vehicleDetailsView}]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[vehicleDetailsView]-0-|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:@{@"vehicleDetailsView" : self.vehicleDetailsView}]];
}

// MARK: Insurance View Init
- (void)initInsuranceView
{
    _insuranceView = [CTInsuranceView new];
    self.insuranceView.delegate = self;
    self.insuranceView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.insuranceView];
    //self.insuranceView.delegate = self;
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-16-[insurance]-20-|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:@{@"insurance" : self.insuranceView, @"top" : self.vehicleDetailsView}]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[insurance]-0-|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:@{@"insurance" : self.insuranceView}]];
}

- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// MARK: CTVehicleDetailsDelegate
- (void)didTapMoreDetailsView
{
    //present alert view
}

// MARK: CTInsuranceDelegate
- (void)didAddInsurance:(CTInsurance *)insurance
{
    NSLog(@"INSURACNE COST: %@", insurance.premiumAmount.stringValue);
}

- (void)didRemoveInsurance
{
    NSLog(@"INsurance remved");
}

- (void)didTapTermsAndConditions:(NSURL *)termsURL
{
    NSLog(@"%@", termsURL);
}

@end
