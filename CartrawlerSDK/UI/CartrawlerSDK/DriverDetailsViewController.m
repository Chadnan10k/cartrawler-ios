//
//  DriverDetailsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "DriverDetailsViewController.h"
#import "CTTextField.h"
#import "BookingSummaryButton.h"
#import "AddressDetailsViewController.h"
#import "FlightNumberValidation.h"

@interface DriverDetailsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet CTTextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet CTTextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet CTTextField *emailTextField;
@property (weak, nonatomic) IBOutlet CTTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet CTTextField *flightNoTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet BookingSummaryButton *summaryContainer;

@property (strong, nonatomic) UIView *selectedView;

@end

#define kTabBarHeight 0.0

@implementation DriverDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.phoneTextField.delegate = self;
    self.flightNoTextField.delegate = self;

    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(done)];
    keyboardDoneButtonView.items = @[doneButton];
    self.phoneTextField.inputAccessoryView = keyboardDoneButtonView;
    
    _selectedView = self.firstNameTextField;
    
    UITapGestureRecognizer *viewTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasTapped)];
    [self.view addGestureRecognizer:viewTapped];
    
}

- (void)viewWasTapped
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.summaryContainer closeIfOpen];
    [self.summaryContainer setDataWithVehicle:self.search.selectedVehicle
                                   pickupDate:self.search.pickupDate
                                  dropoffDate:self.search.dropoffDate
                            isBuyingInsurance:self.search.isBuyingInsurance];
    
    [self registerForKeyboardNotifications];
    
    [self.firstNameTextField becomeFirstResponder];
    _selectedView = self.firstNameTextField;
    
    if (!self.search.firstName) {
        self.firstNameTextField.text = @"";
    } else {
        self.firstNameTextField.text = self.search.firstName;
    }
    
    if (!self.search.surname) {
        self.lastNameTextField.text = @"";
    } else {
        self.lastNameTextField.text = self.search.surname;
    }
    
    if (!self.search.email) {
        self.emailTextField.text = @"";
    } else {
        self.emailTextField.text = self.search.email;
    }
    
    if (!self.search.phone) {
        self.phoneTextField.text = @"";
    } else {
        self.phoneTextField.text = self.search.phone;
    }
    
    if (!self.search.flightNumber) {
        self.flightNoTextField.text = @"";
    } else {
        self.flightNoTextField.text = self.search.flightNumber;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self deregisterForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)confirmDetails:(id)sender
{
    
    self.search.firstName = self.firstNameTextField.text;
    self.search.surname = self.lastNameTextField.text;
    self.search.email = self.emailTextField.text;
    self.search.phone = self.phoneTextField.text;
    self.search.flightNumber = self.flightNoTextField.text;
    
    BOOL validated = YES;
    
    if ([self.firstNameTextField.text isEqualToString: @""]) {
        [self.firstNameTextField shakeAnimation];
        validated = NO;
    }
    
    if ([self.lastNameTextField.text isEqualToString: @""]) {
        [self.lastNameTextField shakeAnimation];
        validated = NO;
    }
    
    if ([self.emailTextField.text isEqualToString: @""] || ![self.emailTextField isValidEmail]) {
        [self.emailTextField shakeAnimation];
        validated = NO;
    }
    
    if ([self.phoneTextField.text isEqualToString: @""]) {
        [self.phoneTextField shakeAnimation];
        validated = NO;
    }
    
    if (![self.flightNoTextField.text isEqualToString: @""] && ![FlightNumberValidation isValid:self.flightNoTextField.text]) {
        [self.flightNoTextField shakeAnimation];
        validated = NO;
    }
    
    if (validated) {
        [self pushToDestination];
    }
}

- (void)done
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.summaryContainer closeIfOpen];
    _selectedView = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  
    switch (textField.tag) {
        case 0:
            [self.lastNameTextField becomeFirstResponder];
            return NO;
            break;
        case 1:
            [self.emailTextField becomeFirstResponder];
            return NO;
            break;
        case 2:
            [self.phoneTextField becomeFirstResponder];
            return NO;
            break;
        case 3:
            [self.flightNoTextField becomeFirstResponder];
            return NO;
            break;
        case 4:
            [self.view endEditing:YES];
            return YES;
            break;
            
        default:
            [self.view endEditing:YES];
            return YES;
            break;
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [characterSet addCharactersInString:@" "];
    
    if (textField == self.phoneTextField) {
        return [self validatePhone:[NSString stringWithFormat:@"%@%@", self.phoneTextField.text, string]];
    } else if (textField != self.emailTextField) {
        if ([[NSString stringWithFormat:@"%@%@", self.phoneTextField.text, string] rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}

- (BOOL)validatePhone:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"(^\\+|[0-9456])([0-9]{0,15}$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:phoneNumber];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)deregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + 50, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.selectedView.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.selectedView.frame.origin.y-kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
