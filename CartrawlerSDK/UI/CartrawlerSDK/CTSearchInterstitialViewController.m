//
//  CTSearchInterstitialViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchInterstitialViewController.h"
#import "CTSearchInterstitialViewModel.h"
#import "CTAppController.h"

@interface CTSearchInterstitialViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *message;
@end

@implementation CTSearchInterstitialViewController

+ (Class)viewModelClass {
    return CTSearchInterstitialViewModel.class;
}

- (void)updateWithViewModel:(CTSearchInterstitialViewModel *)viewModel {
    self.navigationBar.barTintColor = viewModel.navigationBarColor;
    self.titleLabel.text = viewModel.navigationBarTitle;
    self.detailLabel.text = viewModel.navigationBarDetail;
    self.message.text = viewModel.message;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}

@end
