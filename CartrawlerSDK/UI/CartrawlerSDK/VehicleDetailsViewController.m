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
#import "CTVehicleInclusionsDataSource.h"
#import "CTVehicleFeaturesDataSource.h"
#import "CTImageCache.h"
#import "CartrawlerSDK+UIView.h"
#import "CTToolTipButton.h"
#import "LocalisedStrings.h"

@interface VehicleDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet CTLabel *vehicleNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;

@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITableView *featuresTableView;

@property (weak, nonatomic) IBOutlet CTLabel *includedForFreeLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *inclusionsCollectionView;


@property (strong, nonatomic) CTVehicleFeaturesDataSource *vehicleFeaturesDataSource;
@property (strong, nonatomic) CTVehicleInclusionsDataSource *inclusionDataSource;
@property (weak, nonatomic) IBOutlet UIView *inclusionsContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inclusionsCollectionViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inclusionsVerticalSpace;
@property (weak, nonatomic) IBOutlet CTToolTipButton *fuelPolicyButton;
@property (weak, nonatomic) IBOutlet CTToolTipButton *pickupLocationButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpacing;

@end

@implementation VehicleDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _inclusionDataSource = [[CTVehicleInclusionsDataSource alloc] init];
    _vehicleFeaturesDataSource = [[CTVehicleFeaturesDataSource alloc] init];
    self.inclusionsContainerView.backgroundColor = [CTAppearance instance].iconTint;
    
    self.featuresTableView.dataSource = self.vehicleFeaturesDataSource;
    self.inclusionsCollectionView.dataSource = self.inclusionDataSource;
    self.inclusionsCollectionView.delegate = self.inclusionDataSource;

    self.featuresTableView.estimatedRowHeight = 30;
    self.featuresTableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.search.selectedVehicle.vendor.rating) {
        self.topSpacing.constant = 80;
    } else {
        self.topSpacing.constant = 40;
    }
    
    [self.scrollView setContentOffset:
    CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
    
    [self.view layoutIfNeeded];

    [[CTImageCache sharedInstance] cachedImage: self.search.selectedVehicle.vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];

    self.vehicleNameLabel.text = self.search.selectedVehicle.vehicle.makeModelName;
    
    if (self.search.selectedVehicle.vehicle.totalPriceForThisVehicle) {
        self.priceLabel.text = [self.search.selectedVehicle.vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode];
    }
    
    __weak typeof(self) weakSelf = self;
    
    [self.fuelPolicyButton setText:[LocalisedStrings fuelPolicy:self.search.selectedVehicle.vehicle.fuelPolicy] didTap:^{
        [weakSelf presentViewController:[CTToolTip fullScreenTooltip:NSLocalizedString(@"Fuel policy", @"Fuel policy tooltip title")
                                                          detailText:[[NSAttributedString alloc]
                                                                      initWithString:[LocalisedStrings
                                                                                      toolTipTextForFuelPolicy: weakSelf.search.selectedVehicle.vehicle.fuelPolicy]
                                                                      attributes: @{
                                                                                    NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                                    NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:21]
                                                                                    }]]
                               animated:YES
                             completion:nil];
    }];
    
    NSString *pickupText = [LocalisedStrings pickupType:self.search.selectedVehicle] ?: @"Supplier address";
    NSMutableAttributedString *toolTipText = [[NSMutableAttributedString alloc] initWithString:@""];
    
    if ([LocalisedStrings pickupType:self.search.selectedVehicle]) {
        [toolTipText appendAttributedString:[[NSAttributedString alloc]
                                             initWithString:[LocalisedStrings
                                                             toolTipTextForPickupType: weakSelf.search.selectedVehicle]
                                             attributes: @{
                                                           NSForegroundColorAttributeName : [UIColor whiteColor],
                                                           NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:21]
                                                           }]];
    } else {
        [toolTipText appendAttributedString: [[NSAttributedString alloc]
                                              initWithString:[NSString stringWithFormat:@"The suppliers address is:\n\n%@",
                                                              self.search.selectedVehicle.vendor.pickupLocation.address]
                                              attributes: @{
                                                            NSForegroundColorAttributeName : [UIColor whiteColor],
                                                            NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:21]
                                                            }]];
    }
    
    [self.pickupLocationButton setText:pickupText didTap:^{
        [weakSelf presentViewController:[CTToolTip fullScreenTooltip:NSLocalizedString(@"Pickup location", @"Pickup location tooltip title")
                                                          detailText:toolTipText]
                               animated:YES
                             completion:nil];
    }];
    
    [self setupFeatureTableView];
    [self setupInclusionsCollectionView];
}

- (void)setupFeatureTableView
{
    NSMutableArray *featureData = [[NSMutableArray alloc] init];
    
    [featureData addObject:@{@"text" : [NSString stringWithFormat:@"%@ %@",
                                        self.search.selectedVehicle.vehicle.passengerQty.stringValue,
                                        NSLocalizedString(@"passengers", @"passengers")],
                                        @"image" : @"people"}];
    
    [featureData addObject:@{@"text" : [NSString stringWithFormat:@"%@ %@",
                                        self.search.selectedVehicle.vehicle.baggageQty.stringValue,
                                        NSLocalizedString(@"bags", @"bags")],
                                        @"image" : @"baggage"}];
    
    [featureData addObject:@{@"text" : [NSString stringWithFormat:@"%@ %@",
                                        self.search.selectedVehicle.vehicle.doorCount.stringValue,
                                        NSLocalizedString(@"doors", @"doors")],
                                        @"image" : @"doors"}];
    
    [featureData addObject:@{@"text" : [NSString stringWithFormat:@"%@",
                                        self.search.selectedVehicle.vehicle.transmissionType],
                                        @"image" : @"gears"}];
    
    if (self.search.selectedVehicle.vehicle.isAirConditioned) {
        [featureData addObject:@{@"text" : [NSString stringWithFormat:@"%@",
                                            NSLocalizedString(@"Air Conditioning", @"Air Conditioning")],
                                            @"image" : @"aircon"}];
    }
    
    [self.vehicleFeaturesDataSource setData:featureData];
    
    [self.featuresTableView reloadData];
    [self.featuresTableView layoutIfNeeded];

    if (self.featuresTableView.heightConstraint) {
        self.featuresTableView.heightConstraint.constant = self.featuresTableView.contentSize.height;
    }
}

- (void)setupInclusionsCollectionView
{
    BOOL hasFreeExtra = NO;
    for (CTExtraEquipment *ex in self.search.selectedVehicle.vehicle.extraEquipment) {
        if (ex.isIncludedInRate) {
            hasFreeExtra = YES;
            break;
        }
    }
    
    if (self.search.selectedVehicle.vehicle.pricedCoverages.count == 0 && !hasFreeExtra)
    {
        self.inclusionsVerticalSpace.constant = 8;
        self.inclusionsContainerView.hidden = YES;
    } else {
        self.inclusionsContainerView.hidden = NO;
        [self.inclusionDataSource setData:self.search.selectedVehicle.vehicle.pricedCoverages
                                   extras:self.search.selectedVehicle.vehicle.extraEquipment];

        [self.inclusionsCollectionView.collectionViewLayout invalidateLayout];
        [self.inclusionsCollectionView reloadData];
        [self.inclusionsCollectionView layoutIfNeeded];
        self.inclusionsCollectionViewHeight.constant = self.inclusionsCollectionView.contentSize.height;
        self.inclusionsVerticalSpace.constant = self.inclusionsCollectionView.contentSize.height+70;
    }
}

- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
