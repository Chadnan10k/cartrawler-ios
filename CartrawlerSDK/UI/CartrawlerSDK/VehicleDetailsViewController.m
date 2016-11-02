//
//  VehicleDetailsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "VehicleDetailsViewController.h"
#import "ExpandingInfoView.h"
#import "CTAppearance.h"
#import "CTLabel.h"
#import "TabButton.h"
#import "NSNumberUtils.h"
#import "SupplierRatingsViewController.h"
#import "CTSDKSettings.h"
#import "CTButton.h"
#import "CTSegmentedControl.h"
#import "TermsViewController.h"
#import "CTToolTip.h"
#import "VehicleFeaturesDataSource.h"
#import "CTInclusionsDataSource.h"
#import "CTImageCache.h"

@interface VehicleDetailsViewController ()

@property (weak, nonatomic) IBOutlet ExpandingInfoView *pickupLocationView;
@property (weak, nonatomic) IBOutlet ExpandingInfoView *fuelPolicyView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet CTLabel *vehicleNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;

@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vendorImageView;
@property (weak, nonatomic) IBOutlet UITableView *includedTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *includedHeight;
@property (weak, nonatomic) IBOutlet CTLabel *includedForFreeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featuresCollectionViewHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *featuresCollectionView;


@property (strong, nonatomic) VehicleFeaturesDataSource *vehicleFeaturesDataSource;
@property (strong, nonatomic) CTInclusionsDataSource *inclusionDataSource;

@end

@implementation VehicleDetailsViewController

+ (void)forceLinkerLoad_ {}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _inclusionDataSource = [[CTInclusionsDataSource alloc] init];
    _vehicleFeaturesDataSource = [[VehicleFeaturesDataSource alloc] init];
    
    self.includedTableView.dataSource = self.inclusionDataSource;
    self.includedTableView.delegate = self.inclusionDataSource;
        
    self.includedTableView.estimatedRowHeight = 40;
    self.includedTableView.rowHeight = UITableViewAutomaticDimension;
    self.includedTableView.layer.cornerRadius = 5;
    
    __weak typeof(self) weakSelf = self;
    
    self.inclusionDataSource.cellTapped = ^(UIView *cell, NSString *text) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //[[CTToolTip instance] presentForView:cell text:text superview:weakSelf.scrollView];
            [[CTToolTip instance] presentPartialOverlayInView:weakSelf.view text: text];
        });
    };
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.scrollView setContentOffset:
    CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
    
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

    [[CTImageCache sharedInstance] cachedImage: self.search.selectedVehicle.vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    [[CTImageCache sharedInstance] cachedImage: self.search.selectedVehicle.vendor.logoURL completion:^(UIImage *image) {
        self.vendorImageView.image = image;
    }];
    
    self.vehicleNameLabel.text = self.search.selectedVehicle.vehicle.makeModelName;

    //self.featuresCollectionView.de
    NSMutableArray *featureData = [[NSMutableArray alloc] init];
    [featureData addObject:@{ @"text" : [NSString stringWithFormat:@"%@ %@", self.search.selectedVehicle.vehicle.passengerQty.stringValue, NSLocalizedString(@"passengers", @"passengers")], @"image" : @"people" }];
    [featureData addObject:@{ @"text" : [NSString stringWithFormat:@"%@ %@", self.search.selectedVehicle.vehicle.doorCount.stringValue, NSLocalizedString(@"doors", @"doors")], @"image" : @"doors" }];
    [featureData addObject:@{ @"text" : [NSString stringWithFormat:@"%@ %@", self.search.selectedVehicle.vehicle.baggageQty.stringValue, NSLocalizedString(@"bags", @"bags")], @"image" : @"baggage" }];
    [featureData addObject:@{ @"text" : self.search.selectedVehicle.vehicle.transmissionType, @"image" : @"gears" }];
    
    if (self.search.selectedVehicle.vehicle.isAirConditioned) {
        [featureData addObject:@{ @"text" : NSLocalizedString(@"Air conditioning", @"Air Conditioning"), @"image" : @"winter_package" }];
    }
    
    [self.vehicleFeaturesDataSource setData:featureData];
    self.featuresCollectionView.dataSource = self.vehicleFeaturesDataSource;
    self.featuresCollectionView.delegate = self.vehicleFeaturesDataSource;
    [self.featuresCollectionView reloadData];
    [self.featuresCollectionView layoutIfNeeded];
    [self.view layoutIfNeeded];
    self.featuresCollectionViewHeight.constant = self.featuresCollectionView.contentSize.height;

    if (self.search.selectedVehicle.vehicle.pricedCoverages.count > 0) {
        [self.includedTableView reloadData];
        [self.includedTableView beginUpdates];
        [self.includedTableView endUpdates];
        
        self.includedForFreeLabel.hidden = NO;
    } else {
        [self.includedTableView reloadData];
        self.includedHeight.constant = 0;
        self.includedForFreeLabel.hidden = YES;
    }
    
    [self.inclusionDataSource setData:self.search.selectedVehicle.vehicle.pricedCoverages extras: self.search.selectedVehicle.vehicle.extraEquipment];
    self.includedTableView.dataSource = self.inclusionDataSource;
    self.includedTableView.delegate = self.inclusionDataSource;
    
    [self.includedTableView reloadData];
    [self.includedTableView layoutIfNeeded];
    [self.view layoutIfNeeded];
    self.includedHeight.constant = self.includedTableView.contentSize.height;

    if (self.search.selectedVehicle.vehicle.totalPriceForThisVehicle) {
        
        NSArray *priceStrings = [[NSNumberUtils numberStringWithCurrencyCode:self.search.selectedVehicle.vehicle.totalPriceForThisVehicle] componentsSeparatedByString:@"."];
        NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *dollars = [[NSAttributedString alloc] initWithString:priceStrings.firstObject
                                                                      attributes:@{NSFontAttributeName:
                                                                                       [UIFont fontWithName:[CTAppearance instance].boldFontName size:23]}];
        
        NSAttributedString *dot = [[NSAttributedString alloc] initWithString:@"."
                                                                  attributes:@{NSFontAttributeName:
                                                                                   [UIFont fontWithName:[CTAppearance instance].boldFontName size:18]}];
        
        NSAttributedString *cents = [[NSAttributedString alloc] initWithString:priceStrings.lastObject
                                                                    attributes:@{NSFontAttributeName:
                                                                                     [UIFont fontWithName:[CTAppearance instance].boldFontName size:18]}];
        
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

- (IBAction)termsAndCondTapped:(id)sender
{
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsViewControllerNav"];
    TermsViewController *vc = (TermsViewController *)nav.topViewController;
    [vc setData:self.search cartrawlerAPI:self.cartrawlerAPI];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:nav animated:YES completion:nil];
    });
}

@end
