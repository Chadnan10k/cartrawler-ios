//
//  CTVehicleListTableViewCell.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleListTableViewCell.h"
#import "CTVehicleListTableViewModel.h"
#import "CTImageCache.h"
#import "CTBannerEdgeView.h"

@interface CTVehicleListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *vehicleLabel;
@property (weak, nonatomic) IBOutlet CTBannerEdgeView *bannerEdgeView;
@property (weak, nonatomic) IBOutlet UILabel *bannerLabel;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UILabel *passengersLabel;
@property (weak, nonatomic) IBOutlet UILabel *bagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *fuelLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *specialOfferHeight;
@property (weak, nonatomic) IBOutlet UIView *specialOfferView;
@property (weak, nonatomic) IBOutlet UILabel *specialOfferLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vendorImageView;
@property (weak, nonatomic) IBOutlet UILabel *vendorRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *perDayLabel;
@end

@implementation CTVehicleListTableViewCell

- (void)updateWithViewModel:(CTVehicleListTableViewModel *)viewModel {
    self.vehicleLabel.attributedText = viewModel.vehicleName;
    self.bannerEdgeView.alpha = viewModel.displayMerchandising;
    self.bannerEdgeView.primaryColor = viewModel.merchandisingColor;
    [self.bannerEdgeView setNeedsDisplay];
    self.bannerView.alpha = viewModel.displayMerchandising;
    self.bannerView.backgroundColor = viewModel.merchandisingColor;
    self.bannerLabel.alpha = viewModel.displayMerchandising;
    self.bannerLabel.text = viewModel.merchandisingText;
    self.passengersLabel.text = viewModel.passengers;
    self.bagsLabel.text = viewModel.bags;
    self.fuelLabel.text = viewModel.fuel;
    self.locationLabel.text = viewModel.location;
    
    [[CTImageCache sharedInstance] cachedImage:viewModel.vehicleURL completion:^(UIImage *image) {
        self.carImageView.image = image;
    }];
    
    self.specialOfferHeight.constant = viewModel.displaySpecialOffer ? 24 : 0;
    self.specialOfferView.backgroundColor = viewModel.specialOfferColor;
    self.specialOfferLabel.text = viewModel.specialOffer;
    
    [[CTImageCache sharedInstance] cachedImage:viewModel.vendorURL completion:^(UIImage *image) {
        self.vendorImageView.image = image;
    }];
    
    self.vendorRatingLabel.attributedText = viewModel.vendorRating;
    self.priceLabel.attributedText = viewModel.price;
    //self.perDayLabel.text = viewModel.perDay;
}

@end
