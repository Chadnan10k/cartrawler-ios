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
#import "CTNextButton.h"
#import "CartrawlerSDK+UITextField.h"
#import "CTSDKSettings.h"

@interface AddressDetailsViewController () <UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet CTTextField *addressLine1TextField;
@property (weak, nonatomic) IBOutlet CTTextField *addressLine2TextField;
@property (weak, nonatomic) IBOutlet CTTextField *cityTextField;
@property (weak, nonatomic) IBOutlet CTTextField *postCodeTextField;
@property (weak, nonatomic) IBOutlet CTTextField *countryTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet CTNextButton *nextButton;
@property (strong, nonatomic) CSVItem *selectedCountryItem;
@property (strong, nonatomic) UIView *selectedView;

@end

#define kTabBarHeight 0.0

@implementation AddressDetailsViewController {
    BOOL keyboardIsShown;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    [self.nextButton setText:NSLocalizedString(@"Continue", @"Continue") didTap:^{
        [weakSelf continueToPayment];
    }];
    self.addressLine1TextField.delegate = self;
    self.addressLine2TextField.delegate = self;
    self.cityTextField.delegate = self;
    self.postCodeTextField.delegate = self;
    self.countryTextField.delegate = self;
    
    _selectedView = self.addressLine1TextField;

    UITapGestureRecognizer *viewTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasTapped)];
    [self.view addGestureRecognizer:viewTapped];
    
    [self.addressLine1TextField addDoneButton];
    [self.addressLine2TextField addDoneButton];
    [self.cityTextField addDoneButton];
    [self.postCodeTextField addDoneButton];
    [self.countryTextField addDoneButton];

}

- (void)viewWasTapped
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
    [self.addressLine1TextField becomeFirstResponder];
    _selectedView = self.addressLine1TextField;

    if (self.search) {
        if (!self.search.addressLine1) {
            self.addressLine1TextField.text = @"";
        } else {
            self.addressLine1TextField.text = self.search.addressLine1;
        }
        
        if (!self.search.addressLine2) {
            self.addressLine2TextField.text = @"";
        } else {
            self.addressLine2TextField.text = self.search.addressLine2;
        }
        
        if (!self.search.city) {
            self.cityTextField.text = @"";
        } else {
            self.cityTextField.text = self.search.city;
        }
        
        if (!self.search.postcode) {
            self.postCodeTextField.text = @"";
        } else {
            self.postCodeTextField.text = self.search.postcode;
        }
        
        self.countryTextField.text = [CTSDKSettings instance].homeCountryName;
        self.search.country = [CTSDKSettings instance].homeCountryCode;

    }
    
    if (self.groundSearch) {
        if (!self.groundSearch.addressLine1) {
            self.addressLine1TextField.text = @"";
        }
        
        if (!self.groundSearch.addressLine2) {
            self.addressLine2TextField.text = @"";
        }
        
        if (!self.groundSearch.city) {
            self.cityTextField.text = @"";
        }
        
        if (!self.groundSearch.postcode) {
            self.postCodeTextField.text = @"";
        }
        
        if (!self.groundSearch.country) {
            self.countryTextField.text = @"";
        }
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

- (void)continueToPayment
{
    
    BOOL validated = YES;
    
    if ([self.addressLine1TextField.text isEqualToString: @""]) {
        [self.addressLine1TextField shakeAnimation];
        validated = NO;
    }
    
    if ([self.cityTextField.text isEqualToString: @""]) {
        [self.cityTextField shakeAnimation];
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
        
        self.groundSearch.addressLine1 = self.addressLine1TextField.text;
        self.groundSearch.addressLine2 = self.addressLine2TextField.text;
        self.groundSearch.city = self.cityTextField.text;
        self.groundSearch.postcode = self.postCodeTextField.text;
        self.groundSearch.country = self.countryTextField.text;
                
        [self pushToDestination];
    }
}

- (void)done
{
    [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [characterSet addCharactersInString:@" "];
    
    if ([[NSString stringWithFormat:@"%@%@", textField.text, string] rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _selectedView = textField;
    if (textField == self.countryTextField) {
        [self openCountrySelection];
        return NO;
    }
    return YES;
}

- (void)openCountrySelection
{
    [self.view endEditing:YES];
    
    UIStoryboard *settingsStoryboard = [UIStoryboard storyboardWithName:@"StepOne" bundle:[NSBundle bundleForClass:self.class]];
    SettingsSelectionViewController *vc = [settingsStoryboard instantiateViewControllerWithIdentifier:@"SettingsSelectionViewController"];
    [vc setSettingsType:SettingsTypeCountry];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
    
    __weak typeof (self) weakSelf = self;
    
    vc.settingsCompletion = ^(CSVItem *item) {
        if (![item.code isEqualToString:[CTSDKSettings instance].homeCountryCode]) {
            [weakSelf presentAlert:@"Warning" message:@"Changing your country of residence can affect the price and availability of your selected car. You will be redirected to the Results page, where your search will be updated."];
            weakSelf.selectedCountryItem = item;
        }
    };
}

- (void)presentAlert:(NSString *)title message:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"Continue booking"
                                              otherButtonTitles:@"Refresh search",
                              nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && self.selectedCountryItem) {
        [[CTSDKSettings instance] setHomeCountryCode:self.selectedCountryItem.code];
        [[CTSDKSettings instance] setHomeCountryName:self.selectedCountryItem.name];
        self.search.country = self.selectedCountryItem.name;
        [self popToSearchViewController];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    switch (textField.tag) {
        case 0:
            [self.addressLine2TextField becomeFirstResponder];
            return NO;
            break;
        case 1:
            [self.cityTextField becomeFirstResponder];
            return NO;
            break;
        case 2:
            [self.postCodeTextField becomeFirstResponder];
            return NO;
            break;
        case 3:
            [self openCountrySelection];
            return NO;
            break;
        case 4:
            [self.view resignFirstResponder];
            [self.view endEditing:YES];
            return YES;
            break;
        default:
            [self.view endEditing:YES];
            return YES;
            break;
    }
    
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
