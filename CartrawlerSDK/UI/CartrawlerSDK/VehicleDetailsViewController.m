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
#import "CartrawlerSDK+NSNumber.h"
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

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet CTLabel *vehicleNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;

@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITableView *includedTableView;

@property (weak, nonatomic) IBOutlet CTLabel *includedForFreeLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *featuresCollectionView;


@property (strong, nonatomic) VehicleFeaturesDataSource *vehicleFeaturesDataSource;
@property (strong, nonatomic) CTInclusionsDataSource *inclusionDataSource;
@property (weak, nonatomic) IBOutlet UIView *inclusionsContainerView;

@end

@implementation VehicleDetailsViewController



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
    self.inclusionsContainerView.backgroundColor = [CTAppearance instance].iconTint;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.scrollView setContentOffset:
    CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
    
    NSBundle *b = [NSBundle bundleForClass:[self class]];
    [self.view layoutIfNeeded];

    [[CTImageCache sharedInstance] cachedImage: self.search.selectedVehicle.vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];

    self.vehicleNameLabel.text = self.search.selectedVehicle.vehicle.makeModelName;
    
    NSMutableArray *featureData = [[NSMutableArray alloc] init];
    
    for (CTPricedCoverage *pc in self.search.selectedVehicle.vehicle.pricedCoverages) {
        [featureData addObject:@{ @"text" : [NSString stringWithFormat:@"%@ %@", pc.chargeDescription,
                                             NSLocalizedString(@"passengers", @"passengers")], @"image" : @"white_checkmark" }];
    }
    
    [self.vehicleFeaturesDataSource setData:featureData];
    self.featuresCollectionView.dataSource = self.vehicleFeaturesDataSource;
    self.featuresCollectionView.delegate = self.vehicleFeaturesDataSource;
    [self.featuresCollectionView reloadData];
    [self.featuresCollectionView layoutIfNeeded];
    [self.view layoutIfNeeded];
    
    for (NSLayoutConstraint *c in self.featuresCollectionView.constraints) {
        if (c.firstAttribute == NSLayoutAttributeHeight) {
            c.constant = self.featuresCollectionView.contentSize.height;
        }
    }
    
    if (self.search.selectedVehicle.vehicle.pricedCoverages.count > 0) {
        [self.includedTableView reloadData];
        [self.includedTableView beginUpdates];
        [self.includedTableView endUpdates];
        
        self.includedForFreeLabel.hidden = NO;
    } else {
        [self.includedTableView reloadData];
        for (NSLayoutConstraint *c in self.includedTableView.constraints) {
            if (c.firstAttribute == NSLayoutAttributeHeight) {
                c.constant = 0;
            }
        }
        self.includedForFreeLabel.hidden = YES;
    }
    
    [self.inclusionDataSource setData:self.search.selectedVehicle.vehicle.pricedCoverages extras: self.search.selectedVehicle.vehicle.extraEquipment];
    self.includedTableView.dataSource = self.inclusionDataSource;
    self.includedTableView.delegate = self.inclusionDataSource;
    
    [self.includedTableView reloadData];
    [self.includedTableView layoutIfNeeded];
    [self.view layoutIfNeeded];
    for (NSLayoutConstraint *c in self.includedTableView.constraints) {
        if (c.firstAttribute == NSLayoutAttributeHeight) {
            c.constant = self.includedTableView.contentSize.height;
        }
    }

    if (self.search.selectedVehicle.vehicle.totalPriceForThisVehicle) {
        self.priceLabel.text = [self.search.selectedVehicle.vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode];
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
