//
//  CTSearchInterstitialViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchInterstitialViewController.h"
#import "CTSearchInterstitialViewModel.h"

@interface CTSearchInterstitialViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@end

@implementation CTSearchInterstitialViewController

+ (Class)viewModelClass {
    return CTSearchInterstitialViewModel.class;
}

- (void)updateWithViewModel:(CTSearchInterstitialViewModel *)viewModel {
    self.navigationBar.barTintColor = viewModel.navigationBarColor;
    self.titleLabel.text = viewModel.navigationBarTitle;
    self.detailLabel.text = viewModel.navigationBarDetail;
}

@end
