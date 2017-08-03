//
//  CTSelectedVehicleViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleViewController.h"
#import "CTSelectedVehicleViewModel.h"

@interface CTSelectedVehicleViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *vehicleDetailsContainerView;

@end

@implementation CTSelectedVehicleViewController

+ (Class)viewModelClass {
    return CTSelectedVehicleViewModel.class;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)updateWithViewModel:(id)viewModel {
    
}

@end
