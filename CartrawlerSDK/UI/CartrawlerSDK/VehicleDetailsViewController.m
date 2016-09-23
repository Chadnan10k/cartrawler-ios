//
//  VehicleDetailsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "VehicleDetailsViewController.h"
#import "VehicleDetailsView.h"
#import "ExpandingInfoView.h"
#import "CTAppearance.h"
#import "CTLabel.h"
#import "TabButton.h"
#import "NSNumberUtils.h"
#import "SupplierRatingsViewController.h"
#import "CTSDKSettings.h"
#import "CTButton.h"
#import "CTSegmentedControl.h"

@interface VehicleDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIView *vehicleDetailsContainer;
@property (weak, nonatomic) IBOutlet UIView *vendorRatingContainer;
@property (weak, nonatomic) IBOutlet ExpandingInfoView *pickupLocationView;
@property (weak, nonatomic) IBOutlet ExpandingInfoView *fuelPolicyView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vehicleDetailsHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vendorRatingHeightConstraint;
@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;
@property (weak, nonatomic) VehicleDetailsView *vehicleDetailView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet CTButton *continueButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@end

@implementation VehicleDetailsViewController

+ (void)forceLinkerLoad_ {}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self detailsTapped];
    
    self.continueButton.enabled = YES;
    
    [self.scrollView setContentOffset:
     CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
        
    if (self.vehicleDetailView) {
        [self.vehicleDetailView setData:[CarRentalSearch instance]
                                    api:self.cartrawlerAPI
                             pickupDate:self.search.pickupDate
                             returnDate:self.search.dropoffDate
                             pickupCode:self.search.pickupLocation.code
                             returnCode:self.search.dropoffLocation.code
                            homeCountry:[CTSDKSettings instance].homeCountryCode];
        
        [self.vehicleDetailView setupView];
    }
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *b = [NSBundle bundleWithPath:bundlePath];
    
    if (self.search.selectedVehicle.vendor.pickupLocation.atAirport) {
        [self.pickupLocationView setTitle:@"At Airport"
                                     text:NSLocalizedString(@"This supplier is located in the airport.", @"This supplier is located in the airport.")
                                    image:[UIImage imageNamed:@"airport_gray" inBundle:b compatibleWithTraitCollection:nil]];
    } else {
        
        NSArray *addressComponents = [self.search.selectedVehicle.vendor.pickupLocation.address componentsSeparatedByString:@","];
        
        NSMutableString *address = [[NSMutableString alloc] init];

        for (int i = 0; i < addressComponents.count; ++i) {
            [address appendString:[addressComponents[i] stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            
            if (i != addressComponents.count-1) {
                [address appendString:@"\n"];
            }
        }
        
        [self.pickupLocationView setTitle:@"Supplier address"
                                     text:address
                                    image:[UIImage imageNamed:@"address" inBundle:b compatibleWithTraitCollection:nil]];
    }
    
    [self.fuelPolicyView setTitle:@"Fuel policy"
                             text:self.search.selectedVehicle.vehicle.fuelPolicyDescription
                            image:[UIImage imageNamed:@"fuel" inBundle:b compatibleWithTraitCollection:nil]];
    
    [self.view layoutIfNeeded];
    
    if (self.search.selectedVehicle.vehicle.totalPriceForThisVehicle) {
        
        NSArray *priceStrings = [[NSNumberUtils numberStringWithCurrencyCode:self.search.selectedVehicle.vehicle.totalPriceForThisVehicle] componentsSeparatedByString:@"."];
        NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *dollars = [[NSAttributedString alloc] initWithString:priceStrings.firstObject
                                                                      attributes:@{NSFontAttributeName:
                                                                                       [UIFont fontWithName:[CTAppearance instance].boldFontName size:20]}];
        
        NSAttributedString *dot = [[NSAttributedString alloc] initWithString:@"."
                                                                  attributes:@{NSFontAttributeName:
                                                                                   [UIFont fontWithName:[CTAppearance instance].boldFontName size:14]}];
        
        NSAttributedString *cents = [[NSAttributedString alloc] initWithString:priceStrings.lastObject
                                                                    attributes:@{NSFontAttributeName:
                                                                                     [UIFont fontWithName:[CTAppearance instance].boldFontName size:14]}];
        
        [priceString appendAttributedString:dollars];
        [priceString appendAttributedString:dot];
        [priceString appendAttributedString:cents];
        
        self.priceLabel.attributedText = priceString;
    }
    
}

- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"VehicleEmbed"]) {
        _vehicleDetailView = (VehicleDetailsView *)segue.destinationViewController;
        [self.vehicleDetailView
         setData:[CarRentalSearch instance]
                api:self.cartrawlerAPI
         pickupDate:self.search.pickupDate
         returnDate:self.search.dropoffDate
         pickupCode:self.search.pickupLocation.code
         returnCode:self.search.dropoffLocation.code
        homeCountry:@"IE"];
        
        self.vehicleDetailView.heightChanged = ^(CGFloat height) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.vehicleDetailsHeightConstraint.constant = height + 265;
            });
        };
    }
}

- (void)detailsTapped
{
    
    [self.vehicleDetailView setupView];
    
    self.vehicleDetailView.heightChanged = ^(CGFloat height) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.vehicleDetailsHeightConstraint.constant = height + 265;
        });
    };
    
    self.vehicleDetailsContainer.alpha = 1;
    self.vendorRatingContainer.alpha = 0;
}

- (void)supplierTapped
{
    
    self.vehicleDetailsHeightConstraint.constant = 170;

    
    self.vehicleDetailsContainer.alpha = 0;
    self.vendorRatingContainer.alpha = 1;
}

- (IBAction)continueTapped:(id)sender {

    if (self.tappedContinue) {
        self.tappedContinue(YES);
    }
    
    [self.activityView startAnimating];
    
    self.continueButton.enabled = NO;
}

- (void)stopAnimating
{
    [self.activityView stopAnimating];
}

@end
