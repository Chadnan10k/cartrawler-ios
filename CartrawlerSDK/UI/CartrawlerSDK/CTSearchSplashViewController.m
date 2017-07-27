//
//  CTSearchSplashViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchSplashViewController.h"
#import "CTAppController.h"
#import "CTSearchSplashViewModel.h"
#import "CTSplashCarView.h"

@interface CTSearchSplashViewController ()
@property (nonatomic, strong) CTSearchSplashViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet CTSplashCarView *splashCarView;
@property (weak, nonatomic) IBOutlet UILabel *splashLabel;
@property (weak, nonatomic) IBOutlet UILabel *searchBoxLabel;
@property (weak, nonatomic) IBOutlet UIImageView *searchIcon;
@end

@implementation CTSearchSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchIcon setImage:[self.searchIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [self updateWithViewModel:self.viewModel];
}

- (void)updateWithViewModel:(CTSearchSplashViewModel *)viewModel {
    self.viewModel = viewModel;
    self.containerView.backgroundColor = viewModel.primaryColor;
    self.splashCarView.backgroundColor = viewModel.primaryColor;
    self.splashCarView.primaryColor = viewModel.primaryColor;
    self.splashLabel.text = viewModel.splashText;
    self.searchBoxLabel.text = viewModel.searchBoxText;
}

- (IBAction)didTapEnterLocation:(id)sender {
    [CTAppController dispatchAction:CTActionSearchUserDidTapPickupTextField payload:nil];
}

@end
