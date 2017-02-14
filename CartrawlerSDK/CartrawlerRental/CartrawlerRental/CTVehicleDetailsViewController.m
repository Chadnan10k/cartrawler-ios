//
//  CTVehicleDetailsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleDetailsViewController.h"
#import "CTExpandingInfoView.h"
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import "CTSupplierRatingsViewController.h"
#import <CartrawlerSDK/CTSDKSettings.h>
#import <CartrawlerSDK/CTButton.h>
#import <CartrawlerSDK/CTSegmentedControl.h>
#import "CTTermsViewController.h"
#import <CartrawlerSDK/CTToolTip.h>
#import "CTVehicleInclusionsDataSource.h"
#import "CTVehicleFeaturesDataSource.h"
#import <CartrawlerSDK/CTImageCache.h>
#import <CartrawlerSDK/CartrawlerSDK+UIView.h>
#import <CartrawlerSDK/CTToolTipButton.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import "CTRentalLocalizationConstants.h"

@interface CTVehicleDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet CTLabel *vehicleNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;

@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;
@property (weak, nonatomic) IBOutlet CTLabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UITableView *featuresTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featuresTableViewHeightConstraint;

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
@property (weak, nonatomic) IBOutlet CTButton *termsAndConditionsButton;
@property (weak, nonatomic) IBOutlet CTLabel *orSimilarLabel;

@end

@implementation CTVehicleDetailsViewController

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
    
    self.totalPriceLabel.text = CTLocalizedString(CTRentalVehicleTotalPrice);
    self.includedForFreeLabel.text = CTLocalizedString(CTRentalIncludedTitle);
    [self.termsAndConditionsButton setTitle:CTLocalizedString(CTRentalIncludedTerms) forState:UIControlStateNormal];
    self.orSimilarLabel.text = CTLocalizedString(CTRentalVehicleOrSimilar);
    
    [self.featuresTableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
    
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
    
    [self.fuelPolicyButton setText:[CTLocalisedStrings fuelPolicy:self.search.selectedVehicle.vehicle.fuelPolicy] didTap:^{
        [weakSelf presentViewController:[CTToolTip fullScreenTooltip:CTLocalizedString(CTRentalVehicleFuelPolicy)
                                                          detailText:[[NSAttributedString alloc]
                                                                      initWithString:[CTLocalisedStrings
                                                                                      toolTipTextForFuelPolicy: weakSelf.search.selectedVehicle.vehicle.fuelPolicy]
                                                                      attributes: @{
                                                                                    NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                                    NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:21]
                                                                                    }]]
                               animated:YES
                             completion:nil];
    }];
    
    NSString *pickupText = [CTLocalisedStrings pickupType:self.search.selectedVehicle] ?: CTLocalizedString(CTRentalVehicleSupplierAddress);
    NSMutableAttributedString *toolTipText = [[NSMutableAttributedString alloc] initWithString:@""];
    
    if ([CTLocalisedStrings pickupType:self.search.selectedVehicle]) {
        [toolTipText appendAttributedString:[[NSAttributedString alloc]
                                             initWithString:[CTLocalisedStrings
                                                             toolTipTextForPickupType: weakSelf.search.selectedVehicle]
                                             attributes: @{
                                                           NSForegroundColorAttributeName : [UIColor whiteColor],
                                                           NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:21]
                                                           }]];
    } else {
        [toolTipText appendAttributedString: [[NSAttributedString alloc]
                                              initWithString:[NSString stringWithFormat:@"%@\n\n%@", CTLocalizedString(CTRentalVehicleSupplierAddressDetail),
                                                              self.search.selectedVehicle.vendor.pickupLocation.address]
                                              attributes: @{
                                                            NSForegroundColorAttributeName : [UIColor whiteColor],
                                                            NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:21]
                                                            }]];
    }
    
    [self.pickupLocationButton setText:pickupText didTap:^{
        [weakSelf presentViewController:[CTToolTip fullScreenTooltip:CTLocalizedString(CTRentalVehiclePickupLocation)
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
                                        CTLocalizedString(CTRentalVehiclePassengers)],
                                        @"image" : @"people"}];
    
    [featureData addObject:@{@"text" : [NSString stringWithFormat:@"%@ %@",
                                        self.search.selectedVehicle.vehicle.baggageQty.stringValue,
                                        CTLocalizedString(CTRentalVehicleBags)],
                                        @"image" : @"baggage"}];
    
    [featureData addObject:@{@"text" : [NSString stringWithFormat:@"%@ %@",
                                        self.search.selectedVehicle.vehicle.doorCount.stringValue,
                                        CTLocalizedString(CTRentalVehicleDoors)],
                                        @"image" : @"doors"}];
    
    [featureData addObject:@{@"text" : [NSString stringWithFormat:@"%@",
                                        self.search.selectedVehicle.vehicle.transmissionType],
                                        @"image" : @"gears"}];
    
    if (self.search.selectedVehicle.vehicle.isAirConditioned) {
        [featureData addObject:@{@"text" : [NSString stringWithFormat:@"%@",
                                            CTLocalizedString(CTRentalVehicleAirConditioning)],
                                            @"image" : @"aircon"}];
    }
    
    [self.vehicleFeaturesDataSource setData:featureData];
    [self.featuresTableView reloadData];
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
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"CTTermsViewControllerNav"];
    CTTermsViewController *vc = (CTTermsViewController *)nav.topViewController;
    [vc setData:self.search cartrawlerAPI:self.cartrawlerAPI];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:nav animated:YES completion:nil];
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UITableView *)featuresTableView change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.featuresTableViewHeightConstraint.constant = featuresTableView.contentSize.height;
    [featuresTableView layoutIfNeeded];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.featuresTableView removeObserver:self forKeyPath:@"contentSize"];
}

@end
