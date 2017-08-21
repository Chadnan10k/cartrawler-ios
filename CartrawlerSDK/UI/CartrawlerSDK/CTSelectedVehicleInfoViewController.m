//
//  CTSelectedVehicleInfoViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleInfoViewController.h"
#import "CTSelectedVehicleInfoViewModel.h"
#import "CTBannerEdgeView.h"
#import "CTImageCache.h"

@interface CTSelectedVehicleInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orSimilarLabel;
@property (weak, nonatomic) IBOutlet CTBannerEdgeView *bannerEdgeView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UILabel *bannerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (weak, nonatomic) IBOutlet UILabel *passengersLabel;
@property (weak, nonatomic) IBOutlet UILabel *bagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *fuelLabel;
@property (weak, nonatomic) IBOutlet UIButton *featuresCountButton;
@property (weak, nonatomic) IBOutlet UILabel *featuresLabel;
@end

@implementation CTSelectedVehicleInfoViewController

- (void)updateWithViewModel:(CTSelectedVehicleInfoViewModel *)viewModel {
    self.titleLabel.text = viewModel.vehicleName;
    self.bannerView.backgroundColor = viewModel.merchandisingColor;
    self.bannerEdgeView.primaryColor = viewModel.merchandisingColor ? viewModel.merchandisingColor : [UIColor whiteColor];
    self.bannerLabel.text = viewModel.merchandisingText;
    
    [[CTImageCache sharedInstance] cachedImage:viewModel.vehicleURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    self.passengersLabel.text = viewModel.passengers;
    self.bagsLabel.text = viewModel.bags;
    self.fuelLabel.text = viewModel.fuel;
    
    [self.featuresCountButton setTitleColor:viewModel.primaryColor forState:UIControlStateNormal];
    self.featuresLabel.textColor = viewModel.primaryColor;
}

- (IBAction)featuresButtonTapped:(id)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Coming Soon" message:@"This feature is under construction" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    [controller addAction:okAction];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
