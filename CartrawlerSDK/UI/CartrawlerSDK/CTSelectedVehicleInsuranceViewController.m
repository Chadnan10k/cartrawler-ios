//
//  CTSelectedVehicleInsuranceViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleInsuranceViewController.h"
#import "CTSelectedVehicleInsuranceViewModel.h"
#import "CTInsuranceImageView.h"
#import "CTAppController.h"

@interface CTSelectedVehicleInsuranceViewController ()
@property (weak, nonatomic) IBOutlet CTInsuranceImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkmark1;
@property (weak, nonatomic) IBOutlet UILabel *infoTip1;
@property (weak, nonatomic) IBOutlet UILabel *checkmark2;
@property (weak, nonatomic) IBOutlet UILabel *infoTip2;
@property (weak, nonatomic) IBOutlet UILabel *checkmark3;
@property (weak, nonatomic) IBOutlet UILabel *infoTip3;
@property (weak, nonatomic) IBOutlet UIButton *details;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *pricePerDay;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UIButton *addInsuranceButton;




@end

@implementation CTSelectedVehicleInsuranceViewController

- (void)updateWithViewModel:(CTSelectedVehicleInsuranceViewModel *)viewModel {
    self.titleLabel.text = viewModel.title;
    self.checkmark1.textColor = viewModel.primaryColor;
    self.checkmark2.textColor = viewModel.primaryColor;
    self.checkmark3.textColor = viewModel.primaryColor;
    self.infoTip1.text = viewModel.infoTip1;
    self.infoTip2.text = viewModel.infoTip2;
    self.infoTip3.text = viewModel.title;
    [self.details setTitle:viewModel.detailsTitle forState:UIControlStateNormal];
    [self.details setTitleColor:viewModel.primaryColor forState:UIControlStateNormal];
    self.pricePerDay.text = viewModel.pricePerDay;
    self.total.text = viewModel.total;
    [self.addInsuranceButton setTitle:viewModel.addInsurance forState:UIControlStateNormal];
    self.addInsuranceButton.backgroundColor = viewModel.primaryColor;
}
- (IBAction)insuranceDetailsTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapInsuranceDetails payload:nil];
}

- (IBAction)addInsuranceButtonTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapAddInsurance payload:nil];
}


@end
