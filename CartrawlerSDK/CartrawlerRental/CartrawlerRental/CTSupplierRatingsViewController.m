//
//  CTSupplierRatingsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSupplierRatingsViewController.h"
#import <CartrawlerSDK/CTImageCache.h>
#import "CTSupplierRatingTableViewCell.h"
#import <CartrawlerSDK/CTAppearance.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTSupplierRatingsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *ratingScore;
@property (weak, nonatomic) IBOutlet UILabel *ratingDescription;
@property (weak, nonatomic) IBOutlet UIImageView *vendorImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray <NSDictionary *> *ratings;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpacing;

@end

@implementation CTSupplierRatingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [[CTImageCache sharedInstance] cachedImage: self.search.selectedVehicle.vendor.logoURL completion:^(UIImage *image) {
        self.vendorImageView.image = image;
    }];
    
    NSAttributedString *scoreAttr = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"%.1f", self.search.selectedVehicle.vendor.rating.overallScore.floatValue * 2]
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].boldFontName size:30.0],
                                                                                      NSForegroundColorAttributeName: [CTAppearance instance].supplierDetailPrimaryColor}];
    
    NSAttributedString *scoreBaseAttr = [[NSAttributedString alloc] initWithString:@" / 10"
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].fontName size:20.0],
                                                                                      NSForegroundColorAttributeName: [CTAppearance instance].subheaderTitleColor}];
    
    NSMutableAttributedString *scoreStr = [[NSMutableAttributedString alloc] init];
    [scoreStr appendAttributedString:scoreAttr];
    [scoreStr appendAttributedString:scoreBaseAttr];
    self.ratingScore.attributedText = scoreStr;
    
    NSString *ratingType = @"";
    
    if (self.search.selectedVehicle.vendor.rating.overallScore.floatValue * 2 < 5) {
        ratingType = CTLocalizedString(CTRentalSupplierBelowAverage);
    } else if (self.search.selectedVehicle.vendor.rating.overallScore.floatValue * 2 < 7)  {
        ratingType = CTLocalizedString(CTRentalSupplierGood);
    } else {
        ratingType = CTLocalizedString(CTRentalSupplierExcellent);
    }
    
    NSAttributedString *ratingTypeAttr = [[NSAttributedString alloc] initWithString:ratingType
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].boldFontName size:17.0], NSForegroundColorAttributeName: [CTAppearance instance].supplierDetailSecondaryColor}];
    NSString *reviewString = [NSString stringWithFormat:@"%ld %@:\n", (long)self.search.selectedVehicle.vendor.rating.totalReviews.integerValue, CTLocalizedString(CTRentalSupplierRatingDetail)];
    
    NSAttributedString *ratingBaseAttr = [[NSAttributedString alloc] initWithString:reviewString
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].fontName size:17.0], NSForegroundColorAttributeName: [CTAppearance instance].supplierDetailPrimaryColor}];
    
    NSMutableAttributedString *ratingStr = [[NSMutableAttributedString alloc] init];
    [ratingStr appendAttributedString:ratingBaseAttr];
    [ratingStr appendAttributedString:ratingTypeAttr];
    self.ratingDescription.attributedText = ratingStr;
    
    _ratings = @[
                 @{@"type" : CTLocalizedString(CTRentalSupplierPrice), @"value" : [NSString stringWithFormat:@"%.1f",
                                                           self.search.selectedVehicle.vendor.rating.priceScore.doubleValue/10]},
                 @{@"type" : CTLocalizedString(CTRentalSupplierCar), @"value" : [NSString stringWithFormat:@"%.1f",
                                                         self.search.selectedVehicle.vendor.rating.carReview.doubleValue/10]},
                 @{@"type" : CTLocalizedString(CTRentalSupplierDesk), @"value" : [NSString stringWithFormat:@"%.1f", self.search.selectedVehicle.vendor.rating.deskReview.doubleValue/10]},
                 @{@"type" : CTLocalizedString(CTRentalSupplierPickup), @"value" : [NSString stringWithFormat:@"%.1f", self.search.selectedVehicle.vendor.rating.pickupScore.doubleValue/10]},
                 @{@"type" : CTLocalizedString(CTRentalSupplierDropoff), @"value" : [NSString stringWithFormat:@"%.1f", self.search.selectedVehicle.vendor.rating.dropoffReview.doubleValue/10]}];
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ratings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTSupplierRatingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setType:[self.ratings[indexPath.row] objectForKey:@"type"] ratingText:[self.ratings[indexPath.row] objectForKey:@"value"]];
    return cell;
}

@end
