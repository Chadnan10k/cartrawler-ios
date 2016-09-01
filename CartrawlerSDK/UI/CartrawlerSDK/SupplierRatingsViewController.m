//
//  SupplierRatingsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "SupplierRatingsViewController.h"
#import "CTImageCache.h"

@interface SupplierRatingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ratingScore;
@property (weak, nonatomic) IBOutlet UILabel *ratingDescription;
@property (weak, nonatomic) IBOutlet UILabel *reviewsAmount;
@property (weak, nonatomic) IBOutlet UIImageView *vendorImageView;

@property (strong, nonatomic) CTVendor *vendor;
@end

@implementation SupplierRatingsViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)setVendor:(CTVendor *)vendor
{
    _vendor = vendor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    [[CTImageCache sharedInstance] cachedImage: self.vendor.logoURL completion:^(UIImage *image) {
        self.vendorImageView.image = image;
    }];
    
    self.ratingScore.text = [NSString stringWithFormat:@"%.1f/10", self.vendor.rating.overallScore.floatValue * 2];
    
    if (self.vendor.rating.overallScore.floatValue * 2 < 5) {
        self.ratingDescription.text = @"Below average";
    } else {
        self.ratingDescription.text = @"Good";
    }
    
    self.reviewsAmount.text = [NSString stringWithFormat:@"Based on %ld customer reviews", (long)self.vendor.rating.totalReviews.integerValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
