//
//  CTSelectedVehicleRatingsViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleRatingsViewController.h"
#import "CTSelectedVehicleRatingsViewModel.h"
#import "CTImageCache.h"

@interface CTSelectedVehicleRatingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *providedByTitle;
@property (weak, nonatomic) IBOutlet UIImageView *providedByImageView;
@property (weak, nonatomic) IBOutlet UILabel *overallTitle;
@property (weak, nonatomic) IBOutlet UILabel *overallScore;
@property (weak, nonatomic) IBOutlet UILabel *valueTitle;
@property (weak, nonatomic) IBOutlet UILabel *valueScore;
@property (weak, nonatomic) IBOutlet UILabel *cleanlinessTitle;
@property (weak, nonatomic) IBOutlet UILabel *cleanlinessScore;
@property (weak, nonatomic) IBOutlet UILabel *serviceTitle;
@property (weak, nonatomic) IBOutlet UILabel *serviceScore;
@property (weak, nonatomic) IBOutlet UILabel *pickupTitle;
@property (weak, nonatomic) IBOutlet UILabel *pickupScore;
@property (weak, nonatomic) IBOutlet UILabel *dropoffTitle;
@property (weak, nonatomic) IBOutlet UILabel *dropoffScore;
@property (weak, nonatomic) IBOutlet UILabel *waitingTimeTitle;
@property (weak, nonatomic) IBOutlet UILabel *waitingTimeScore;
@property (weak, nonatomic) IBOutlet UILabel *customerRatings;

@end

@implementation CTSelectedVehicleRatingsViewController

- (void)updateWithViewModel:(CTSelectedVehicleRatingsViewModel *)viewModel {
    self.providedByTitle.text = viewModel.providedBy;
    [[CTImageCache sharedInstance] cachedImage:viewModel.providedByImage completion:^(UIImage *image) {
        self.providedByImageView.image = image;
    }];
    self.overallTitle.text = viewModel.overall;
    self.overallScore.text = viewModel.overallRating;
    self.valueTitle.text = viewModel.valueForMoney;
    self.valueScore.text = viewModel.valueForMoneyRating;
    self.cleanlinessTitle.text = viewModel.cleanliness;
    self.cleanlinessScore.text = viewModel.cleanlinessRating;
    self.serviceTitle.text = viewModel.service;
    self.serviceScore.text = viewModel.serviceRating;
    self.pickupTitle.text = viewModel.pickupProcess;
    self.pickupScore.text = viewModel.pickupProcessRating;
    self.dropoffTitle.text = viewModel.dropoffProcess;
    self.dropoffScore.text = viewModel.dropoffProcessRating;
    self.waitingTimeTitle.text = viewModel.averageWaitingTime;
    self.waitingTimeScore.text = viewModel.averageWaitingTimeRating;
    self.customerRatings.text = viewModel.customerRatings;
}


@end
