//
//  SupplierRatingsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "SupplierRatingsViewController.h"
#import <CartrawlerSDK/CTImageCache.h>
#import "SupplierRatingTableViewCell.h"
#import <CartrawlerSDK/CTAppearance.h>

@interface SupplierRatingsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *ratingScore;
@property (weak, nonatomic) IBOutlet UILabel *ratingDescription;
@property (weak, nonatomic) IBOutlet UIImageView *vendorImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray <NSDictionary *> *ratings;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpacing;

@end

@implementation SupplierRatingsViewController




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
        ratingType = @"Below average";
    } else if (self.search.selectedVehicle.vendor.rating.overallScore.floatValue * 2 < 7)  {
        ratingType = @"Good";
    } else {
        ratingType = @"Excellent";
    }
    
    NSAttributedString *ratingTypeAttr = [[NSAttributedString alloc] initWithString:ratingType
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].boldFontName size:17.0], NSForegroundColorAttributeName: [CTAppearance instance].supplierDetailSecondaryColor}];
    NSString *reviewString = [NSString stringWithFormat:@"%ld customers rate this car rental company as:\n", (long)self.search.selectedVehicle.vendor.rating.totalReviews.integerValue];
    
    NSAttributedString *ratingBaseAttr = [[NSAttributedString alloc] initWithString:reviewString
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].fontName size:17.0], NSForegroundColorAttributeName: [CTAppearance instance].supplierDetailPrimaryColor}];
    
    NSMutableAttributedString *ratingStr = [[NSMutableAttributedString alloc] init];
    [ratingStr appendAttributedString:ratingBaseAttr];
    [ratingStr appendAttributedString:ratingTypeAttr];
    self.ratingDescription.attributedText = ratingStr;
    
    _ratings = @[
                 @{@"type" : @"Overall value for money", @"value" : [NSString stringWithFormat:@"%.1f",
                                                           self.search.selectedVehicle.vendor.rating.priceScore.doubleValue/10]},
                 @{@"type" : @"Cleanliness of car", @"value" : [NSString stringWithFormat:@"%.1f",
                                                         self.search.selectedVehicle.vendor.rating.carReview.doubleValue/10]},
                 @{@"type" : @"Service at desk", @"value" : [NSString stringWithFormat:@"%.1f", self.search.selectedVehicle.vendor.rating.deskReview.doubleValue/10]},
                 @{@"type" : @"Pick-up process", @"value" : [NSString stringWithFormat:@"%.1f", self.search.selectedVehicle.vendor.rating.pickupScore.doubleValue/10]},
                 @{@"type" : @"Drop-off process", @"value" : [NSString stringWithFormat:@"%.1f", self.search.selectedVehicle.vendor.rating.dropoffReview.doubleValue/10]}];
    
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
    SupplierRatingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setType:[self.ratings[indexPath.row] objectForKey:@"type"] ratingText:[self.ratings[indexPath.row] objectForKey:@"value"]];
    return cell;
}

@end
