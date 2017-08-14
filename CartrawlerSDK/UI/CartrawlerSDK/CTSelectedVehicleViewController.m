//
//  CTSelectedVehicleViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleViewController.h"
#import "CTSelectedVehicleViewModel.h"
#import "CTSelectedVehicleInfoViewController.h"
#import "CTSelectedVehicleTabViewController.h"
#import "CTSelectedVehicleInsuranceViewController.h"
#import "CTSelectedVehicleExtrasViewController.h"
#import "CTAppController.h"

@interface CTSelectedVehicleViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *vehicleDetailsContainerView;
@property (nonatomic, weak) CTSelectedVehicleInfoViewController *selectedVehicleInfoViewController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedVehicleInfoViewHeight;
@property (nonatomic, weak) CTSelectedVehicleTabViewController *selectedVehicleTabViewController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedVehicleTabViewHeight;
@property (nonatomic, weak) CTSelectedVehicleInsuranceViewController *selectedVehicleInsuranceViewController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedVehicleInsuranceViewHeight;
@property (nonatomic, weak) CTSelectedVehicleExtrasViewController *selectedVehicleExtrasViewController;
@end

@implementation CTSelectedVehicleViewController

+ (Class)viewModelClass {
    return CTSelectedVehicleViewModel.class;
}

- (void)updateWithViewModel:(CTSelectedVehicleViewModel *)viewModel {
    // Force segued views to load
    self.view = self.view;
    
    self.navigationController.navigationBar.barTintColor = viewModel.navigationBarColor;
    
    [self.selectedVehicleInfoViewController updateWithViewModel:viewModel.selectedVehicleInfoViewModel];
    [self.selectedVehicleTabViewController updateWithViewModel:viewModel.selectedVehicleTabViewModel];
    [self.selectedVehicleInsuranceViewController updateWithViewModel:viewModel.selectedVehicleInsuranceViewModel];
    [self.selectedVehicleExtrasViewController updateWithViewModel:viewModel.selectedVehicleExtrasViewModel];
    
    self.selectedVehicleInfoViewHeight.constant = [self.selectedVehicleInfoViewController.view systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    self.selectedVehicleTabViewHeight.constant = [self.selectedVehicleTabViewController.view systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    self.selectedVehicleInsuranceViewHeight.constant = viewModel.selectedVehicleInsuranceViewModel ? [self.selectedVehicleInsuranceViewController.view systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height : 0;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SelectedVehicleInfo"]) {
        self.selectedVehicleInfoViewController = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"SelectedVehicleTab"]) {
        self.selectedVehicleTabViewController = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"SelectedVehicleInsurance"]) {
        self.selectedVehicleInsuranceViewController = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"SelectedVehicleExtras"]) {
        self.selectedVehicleExtrasViewController = segue.destinationViewController;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapBack payload:nil];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}

@end
