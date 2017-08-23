//
//  CTSelectedVehicleInsuranceDetailsViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 23/08/2017.
//  Copyright (c) 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleInsuranceDetailsViewController.h"
#import "CTSelectedVehicleInsuranceDetailsViewModel.h"
#import "CTAppController.h"

@interface CTSelectedVehicleInsuranceDetailsViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *perDay;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *reduceLiability;
@property (weak, nonatomic) IBOutlet UILabel *reduceLiabilityDetails;
@property (weak, nonatomic) IBOutlet UILabel *whatsCovered;
@property (weak, nonatomic) IBOutlet UILabel *whatsCoveredDetails;
@property (weak, nonatomic) IBOutlet UIButton *termsAndConditionsButton;

@end;

@implementation CTSelectedVehicleInsuranceDetailsViewController

+ (Class)viewModelClass {
    return CTSelectedVehicleInsuranceDetailsViewModel.class;
}

- (void)updateWithViewModel:(CTSelectedVehicleInsuranceDetailsViewModel *)viewModel{
    self.navigationBar.barTintColor = viewModel.primaryColor;
    self.navigationBar.topItem.title = viewModel.title;
    UIImage *logo = [UIImage imageNamed:viewModel.logo inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    self.logo.image = logo;
    self.perDay.text = viewModel.perDay;
    self.total.text = viewModel.total;
    self.reduceLiability.text = viewModel.reduceLiability;
    self.reduceLiability.textColor = viewModel.primaryColor;
    self.reduceLiabilityDetails.text = viewModel.reduceLiabilityDetails;
    self.whatsCovered.text = viewModel.whatsCovered;
    self.whatsCovered.textColor = viewModel.primaryColor;
    self.whatsCoveredDetails.attributedText = viewModel.whatsCoveredDetails;
    [self.termsAndConditionsButton setTitle:viewModel.termsAndConditions forState:UIControlStateNormal];
    [self.termsAndConditionsButton setTitleColor:viewModel.primaryColor forState:UIControlStateNormal];
}

- (IBAction)closeButtonTapped:(id)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapInsuranceDetailsBackButton payload:nil];
}

- (IBAction)termsAndConditionsButtonTapped:(id)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapInsuranceTermsAndConditionsButton payload:nil];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}

@end
