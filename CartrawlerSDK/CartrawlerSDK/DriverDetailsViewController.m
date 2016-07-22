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

@implementation DriverDetailsViewController

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
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.phoneTextField.inputAccessoryView = keyboardDoneButtonView;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.summaryContainer closeIfOpen];
    [self.summaryContainer setDataWithVehicle:self.selectedVehicle
                                   pickupDate:self.pickupDate
                                  dropoffDate:self.dropoffDate
                            isBuyingInsurance:self.isBuyingInsurance];
    
    [self registerForKeyboardNotifications];
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
    AddressDetailsViewController *vc = segue.destinationViewController;

    self.firstName = self.firstNameTextField.text;
    self.surname = self.lastNameTextField.text;
    self.email = self.emailTextField.text;
    self.phone = self.phoneTextField.text;
    self.flightNumber = self.flightNoTextField.text;
    
    vc.stepSevenViewController = self.stepSevenViewController;
    vc.cartrawlerAPI = self.cartrawlerAPI;
    vc.selectedVehicle = self.selectedVehicle;
    vc.pickupLocation = self.pickupLocation;
    vc.dropoffLocation = self.dropoffLocation;
    vc.pickupDate = self.pickupDate;
    vc.dropoffDate = self.dropoffDate;
    vc.driverAge = self.driverAge;
    vc.passengerQty = self.passengerQty;
    vc.insurance = self.insurance;
    vc.isBuyingInsurance = self.isBuyingInsurance;
    vc.extras = self.extras;
    vc.firstName = self.firstName;
    vc.surname = self.surname;
    vc.email = self.email;
    vc.phone = self.phone;
    vc.flightNumber = self.flightNumber;
//    vc.addressLine1 = self.addressLine1;
//    vc.addressLine2 = self.addressLine2;
//    vc.city = self.city;
//    vc.postcode = self.postcode;
//    vc.country = self.country;

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
    NSLog(@"%@", [NSString stringWithFormat:@"%@%@", self.phoneTextField.text, string]);
    NSLog(@"%d", [self validatePhone:[NSString stringWithFormat:@"%@%@", self.phoneTextField.text, string]]);
    
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
    NSDictionary* userInfo = [n userInfo];
    
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect viewFrame = self.scrollView.frame;
    viewFrame.size.height += (keyboardSize.height);
    
    [self.scrollView scrollRectToVisible:viewFrame animated:YES];
}

- (void)keyboardWillShow:(NSNotification *)n
{
    
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.scrollView.frame;
    
    viewFrame.size.height -= (keyboardSize.height);
    
    [self.scrollView scrollRectToVisible:viewFrame animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
