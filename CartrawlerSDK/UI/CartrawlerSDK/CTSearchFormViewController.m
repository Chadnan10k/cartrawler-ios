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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *pickupLocationTextField;
@property (weak, nonatomic) IBOutlet UIButton *returnToSameLocationCheckbox;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *dropoffLocationTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *selectDatesTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *pickupTimeTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *dropOffTimeTextField;
@property (weak, nonatomic) IBOutlet UIButton *driverAgeCheckbox;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *driverAgeTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIBarButtonItem *doneButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropoffLocationMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropoffLocationHeight;
@property (weak, nonatomic) IBOutlet UIView *dropoffLocationView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *driverAgeMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *driverAgeHeight;
@property (weak, nonatomic) IBOutlet UIView *driverAgeView;

@property (nonatomic, strong) UIDatePicker *timePicker;

@property (nonatomic, strong) CTSearchFormViewModel *viewModel;

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
    self.driverAgeTextField.tag = CTSearchFormTextFieldDriverAge;
    
    self.timePicker = [UIDatePicker new];
    self.timePicker.datePickerMode = UIDatePickerModeTime;
    self.timePicker.minuteInterval = 15;
    self.timePicker.locale = [NSLocale currentLocale];
    [self.timePicker addTarget:self action:@selector(didChangeTime:) forControlEvents:UIControlEventValueChanged];
    self.pickupTimeTextField.inputView = self.timePicker;
    self.dropOffTimeTextField.inputView = self.timePicker;
    
    self.driverAgeTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(didTapDone:)];
    UIBarButtonItem *space= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                          target:nil
                                                                          action:nil];
    [self.toolbar setItems:@[space, self.doneButton]];
    
    self.pickupTimeTextField.inputAccessoryView = self.toolbar;
    self.dropOffTimeTextField.inputAccessoryView = self.toolbar;
    self.driverAgeTextField.inputAccessoryView = self.toolbar;
    
    // Hides the cursor
    self.pickupTimeTextField.tintColor = [UIColor clearColor];
    self.dropOffTimeTextField.tintColor = [UIColor clearColor];
}

- (void)updateWithViewModel:(CTSearchFormViewModel *)viewModel {
    self.viewModel = viewModel;
    
    self.view.backgroundColor = viewModel.backgroundColor;
    self.driverAgeTextField.tintColor = viewModel.driverAgeCursorColor;
    self.nextButton.backgroundColor = viewModel.nextButtonColor;
    [self.doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:viewModel.doneButtonColor, NSForegroundColorAttributeName,nil]
                                   forState:UIControlStateNormal];
    
    self.pickupLocationTextField.text = viewModel.pickupLocationName;
    self.dropoffLocationTextField.text = viewModel.dropoffLocationName;
    self.selectDatesTextField.text = viewModel.rentalDates;
    self.pickupTimeTextField.text = viewModel.pickupTime;
    self.dropOffTimeTextField.text = viewModel.dropoffTime;
    self.timePicker.date = viewModel.defaultPickerTime;
    self.driverAgeTextField.text = viewModel.displayedDriverAge;
    [self.returnToSameLocationCheckbox setTitle:viewModel.returnToSameLocationCheckboxText forState:UIControlStateNormal];
    [self.driverAgeCheckbox setTitle:viewModel.driverAgeCheckboxText forState:UIControlStateNormal];
    
    switch (viewModel.selectedTextField) {
        case CTSearchFormTextFieldNone:
        case CTSearchFormTextFieldPickupLocation:
        case CTSearchFormTextFieldDropoffLocation:
        case CTSearchFormTextFieldSelectDates:
            [self.view endEditing:YES];
            break;
        case CTSearchFormTextFieldPickupTime:
            if (!self.pickupTimeTextField.isFirstResponder) {
                [self.pickupTimeTextField becomeFirstResponder];
            }
            break;
        case CTSearchFormTextFieldDropoffTime:
            if (!self.dropOffTimeTextField.isFirstResponder) {
                [self.dropOffTimeTextField becomeFirstResponder];
            }
            break;
        case CTSearchFormTextFieldDriverAge:
            if (!self.driverAgeTextField.isFirstResponder) {
                [self.driverAgeTextField becomeFirstResponder];
            }
            break;
        default:
            break;
    }
    
    self.dropoffLocationHeight.constant = viewModel.dropoffLocationTextfieldDisplayed ? 64 : 0;
    self.dropoffLocationMargin.constant = viewModel.dropoffLocationTextfieldDisplayed ? 16 : 0;
    
    self.driverAgeHeight.constant = viewModel.driverAgeTextfieldDisplayed ? 64 : 0;
    self.driverAgeMargin.constant = viewModel.driverAgeTextfieldDisplayed ? 16 : 0;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.dropoffLocationView.alpha = viewModel.dropoffLocationTextfieldDisplayed;
        self.driverAgeView.alpha = viewModel.driverAgeTextfieldDisplayed;
        [self.view layoutIfNeeded];
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // TODO: fix tab problem
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
        case CTSearchFormTextFieldDropoffTime:
        case CTSearchFormTextFieldDriverAge:
            return YES;
        default:
            break;
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    switch (textField.tag) {
        case CTSearchFormTextFieldPickupTime:
            [CTAppController dispatchAction:CTActionSearchUserDidTapPickupTimeTextField payload:@(self.pickupTimeTextField.frame.origin.y + self.pickupTimeTextField.frame.size.height)];
            break;
        case CTSearchFormTextFieldDropoffTime:
            [CTAppController dispatchAction:CTActionSearchUserDidTapDropoffTimeTextField payload:@(self.dropOffTimeTextField.frame.origin.y + self.dropOffTimeTextField.frame.size.height)];
            break;
        case CTSearchFormTextFieldDriverAge:
            [CTAppController dispatchAction:CTActionSearchUserDidTapAgeTextField payload:@(self.driverAgeView.frame.origin.y + self.driverAgeView.frame.size.height)];
            
            break;
        default:
            break;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newCharacters = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [CTAppController dispatchAction:CTActionSearchDriverAgeUserDidEnterCharacters payload:newCharacters];
    return NO;
}
- (IBAction)didToggleReturnToSameLocation:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionSearchUserDidToggleReturnToSameLocation payload:nil];
}

- (void)didChangeTime:(UIDatePicker *)picker {
    [CTAppController dispatchAction:CTActionSearchTimePickerUserDidSelectTime payload:picker.date];
}

- (void)didTapDone:(id)sender {
    [CTAppController dispatchAction:CTActionSearchInputViewUserDidSelectDone payload:nil];
}

- (IBAction)didToggleDriverAge:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionSearchUserDidToggleDriverAge payload:nil];
}

- (IBAction)searchButtonTapped:(id)sender {
    [CTAppController dispatchAction:CTActionSearchUserDidTapNext payload:nil];
}

@end
