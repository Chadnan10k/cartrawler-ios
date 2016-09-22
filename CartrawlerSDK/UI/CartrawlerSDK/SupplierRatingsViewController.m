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
    
    self.ratingScore.text = [NSString stringWithFormat:@"%.1f/10", self.search.selectedVehicle.vendor.rating.overallScore.floatValue * 2];
    
    if (self.search.selectedVehicle.vendor.rating.overallScore.floatValue * 2 < 5) {
        self.ratingDescription.text = @"Below average";
    } else {
        self.ratingDescription.text = @"Good";
    }
    
    self.reviewsAmount.text = [NSString stringWithFormat:@"Based on %ld customer reviews", (long)self.search.selectedVehicle.vendor.rating.totalReviews.integerValue];
    
    _ratings = @[@{@"type" : @"Reviews", @"value" : @"680"},
                 @{@"type" : @"Wait time", @"value" : @"10 mins"},
                 @{@"type" : @"Overall Score", @"value" : @"8/10"},
                 @{@"type" : @"Desk Review", @"value" : @"9/10"},
                 @{@"type" : @"Car Review", @"value" : @"8/10"}];
    
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


@end
