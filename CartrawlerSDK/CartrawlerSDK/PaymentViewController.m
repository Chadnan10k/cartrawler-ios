//
//  PaymentViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentViewController.h"
#import "JVFloatLabeledTextField.h"
#import "CTButton.h"
#import "NSNumberUtils.h"
#import "CompletionViewController.h"

@interface PaymentViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *cardHolderTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *cardMonthTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *cardYearTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *cardSecurityTextField;
@property (weak, nonatomic) IBOutlet CTButton *payButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation PaymentViewController

+(void)forceLinkerLoad_
{
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    double price = 0.0;
    
    if (self.isBuyingInsurance) {
        price+= self.insurance.premiumAmount.doubleValue;
    }
    price+= self.selectedVehicle.totalPriceForThisVehicle.doubleValue;
    
    [self.payButton setTitle:[NSString stringWithFormat:NSLocalizedString(@"Pay %@", @"Pay button"),
                              [NSNumberUtils numberStringWithCurrencyCode:[NSNumber numberWithDouble:price]]] forState:UIControlStateNormal];
    
    self.cardNumberTextField.delegate = self;
    self.cardHolderTextField.delegate = self;
    self.cardMonthTextField.delegate = self;
    self.cardYearTextField.delegate = self;
    self.cardSecurityTextField.delegate = self;
    
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

- (IBAction)confirm:(id)sender {
    
    CTPaymentCard *card = [[CTPaymentCard alloc] initWithCardType:CardTypeVisa
                                                       cardNumber:self.cardNumberTextField.text
                                                       cardExpiry:[NSString stringWithFormat:@"%@%@", self.cardMonthTextField.text, self.cardYearTextField.text]
                                                   cardHolderName:self.cardHolderTextField.text
                                                          cardCvc:self.cardSecurityTextField.text];
    
    [self makeBooking:card completion:^(BOOL success, NSString *errorMessage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CompletionViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CompletionViewController"];
            [vc presentInViewController:self];
        });
    }];
}

- (void)done
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //[self.summaryContainer closeIfOpen];
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
