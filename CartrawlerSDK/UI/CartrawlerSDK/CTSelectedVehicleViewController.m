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
@property (nonatomic, weak) CTSelectedVehicleTabViewController *selectedVehicleTabViewController;
@property (nonatomic, weak) CTSelectedVehicleInsuranceViewController *selectedVehicleInsuranceViewController;
@property (nonatomic, weak) CTSelectedVehicleExtrasViewController *selectedVehicleExtrasViewController;
@end

@implementation CTSelectedVehicleViewController

+ (Class)viewModelClass {
    return CTSelectedVehicleViewModel.class;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Caution" message:@"This area is under construction" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)updateWithViewModel:(CTSelectedVehicleViewModel *)viewModel {
    // Force segued views to load
    self.view = self.view;
    
    [self.selectedVehicleInfoViewController updateWithViewModel:viewModel.selectedVehicleInfoViewModel];
    [self.selectedVehicleTabViewController updateWithViewModel:viewModel.selectedVehicleTabViewModel];
    [self.selectedVehicleInsuranceViewController updateWithViewModel:viewModel.selectedVehicleInsuranceViewModel];
    [self.selectedVehicleExtrasViewController updateWithViewModel:viewModel.selectedVehicleExtrasViewModel];
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
