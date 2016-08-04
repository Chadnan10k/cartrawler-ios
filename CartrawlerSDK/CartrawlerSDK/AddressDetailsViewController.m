//
//  AddressDetailsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "AddressDetailsViewController.h"
#import "CTTextField.h"
#import "BookingSummaryButton.h"
#import "SettingsSelectionViewController.h"
#import "CTImageCache.h"

@interface AddressDetailsViewController () <UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet CTTextField *addressLine1TextField;
@property (weak, nonatomic) IBOutlet CTTextField *addressLine2TextField;
@property (weak, nonatomic) IBOutlet CTTextField *cityTextField;
@property (weak, nonatomic) IBOutlet CTTextField *postCodeTextField;
@property (weak, nonatomic) IBOutlet CTTextField *countryTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet BookingSummaryButton *summaryContainer;

@end

@implementation AddressDetailsViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addressLine1TextField.delegate = self;
    self.addressLine2TextField.delegate = self;
    self.cityTextField.delegate = self;
    self.postCodeTextField.delegate = self;
    self.countryTextField.delegate = self;

}

- (void)viewWillAppear:(BOOL)animated
{
    [self.summaryContainer closeIfOpen];
    [self.summaryContainer setDataWithVehicle:self.search.selectedVehicle
                                   pickupDate:self.search.pickupDate
                                  dropoffDate:self.search.dropoffDate
                            isBuyingInsurance:self.search.isBuyingInsurance];
    
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

- (IBAction)continueToPayment:(id)sender
{
    //do some validation
    
    BOOL validated = YES;
    
    if ([self.addressLine1TextField.text isEqualToString: @""]) {
        [self.addressLine1TextField shakeAnimation];
        validated = NO;
    }
    
    if ([self.cityTextField.text isEqualToString: @""]) {
        [self.cityTextField shakeAnimation];
        validated = NO;
    }
    
    if ([self.postCodeTextField.text isEqualToString: @""]) {
        [self.postCodeTextField shakeAnimation];
        validated = NO;
    }
    
    if ([self.countryTextField.text isEqualToString: @""]) {
        [self.countryTextField shakeAnimation];
        validated = NO;
    }
    
    if (validated) {
        
        self.search.addressLine1 = self.addressLine1TextField.text;
        self.search.addressLine2 = self.addressLine2TextField.text;
        self.search.city = self.cityTextField.text;
        self.search.postcode = self.postCodeTextField.text;
        self.search.country = self.countryTextField.text;
        [self pushToDestination];
    }
    
}

- (void)done
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.countryTextField) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *settingsStoryboard = [UIStoryboard storyboardWithName:@"StepOne" bundle:b];
        SettingsSelectionViewController *vc = [settingsStoryboard instantiateViewControllerWithIdentifier:@"SettingsSelectionViewController"];
        [vc setSettingsType:SettingsTypeCountry];
        
        [self presentViewController:vc animated:YES completion:nil];
        
        __weak typeof (self) weakSelf = self;
        
        vc.settingsCompletion = ^(CSVItem *item){
            self.countryTextField.text = item.name;
            weakSelf.search.country = item.name;
        };
        return NO;
    }

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

- (void)pushToDestination
{
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"End of CTSDK demo"
                                                        message:@"🚗"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[CTImageCache sharedInstance] removeAllObjects];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
