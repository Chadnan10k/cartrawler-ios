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
@property (weak, nonatomic) IBOutlet UIView *navigationBar;
@property (nonatomic, weak) CTSelectedVehicleInfoViewController *selectedVehicleInfoViewController;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UILabel *chevron;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedVehicleInfoViewHeight;
@property (nonatomic, weak) CTSelectedVehicleTabViewController *selectedVehicleTabViewController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedVehicleTabViewHeight;
@property (nonatomic, weak) CTSelectedVehicleInsuranceViewController *selectedVehicleInsuranceViewController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedVehicleInsuranceViewHeight;
@property (nonatomic, weak) CTSelectedVehicleExtrasViewController *selectedVehicleExtrasViewController;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (nonatomic, assign) BOOL viewHasAppeared;
@end

@implementation CTSelectedVehicleViewController

+ (Class)viewModelClass {
    return CTSelectedVehicleViewModel.class;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.viewHasAppeared = YES;
}

- (void)updateWithViewModel:(CTSelectedVehicleViewModel *)viewModel {
    // Force load views
    self.view = self.view;
    
    self.navigationBar.backgroundColor = viewModel.navigationBarColor;
    
    if (![self.totalAmount.text isEqualToString:viewModel.totalAmount]) {
        [UIView transitionWithView:self.totalAmount
                          duration:.5f
                           options:UIViewAnimationOptionCurveEaseInOut |
         UIViewAnimationOptionTransitionFlipFromTop
                        animations:^{
                            self.totalAmount.text = viewModel.totalAmount;
                        } completion:nil];
    }
    
    [self.selectedVehicleInfoViewController updateWithViewModel:viewModel.selectedVehicleInfoViewModel];
    [self.selectedVehicleTabViewController updateWithViewModel:viewModel.selectedVehicleTabViewModel];
    [self.selectedVehicleInsuranceViewController updateWithViewModel:viewModel.selectedVehicleInsuranceViewModel];
    [self.selectedVehicleExtrasViewController updateWithViewModel:viewModel.selectedVehicleExtrasViewModel];
    
    self.selectedVehicleInfoViewHeight.constant = [self.selectedVehicleInfoViewController.view systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    self.selectedVehicleTabViewHeight.constant = [self.selectedVehicleTabViewController.view systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    // TODO: Remove magic number
    self.selectedVehicleInsuranceViewHeight.constant = viewModel.selectedVehicleInsuranceViewModel ? 400 : 0;
    self.nextButton.backgroundColor = viewModel.buttonColor;
    if (self.viewHasAppeared) {
        [UIView animateWithDuration:self.viewHasAppeared ? 0.2 : 0
                         animations:^{
                             [self.view layoutIfNeeded];
                         }];
    }
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
- (IBAction)backButtonTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapBack payload:nil];
}

- (IBAction)totalButtonTapped:(id)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Coming Soon" message:@"This feature is under construction" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    [controller addAction:okAction];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)nextButtonTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapNext payload:nil];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}

@end
