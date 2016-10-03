//
//  SupplierRatingsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "SupplierRatingsViewController.h"
#import "CTImageCache.h"
#import "SupplierRatingCollectionViewCell.h"
#import "CTAppearance.h"

@interface SupplierRatingsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *ratingScore;
@property (weak, nonatomic) IBOutlet UILabel *ratingDescription;
@property (weak, nonatomic) IBOutlet UILabel *reviewsAmount;
@property (weak, nonatomic) IBOutlet UIImageView *vendorImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray <NSDictionary *> *ratings;

@end

@implementation SupplierRatingsViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [[CTImageCache sharedInstance] cachedImage: self.search.selectedVehicle.vendor.logoURL completion:^(UIImage *image) {
        self.vendorImageView.image = image;
    }];
    
    NSAttributedString *scoreAttr = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"%.1f", self.search.selectedVehicle.vendor.rating.overallScore.floatValue * 2]
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].boldFontName size:30.0], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    NSAttributedString *scoreBaseAttr = [[NSAttributedString alloc] initWithString:@" / 10"
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].fontName size:15.0], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
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
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].boldFontName size:20.0], NSForegroundColorAttributeName: [UIColor yellowColor]}];
    
    NSAttributedString *ratingBaseAttr = [[NSAttributedString alloc] initWithString:@"Customers rate this company as "
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].fontName size:20.0], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    NSMutableAttributedString *ratingStr = [[NSMutableAttributedString alloc] init];
    [ratingStr appendAttributedString:ratingBaseAttr];
    [ratingStr appendAttributedString:ratingTypeAttr];
    self.ratingDescription.attributedText = ratingStr;
    
    self.reviewsAmount.text = [NSString stringWithFormat:@"%ld reviews", (long)self.search.selectedVehicle.vendor.rating.totalReviews.integerValue];
    
    _ratings = @[
                 @{@"type" : @"Wait time", @"value" : [NSString stringWithFormat:@"%@ mins", self.search.selectedVehicle.vendor.rating.waitTime.stringValue]},
                 @{@"type" : @"Overall Score", @"value" : [NSString stringWithFormat:@"%.1f/10", self.search.selectedVehicle.vendor.rating.overallScore.floatValue * 2]},
                 @{@"type" : @"Desk Review", @"value" : [NSString stringWithFormat:@"%.0f/10", self.search.selectedVehicle.vendor.rating.deskReview.doubleValue/10]},
                 @{@"type" : @"Vehicle Review", @"value" : [NSString stringWithFormat:@"%.0f/10", self.search.selectedVehicle.vendor.rating.carReview.doubleValue/10]},
                 @{@"type" : @"Price Score", @"value" : [NSString stringWithFormat:@"%.0f/10", self.search.selectedVehicle.vendor.rating.priceScore.doubleValue/10]},
                 @{@"type" : @"Dropoff Review", @"value" : [NSString stringWithFormat:@"%.0f/10", self.search.selectedVehicle.vendor.rating.dropoffReview.doubleValue/10]}];
    
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.ratings.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SupplierRatingCollectionViewCell *cell = (SupplierRatingCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                                                                 forIndexPath:indexPath];
    
    [cell setType:[self.ratings[indexPath.row] objectForKey:@"type"] ratingText:[self.ratings[indexPath.row] objectForKey:@"value"]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width/2-30, 105);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat cellWidth = collectionView.frame.size.width/2-30;
    
    CGFloat inset = fabs(((cellWidth * 2) - collectionView.frame.size.width) / 2) - 8;
    
    return UIEdgeInsetsMake(8, inset, 8, inset);
}


@end
