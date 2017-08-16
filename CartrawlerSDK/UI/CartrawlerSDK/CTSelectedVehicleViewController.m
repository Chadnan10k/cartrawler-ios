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
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@end

@implementation CTSelectedVehicleViewController

+ (Class)viewModelClass {
    return CTSelectedVehicleViewModel.class;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedVehicleInsuranceViewHeight.constant = 0;
    [self.view layoutIfNeeded];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view layoutIfNeeded];
}

- (void)updateWithViewModel:(CTSelectedVehicleViewModel *)viewModel {
    // Force segued views to load
    self.view = self.view;
    
    self.navigationController.navigationBar.barTintColor = viewModel.navigationBarColor;
    
    [self.selectedVehicleInfoViewController updateWithViewModel:viewModel.selectedVehicleInfoViewModel];
    [self.selectedVehicleTabViewController updateWithViewModel:viewModel.selectedVehicleTabViewModel];
    [self.selectedVehicleInsuranceViewController updateWithViewModel:viewModel.selectedVehicleInsuranceViewModel];
    [self.selectedVehicleExtrasViewController updateWithViewModel:viewModel.selectedVehicleExtrasViewModel];
    
    self.selectedVehicleInfoViewHeight.constant = [self.selectedVehicleInfoViewController.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.selectedVehicleTabViewHeight.constant = [self.selectedVehicleTabViewController.view systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    if (viewModel.selectedVehicleTabViewModel) {
        self.selectedVehicleInsuranceViewHeight.constant = [self.selectedVehicleInsuranceViewController.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    }
    self.nextButton.backgroundColor = viewModel.buttonColor;
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
- (IBAction)nextButtonTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapNext payload:nil];
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
