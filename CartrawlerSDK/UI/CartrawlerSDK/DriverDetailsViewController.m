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

@interface DriverDetailsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet CTTextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet CTTextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet CTTextField *emailTextField;
@property (weak, nonatomic) IBOutlet CTTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet CTTextField *flightNoTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet BookingSummaryButton *summaryContainer;

@end

#define kTabBarHeight 0.0

@implementation DriverDetailsViewController {
    BOOL keyboardIsShown;
}

+ (void)forceLinkerLoad_
{
    
}

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
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(done)];
    keyboardDoneButtonView.items = @[doneButton];
    self.phoneTextField.inputAccessoryView = keyboardDoneButtonView;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.summaryContainer closeIfOpen];
    [self.summaryContainer setDataWithVehicle:self.search.selectedVehicle
                                   pickupDate:self.search.pickupDate
                                  dropoffDate:self.search.dropoffDate
                            isBuyingInsurance:self.search.isBuyingInsurance];
    
    [self registerForKeyboardNotifications];
    
    if (!self.search.firstName) {
        self.firstNameTextField.text = @"";
    }
    
    if (!self.search.surname) {
        self.lastNameTextField.text = @"";
    }
    
    if (!self.search.email) {
        self.emailTextField.text = @"";
    }
    
    if (!self.search.phone) {
        self.phoneTextField.text = @"";
    }
    
    if (!self.search.flightNumber) {
        self.flightNoTextField.text = @"";
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self deregisterForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    self.search.firstName = self.firstNameTextField.text;
    self.search.surname = self.lastNameTextField.text;
    self.search.email = self.emailTextField.text;
    self.search.phone = self.phoneTextField.text;
    self.search.flightNumber = self.flightNoTextField.text;

    AddressDetailsViewController *destination = (AddressDetailsViewController *)segue.destinationViewController;
    destination.destinationViewController = self.destinationViewController;
    destination.cartrawlerAPI = self.cartrawlerAPI;
    destination.validationController = self.validationController;
    destination.search = self.search;
}

- (IBAction)confirmDetails:(id)sender
{
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
    
    if ([self.flightNoTextField.text isEqualToString: @""]) {
        [self.flightNoTextField shakeAnimation];
        validated = NO;
    }
    
    if (validated) {
        [self performSegueWithIdentifier:@"addressDetails" sender:nil];
    }
}

- (void)done
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.summaryContainer closeIfOpen];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
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
    NSString *phoneRegex = @"^[0-9]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:phoneNumber];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)deregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = n.userInfo;
    CGSize keyboardSize = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.scrollView.frame;
    viewFrame.size.height += (keyboardSize.height - kTabBarHeight);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    (self.scrollView).frame = viewFrame;
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = n.userInfo;
    CGSize keyboardSize = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.scrollView.frame;
    viewFrame.size.height -= (keyboardSize.height - kTabBarHeight);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    (self.scrollView).frame = viewFrame;
    [UIView commitAnimations];
    keyboardIsShown = YES;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
