//
//  DriverDetailsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "DriverDetailsViewController.h"
#import "JVFloatLabeledTextField.h"
#import "BookingSummaryButton.h"
#import "AddressDetailsViewController.h"

@interface DriverDetailsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *flightNoTextField;
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

- (IBAction)continue:(id)sender {
    //do some validation
    
    //send data with prepare for segue
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
    viewFrame.size.height += (keyboardSize.height + 45);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *)n
{
    
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.scrollView.frame;
    
    viewFrame.size.height -= (keyboardSize.height + 45);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
