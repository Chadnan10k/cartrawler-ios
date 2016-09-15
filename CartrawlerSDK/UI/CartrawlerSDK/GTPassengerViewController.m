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


@end

#define kTabBarHeight 0.0

@implementation GTPassengerViewController {
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
    [self registerForKeyboardNotifications];
    
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
    
//    AddressDetailsViewController *destination = (AddressDetailsViewController *)segue.destinationViewController;
//    destination.destinationViewController = self.destinationViewController;
//    destination.fallBackViewController = self.fallBackViewController;
//    destination.cartrawlerAPI = self.cartrawlerAPI;
//    destination.validationController = self.validationController;
//    destination.groundSearch = self.groundSearch;
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
    
    if ([self.flightNoTextField.text isEqualToString: @""] && self.groundSearch.selectedService != nil) {
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
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTextField) {
        return [self validatePhone:[NSString stringWithFormat:@"%@%@", self.phoneTextField.text, string]];
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
    [self done];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
