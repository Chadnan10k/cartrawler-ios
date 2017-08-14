//
//  CTSelectedVehicleTabViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleTabViewController.h"
#import "CTSelectedVehicleIncludedViewController.h"
#import "CTSelectedVehicleRatingsViewController.h"
#import "CTSelectedVehicleTabViewModel.h"
#import "CTAppController.h"

@interface CTSelectedVehicleTabViewController ()
@property (weak, nonatomic) IBOutlet UIButton *includedButton;
@property (weak, nonatomic) IBOutlet UIView *includedIndicator;
@property (weak, nonatomic) IBOutlet UIButton *ratingsButton;
@property (weak, nonatomic) IBOutlet UIView *ratingsIndicator;
@property (nonatomic, weak) CTSelectedVehicleIncludedViewController *selectedVehicleIncludedViewController;
@property (weak, nonatomic) IBOutlet UIView *includedContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *includedContainerViewHeight;
@property (weak, nonatomic) IBOutlet UIView *ratingsContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ratingsContainerViewHeight;
@property (nonatomic, weak) CTSelectedVehicleRatingsViewController *selectedVehicleRatingsViewController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutViewHeightConstraint;
@end

@implementation CTSelectedVehicleTabViewController

- (void)updateWithViewModel:(CTSelectedVehicleTabViewModel *)viewModel {
    [self.includedButton setTitle:viewModel.included forState:UIControlStateNormal];
    [self.ratingsButton setTitle:viewModel.ratings forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         [self.includedButton setTitleColor:viewModel.includedColor forState:UIControlStateNormal];
                         self.includedIndicator.backgroundColor = viewModel.includedColor;
                         [self.ratingsButton setTitleColor:viewModel.ratingsColor forState:UIControlStateNormal];
                         self.ratingsIndicator.backgroundColor = viewModel.ratingsColor;
                         self.includedContainerView.alpha = viewModel.selectedTab == CTSelectedVehicleTabIncluded;
                         self.ratingsContainerView.alpha = viewModel.selectedTab == CTSelectedVehicleTabRatings;
                     }];
    
    [self.selectedVehicleIncludedViewController updateWithViewModel:viewModel.selectedVehicleIncludedViewModel];
    self.includedContainerViewHeight.constant = [self.selectedVehicleIncludedViewController.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    [self.selectedVehicleRatingsViewController updateWithViewModel:viewModel.selectedVehicleRatingsViewModel];
    self.ratingsContainerViewHeight.constant = [self.selectedVehicleRatingsViewController.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    self.layoutViewHeightConstraint.constant = viewModel.selectedTab == CTSelectedVehicleTabIncluded ? self.includedContainerViewHeight.constant : self.ratingsContainerViewHeight.constant;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SelectedVehicleIncluded"]) {
        self.selectedVehicleIncludedViewController = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"SelectedVehicleRatings"]) {
        self.selectedVehicleRatingsViewController = segue.destinationViewController;
    }
}

- (IBAction)includedButtonTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapTab payload:@(0)];
}

- (IBAction)ratingsButtonTapped:(id)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapTab payload:@(1)];
}

@end
