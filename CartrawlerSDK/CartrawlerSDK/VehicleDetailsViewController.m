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
@property (weak, nonatomic) IBOutlet CTSegmentedControl *tabSelection;
@property (weak, nonatomic) VehicleDetailsView *vehicleDetailView;
@property (weak, nonatomic) SupplierRatingsViewController *supplierRatingView;
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
    
    UIFont *font = [UIFont fontWithName:[CTAppearance instance].fontName size:12];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [self.tabSelection setTitleTextAttributes:attributes
                                     forState:UIControlStateNormal];
    
    [self detailsTapped];
    
    self.continueButton.enabled = YES;
    
    [self.scrollView setContentOffset:
     CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
    
    self.tabSelection.selectedSegmentIndex = 0;
    
    if (self.vehicleDetailView) {
        [self.vehicleDetailView setData:self.search.selectedVehicle
                                    api:self.cartrawlerAPI
                             pickupDate:self.search.pickupDate
                             returnDate:self.search.dropoffDate
                             pickupCode:self.search.pickupLocation.code
                             returnCode:self.search.dropoffLocation.code
                            homeCountry:[CTSDKSettings instance].homeCountryCode];
        
        [self.vehicleDetailView setupView];
    }
    
    if (self.search.selectedVehicle.vendor.rating) {
        if (self.supplierRatingView) {
            [self.supplierRatingView setVendor:self.search.selectedVehicle.vendor];
            [self.supplierRatingView setupView];
        }
    } else {
        [self.tabSelection removeSegmentAtIndex:1 animated:NO];
    }
    
    self.vendorRatingContainer.layer.cornerRadius = 5;
    self.vendorRatingContainer.layer.masksToBounds = YES;
    self.vehicleDetailsContainer.layer.cornerRadius = 5;
    self.vehicleDetailsContainer.layer.masksToBounds = YES;
    
    self.vehicleDetailsContainer.layer.borderWidth = 1;
    self.vehicleDetailsContainer.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.vendorRatingContainer.layer.borderWidth = 1;
    self.vendorRatingContainer.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *b = [NSBundle bundleWithPath:bundlePath];
    
    if (self.search.selectedVehicle.vendor.atAirport) {
        [self.pickupLocationView setTitle:@"At Airport"
                                     text:NSLocalizedString(@"This supplier is located in the airport.", @"This supplier is located in the airport.")
                                    image:[UIImage imageNamed:@"airport_gray" inBundle:b compatibleWithTraitCollection:nil]];
    } else {
        
        NSArray *addressComponents = [self.search.selectedVehicle.vendor.address componentsSeparatedByString:@","];
        
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
                             text:self.search.selectedVehicle.fuelPolicyDescription
                            image:[UIImage imageNamed:@"fuel" inBundle:b compatibleWithTraitCollection:nil]];
    
    [self.view layoutIfNeeded];
    
    if (self.search.selectedVehicle.totalPriceForThisVehicle) {
    
    NSArray *priceStrings = [[NSNumberUtils numberStringWithCurrencyCode:self.search.selectedVehicle.totalPriceForThisVehicle] componentsSeparatedByString:@"."];
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
    if ([[segue identifier] isEqualToString:@"VehicleEmbed"]) {
        _vehicleDetailView = (VehicleDetailsView *)[segue destinationViewController];
        [self.vehicleDetailView setData:self.search.selectedVehicle
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
    
    if ([[segue identifier] isEqualToString:@"RatingEmbed"]) {
        _supplierRatingView = (SupplierRatingsViewController *)[segue destinationViewController];
        [self.supplierRatingView setVendor:self.search.selectedVehicle.vendor];
    }
}

- (IBAction)tabChange:(id)sender {
    
    switch (self.tabSelection.selectedSegmentIndex) {
        case 0:
            [self detailsTapped];
            break;
        case 1:
            [self supplierTapped];
            break;
        default:
            break;
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
    [self pushToDestination];
    [self.activityView startAnimating];
    
    __weak typeof (self) weakSelf = self;
    self.dataValidationCompletion = ^(BOOL insuranceSuccess, NSString *errorMessage) {
        [weakSelf.activityView stopAnimating];
    };
    
    self.continueButton.enabled = NO;
}


@end
