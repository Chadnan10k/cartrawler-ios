//
//  VehicleDetailsView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "VehicleDetailsView.h"
#import "CTImageCache.h"
#import "IncludedCollectionViewCell.h"
#import "TermsViewController.h"
#import "CTAppearance.h"
#import "CTLabel.h"
#import "CarRentalSearch.h"
#import "NSNumberUtils.h"
#import "CTInclusionTableViewCell.h"
#import "VehicleFeaturesDataSource.h"

#define kCellsPerRow 4

@interface VehicleDetailsView() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet CTLabel *vehicleNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;

@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vendorImageView;
@property (weak, nonatomic) IBOutlet UITableView *includedTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *includedHeight;
@property (weak, nonatomic) IBOutlet CTLabel *includedForFreeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featuresCollectionViewHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *featuresCollectionView;

@property (strong, nonatomic) CarRentalSearch *search;
@property (strong, nonatomic) CartrawlerAPI *api;
@property (strong, nonatomic) NSDate *pickupDate;
@property (strong, nonatomic) NSDate *returnDate;
@property (strong, nonatomic) NSString *pickupCode;
@property (strong, nonatomic) NSString *returnCode;
@property (strong, nonatomic) NSString *homeCountry;

@property (strong, nonatomic) VehicleFeaturesDataSource *vehicleFeaturesDataSource;

@end

@implementation VehicleDetailsView

+ (void)forceLinkerLoad_ {}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _vehicleFeaturesDataSource = [[VehicleFeaturesDataSource alloc] init];
    [self setupView];
    
    self.includedTableView.dataSource = self;
    self.includedTableView.estimatedRowHeight = 40;
    self.includedTableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setupView
{
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
    if (self.heightChanged) {
        self.heightChanged(self.featuresCollectionView.contentSize.height);
    }
    
    self.view.translatesAutoresizingMaskIntoConstraints = false;
    
    if (self.search.selectedVehicle.vehicle.pricedCoverages.count > 0) {
        [self.includedTableView reloadData];
        [self.includedTableView beginUpdates];
        [self.includedTableView endUpdates];

        self.includedForFreeLabel.hidden = NO;
    } else {
        [self.includedTableView reloadData];
        self.heightChanged(self.featuresCollectionView.contentSize.height-126);
        self.includedHeight.constant = 0;
        self.includedForFreeLabel.hidden = YES;
    }
    
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

- (void)setData:(CarRentalSearch *)search
            api:(CartrawlerAPI *)api
     pickupDate:(NSDate *)pickupDate
     returnDate:(NSDate *)returnDate
     pickupCode:(NSString *)pickupCode
     returnCode:(NSString *)returnCode
    homeCountry:(NSString *)homeCountry
{
    _pickupDate = pickupDate;
    _returnDate = returnDate;
    _pickupCode = pickupCode;
    _returnCode = returnCode;
    _homeCountry = homeCountry;
    _search = search;
    _api = api;
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.search.selectedVehicle.vehicle.pricedCoverages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTInclusionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setLabelText:self.search.selectedVehicle.vehicle.pricedCoverages[indexPath.row].chargeDescription];
    self.includedHeight.constant = self.includedTableView.contentSize.height;
    if (self.heightChanged) {
        self.heightChanged(self.includedTableView.contentSize.height + self.featuresCollectionView.contentSize.height-76);
    }
    
    return cell;
}

@end
