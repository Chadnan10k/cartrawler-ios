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

#define kCellsPerRow 4

@interface VehicleDetailsView() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet CTLabel *vehicleNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (weak, nonatomic) IBOutlet CTLabel *passengersLabel;
@property (weak, nonatomic) IBOutlet CTLabel *doorsLabel;
@property (weak, nonatomic) IBOutlet CTLabel *bagsLabel;
@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;
@property (weak, nonatomic) IBOutlet CTLabel *transmissionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vendorImageView;
@property (weak, nonatomic) IBOutlet UITableView *includedTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *includedHeight;
@property (weak, nonatomic) IBOutlet CTLabel *includedForFreeLabel;

@property (strong, nonatomic) CarRentalSearch *search;
@property (strong, nonatomic) CartrawlerAPI *api;
@property (strong, nonatomic) NSDate *pickupDate;
@property (strong, nonatomic) NSDate *returnDate;
@property (strong, nonatomic) NSString *pickupCode;
@property (strong, nonatomic) NSString *returnCode;
@property (strong, nonatomic) NSString *homeCountry;

@end

@implementation VehicleDetailsView

+ (void)forceLinkerLoad_ {}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    self.passengersLabel.text = [NSString stringWithFormat:@"%@ %@", self.search.selectedVehicle.vehicle.passengerQty.stringValue, NSLocalizedString(@"passengers", @"passengers")];
    self.doorsLabel.text = [NSString stringWithFormat:@"%@ %@", self.search.selectedVehicle.vehicle.doorCount.stringValue, NSLocalizedString(@"doors", @"doors")];
    
    if (self.search.selectedVehicle.vehicle.baggageQty.integerValue > 1) {
        self.bagsLabel.text = [NSString stringWithFormat:@"%@ %@", self.search.selectedVehicle.vehicle.baggageQty.stringValue, NSLocalizedString(@"bags", @"bags")];
    } else {
        self.bagsLabel.text = [NSString stringWithFormat:@"%@ %@", self.search.selectedVehicle.vehicle.baggageQty.stringValue, NSLocalizedString(@"bag", @"bags")];
    }
    
    self.transmissionLabel.text = self.search.selectedVehicle.vehicle.transmissionType;
    
    self.view.translatesAutoresizingMaskIntoConstraints = false;
    
    if (self.search.selectedVehicle.vehicle.pricedCoverages.count > 0) {
        [self.includedTableView reloadData];
        [self.includedTableView beginUpdates];
        [self.includedTableView endUpdates];

        self.includedForFreeLabel.hidden = NO;
    } else {
        [self.includedTableView reloadData];
        self.heightChanged(-60);
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
        self.heightChanged(self.includedTableView.contentSize.height);
    }
    
    return cell;
}

@end
