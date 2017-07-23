//
//  CTSearchFormViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchFormViewController.h"
#import "CTAppController.h"
#import "JVFloatLabeledTextField.h"
#import "CTSearchFormViewModel.h"

@interface CTSearchFormViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *pickupLocationTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *dropoffLocationTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *selectDatesTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *pickupTimeTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *dropOffTimeTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *driverAgeTextField;
@end

@implementation CTSearchFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Interface Builder won't allow adjusting of height with rounded rect selected
    self.pickupLocationTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.dropoffLocationTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.selectDatesTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.pickupTimeTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.dropOffTimeTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.driverAgeTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.pickupLocationTextField.tag = CTSearchFormTextFieldPickupLocation;
    self.dropoffLocationTextField.tag = CTSearchFormTextFieldDropoffLocation;
    self.selectDatesTextField.tag = CTSearchFormTextFieldSelectDates;
    self.pickupTimeTextField.tag = CTSearchFormTextFieldPickupTime;
    self.dropOffTimeTextField.tag = CTSearchFormTextFieldDropoffTime;
    self.driverAgeTextField.tag = CTSearchFormTextFieldAge;
}

- (void)updateWithViewModel:(CTSearchFormViewModel *)viewModel {
    self.pickupLocationTextField.text = viewModel.pickupLocationName;
    self.dropoffLocationTextField.text = viewModel.dropoffLocationName;
    
    self.selectDatesTextField.text = viewModel.rentalDates;
    
    self.pickupTimeTextField.text = viewModel.pickupTime;
    self.dropOffTimeTextField.text = viewModel.dropoffTime;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    switch (textField.tag) {
        case CTSearchFormTextFieldPickupLocation:
            [CTAppController dispatchAction:CTActionSearchUserDidTapPickupTextField payload:nil];
            break;
        case CTSearchFormTextFieldDropoffLocation:
            [CTAppController dispatchAction:CTActionSearchUserDidTapDropoffTextField payload:nil];
            break;
        case CTSearchFormTextFieldSelectDates:
            [CTAppController dispatchAction:CTActionSearchUserDidTapDatesTextField payload:nil];
            break;
        case CTSearchFormTextFieldPickupTime:
            [CTAppController dispatchAction:CTActionSearchUserDidTapPickupTimeTextField payload:nil];
            break;
        case CTSearchFormTextFieldDropoffTime:
            [CTAppController dispatchAction:CTActionSearchUserDidTapDropoffTimeTextField payload:nil];
            break;
        case CTSearchFormTextFieldAge:
            return YES;
            break;
        default:
            break;
    }
    return NO;
}

- (IBAction)searchButtonTapped:(id)sender {
    [CTAppController dispatchAction:CTActionSearchUserDidTapNext payload:nil];
}

@end
