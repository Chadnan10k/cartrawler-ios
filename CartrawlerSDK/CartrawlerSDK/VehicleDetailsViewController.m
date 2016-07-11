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

@interface VehicleDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIView *vehicleDetailsContainer;
@property (weak, nonatomic) IBOutlet UIView *vendorRatingContainer;
@property (weak, nonatomic) IBOutlet ExpandingInfoView *pickupLocationView;
@property (weak, nonatomic) IBOutlet ExpandingInfoView *fuelPolicyView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vehicleDetailsHeightConstraint;
@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;

@property (weak, nonatomic) IBOutlet TabButton *carDetailsTab;
@property (weak, nonatomic) IBOutlet TabButton *supplierTab;
@property (weak, nonatomic) VehicleDetailsView *vehicleDetailView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation VehicleDetailsViewController

+ (void)forceLinkerLoad_ {}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.scrollView setContentOffset:
     CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
    
    if (self.vehicleDetailView) {
        [self.vehicleDetailView setData:self.selectedVehicle
                                    api:self.cartrawlerAPI
                             pickupDate:self.pickupDate
                             returnDate:self.dropoffDate
                             pickupCode:self.pickupLocation.code
                             returnCode:self.dropoffLocation.code
                            homeCountry:@"IE"];
        
        [self.vehicleDetailView setupView];
    }
    
    self.vendorRatingContainer.layer.cornerRadius = 5;
    self.vendorRatingContainer.layer.masksToBounds = YES;
    self.vehicleDetailsContainer.layer.cornerRadius = 5;
    self.vehicleDetailsContainer.layer.masksToBounds = YES;
    
    self.vehicleDetailsContainer.layer.borderWidth = 1;
    self.vehicleDetailsContainer.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.vendorRatingContainer.layer.borderWidth = 1;
    self.vendorRatingContainer.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.pickupLocationView setTitle:@"Vehicle is located in airport." andImage:nil];
    [self.fuelPolicyView setTitle:self.selectedVehicle.fuelPolicyDescription andImage:nil];
    
    [self.view layoutIfNeeded];
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setMinimumFractionDigits:2];
    [f setCurrencyCode:self.selectedVehicle.currencyCode];
    [f setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSArray *priceStrings = [[f stringFromNumber:self.selectedVehicle.totalPriceForThisVehicle] componentsSeparatedByString:@"."];
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
        VehicleDetailsView *vc = (VehicleDetailsView *)[segue destinationViewController];
        _vehicleDetailView = vc;
        
        [vc setData:self.selectedVehicle
                api:self.cartrawlerAPI
         pickupDate:self.pickupDate
         returnDate:self.dropoffDate
         pickupCode:self.pickupLocation.code
         returnCode:self.dropoffLocation.code
        homeCountry:@"IE"];
        
        vc.heightChanged = ^(CGFloat height) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.vehicleDetailsHeightConstraint.constant = height + 265;
            });
        };
    }
}

- (IBAction)detailsTapped:(id)sender {
    [self.carDetailsTab focus:YES];
    [self.supplierTab focus:NO];
    self.vehicleDetailsContainer.alpha = 1;
    self.vendorRatingContainer.alpha = 0;
}

- (IBAction)supplierTapped:(id)sender {
    [self.carDetailsTab focus:NO];
    [self.supplierTab focus:YES];
    self.vehicleDetailsContainer.alpha = 0;
    self.vendorRatingContainer.alpha = 1;
}

- (IBAction)continueTapped:(id)sender {
    [self pushToStepFour];
}


@end
