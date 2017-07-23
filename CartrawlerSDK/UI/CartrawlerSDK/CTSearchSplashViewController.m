//
//  CTSearchSplashViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchSplashViewController.h"
#import "CTAppController.h"

@interface CTSearchSplashViewController ()

@end

@implementation CTSearchSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapEnterLocation:(id)sender {
    [CTAppController dispatchAction:CTActionSearchUserDidTapPickupTextField payload:nil];
}

@end
