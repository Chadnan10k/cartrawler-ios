//
//  GTPassengerViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 08/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//
#import "GTPassengerViewController.h"
#import "CTTextField.h"
#import "BookingSummaryButton.h"
#import "AddressDetailsViewController.h"
#import "CTLabel.h"
#import "CTFlightNumberValidation.h"

@interface GTPassengerViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet CTTextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet CTTextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet CTTextField *emailTextField;
@property (weak, nonatomic) IBOutlet CTTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet CTTextField *flightNoTextField;
@property (weak, nonatomic) IBOutlet CTTextField *instructionsTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet CTLabel *flightDetailsLabel;
@property (weak, nonatomic) IBOutlet CTDesignableView *flightDetailsContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *flightDetailsConstraint;

@property (strong, nonatomic) UIView *selectedView;

@end

#define kTabBarHeight 0.0

@implementation GTPassengerViewController {
    BOOL keyboardIsShown;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.phoneTextField.delegate = self;
    self.flightNoTextField.delegate = self;
    self.instructionsTextField.delegate = self;

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
    [self registerForKeyboardNotifications];
    _selectedView = self.firstNameTextField;

    if (self.groundSearch.selectedService) {
        [self.flightNoTextField becomeFirstResponder];
    } else {
        [self.firstNameTextField becomeFirstResponder];
    }
    
    if (self.groundSearch.selectedShuttle) {
        self.flightDetailsContainer.hidden = YES;
        self.flightDetailsConstraint.constant = 8;
    } else if (self.groundSearch.selectedService) {
        self.flightDetailsContainer.hidden = NO;
        self.flightDetailsConstraint.constant = 164;
        
        if (self.groundSearch.airportIsPickupLocation) {
            NSString *pickup = [NSString stringWithFormat:@"Pickup: %@", self.groundSearch.pickupLocation.name];
            self.flightDetailsLabel.text = pickup;
        } else {
            NSString *dropoff = [NSString stringWithFormat:@"Dropoff: %@", self.groundSearch.dropoffLocation.name];
            self.flightDetailsLabel.text = dropoff;
        }
    }
    
    if (!self.groundSearch.firstName) {
        self.firstNameTextField.text = @"";
    }
    
    if (!self.groundSearch.surname) {
        self.lastNameTextField.text = @"";
    }
    
    if (!self.groundSearch.email) {
        self.emailTextField.text = @"";
    }
    
    if (!self.groundSearch.phone) {
        self.phoneTextField.text = @"";
    }
    
    if (!self.groundSearch.flightNumber) {
        self.flightNoTextField.text = @"";
    }
    
    if (!self.groundSearch.specialInstructions) {
        self.instructionsTextField.text = @"";
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
    [self done];
    
    self.groundSearch.firstName = self.firstNameTextField.text;
    self.groundSearch.surname = self.lastNameTextField.text;
    self.groundSearch.email = self.emailTextField.text;
    self.groundSearch.phone = self.phoneTextField.text;
    self.groundSearch.flightNumber = self.groundSearch.selectedService ? self.flightNoTextField.text : nil;
    self.groundSearch.specialInstructions = self.instructionsTextField.text;
    
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
    
    if (![CTFlightNumberValidation isValid:self.flightNoTextField.text] && self.groundSearch.selectedService != nil ) {
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

#pragma mark TextField

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _selectedView = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    switch (textField.tag) {
        case 0: //flight details
            [self.firstNameTextField becomeFirstResponder];
            return NO;
            break;
        case 1: //first name
            [self.lastNameTextField becomeFirstResponder];
            return NO;
            break;
        case 2: //surname
            [self.emailTextField becomeFirstResponder];
            return NO;
            break;
        case 3: //email
            [self.phoneTextField becomeFirstResponder];
            return NO;
            break;
        case 4: //phone
            [self.instructionsTextField becomeFirstResponder];
            return NO;
            break;
        case 5: //instructions
            [self.view endEditing:YES];
            return NO;
            break;
            
        default:
            [self.view endEditing:YES];
            return YES;
            break;
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTextField) {
        return [self validatePhone:[NSString stringWithFormat:@"%@%@", self.phoneTextField.text, string]];
    } else if (textField != self.emailTextField) {
            return YES;
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
    [self done];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
