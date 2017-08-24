//
//  CTSelectedVehicleIncludedViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleIncludedViewController.h"
#import "CTSelectedVehicleIncludedViewModel.h"
#import "CTAppController.h"

@interface CTSelectedVehicleIncludedViewController ()

@property (weak, nonatomic) IBOutlet UILabel *pickupLocationTitle;
@property (weak, nonatomic) IBOutlet UILabel *fuelPolicyTitle;
@property (weak, nonatomic) IBOutlet UILabel *mileageAllowanceTitle;
@property (weak, nonatomic) IBOutlet UILabel *insuranceTitle;
@property (weak, nonatomic) IBOutlet UILabel *importantTitle;

@property (weak, nonatomic) IBOutlet UILabel *pickupLocationConcise;
@property (weak, nonatomic) IBOutlet UILabel *fuelPolicyConcise;
@property (weak, nonatomic) IBOutlet UILabel *mileageAllowanceConcise;
@property (weak, nonatomic) IBOutlet UILabel *insuranceConcise;
@property (weak, nonatomic) IBOutlet UILabel *importantConcise;

@property (weak, nonatomic) IBOutlet UILabel *pickupLocationChevron;
@property (weak, nonatomic) IBOutlet UILabel *fuelPolicyChevron;
@property (weak, nonatomic) IBOutlet UILabel *mileageAllowanceChevron;
@property (weak, nonatomic) IBOutlet UILabel *insuranceChevron;


@property (weak, nonatomic) IBOutlet UILabel *pickupLocationDetail;
@property (weak, nonatomic) IBOutlet UILabel *fuelPolicyDetail;
@property (weak, nonatomic) IBOutlet UILabel *mileageAllowanceDetail;
@property (weak, nonatomic) IBOutlet UILabel *insuranceDetail;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickupLocationHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fuelPolicyHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mileageAllowanceHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *insuranceHeight;

@end

@implementation CTSelectedVehicleIncludedViewController

- (void)updateWithViewModel:(CTSelectedVehicleIncludedViewModel *)viewModel {
    
    self.pickupLocationTitle.text = viewModel.pickupLocation;
    self.fuelPolicyTitle.text = viewModel.fuelPolicy;
    self.mileageAllowanceTitle.text = viewModel.mileageAllowance;
    self.insuranceTitle.text = viewModel.insurance;
    self.importantTitle.text = viewModel.important;
    
    self.pickupLocationConcise.text = viewModel.pickupLocationConcise;
    self.fuelPolicyConcise.text = viewModel.fuelPolicyConcise;
    self.mileageAllowanceConcise.text = viewModel.mileageAllowanceConcise;
    self.insuranceConcise.text = viewModel.insuranceConcise;
    self.importantConcise.text = viewModel.importantConcise;
    
    self.pickupLocationConcise.textColor = viewModel.primaryColor;
    self.fuelPolicyConcise.textColor = viewModel.primaryColor;
    self.mileageAllowanceConcise.textColor = viewModel.primaryColor;
    self.insuranceConcise.textColor = viewModel.primaryColor;
    self.importantConcise.textColor = viewModel.primaryColor;
    
    self.pickupLocationChevron.textColor = viewModel.primaryColor;
    self.fuelPolicyChevron.textColor = viewModel.primaryColor;
    self.mileageAllowanceChevron.textColor = viewModel.primaryColor;
    self.insuranceChevron.textColor = viewModel.primaryColor;
    
    self.pickupLocationDetail.text = viewModel.pickupLocationDetail;
    self.fuelPolicyDetail.text = viewModel.fuelPolicyDetail;
    self.mileageAllowanceDetail.text = viewModel.mileageAllowanceDetail;
    self.insuranceDetail.attributedText = viewModel.insuranceDetail;
    
    // TODO: Extract numbers
    self.pickupLocationHeight.constant = viewModel.pickupLocationExpanded ? 54 + [self.pickupLocationDetail systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height : 54;
    self.fuelPolicyHeight.constant = viewModel.fuelPolicyExpanded ? 54 + [self.fuelPolicyDetail systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height : 54;
    self.mileageAllowanceHeight.constant = viewModel.mileageAllowanceExpanded ? 54 + [self.mileageAllowanceDetail systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height : 54;
    self.insuranceHeight.constant = viewModel.insuranceExpanded ? 54 + [self.insuranceDetail systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height : 54;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.pickupLocationDetail.alpha = viewModel.pickupLocationExpanded;
        self.fuelPolicyDetail.alpha = viewModel.fuelPolicyExpanded;
        self.mileageAllowanceDetail.alpha = viewModel.mileageAllowanceExpanded;
        self.insuranceDetail.alpha = viewModel.insuranceExpanded;
        
        self.pickupLocationChevron.layer.affineTransform = viewModel.pickupLocationExpanded ? CGAffineTransformMakeScale(1, -1) : CGAffineTransformMakeScale(1, 1);
        self.fuelPolicyChevron.layer.affineTransform = viewModel.fuelPolicyExpanded ? CGAffineTransformMakeScale(1, -1) : CGAffineTransformMakeScale(1, 1);
        self.mileageAllowanceChevron.layer.affineTransform = viewModel.mileageAllowanceExpanded ? CGAffineTransformMakeScale(1, -1) : CGAffineTransformMakeScale(1, 1);
        self.insuranceChevron.layer.affineTransform = viewModel.insuranceExpanded ? CGAffineTransformMakeScale(1, -1) : CGAffineTransformMakeScale(1, 1);
    }];
}

- (IBAction)pickupLocationTapped:(UITapGestureRecognizer *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapIncludedItem payload:@(CTSelectedVehicleExpandedPickupLocation)];
}
- (IBAction)fuelPolicyTapped:(UITapGestureRecognizer *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapIncludedItem payload:@(CTSelectedVehicleExpandedFuelPolicy)];
}
- (IBAction)mileageAllowanceTapped:(UITapGestureRecognizer *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapIncludedItem payload:@(CTSelectedVehicleExpandedMileageAllowance)];
}
- (IBAction)insuranceTapped:(UITapGestureRecognizer *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapIncludedItem payload:@(CTSelectedVehicleExpandedInsurance)];
}

- (IBAction)importantTapped:(UITapGestureRecognizer *)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Coming Soon" message:@"This feature is under construction" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    [controller addAction:okAction];
    [self presentViewController:controller animated:YES completion:nil];
//    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapIncludedItem payload:@(CTSelectedVehicleExpandedImportant)];
}

@end
