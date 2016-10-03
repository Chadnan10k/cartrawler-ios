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

@property (strong, nonatomic) UIView *selectedView;

@end

#define kTabBarHeight 0.0

@implementation AddressDetailsViewController {
    BOOL keyboardIsShown;
}

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
    
    _selectedView = self.addressLine1TextField;

}

- (void)viewWillAppear:(BOOL)animated
{
    [self.summaryContainer closeIfOpen];
    [self.summaryContainer setDataWithVehicle:self.search.selectedVehicle
                                   pickupDate:self.search.pickupDate
                                  dropoffDate:self.search.dropoffDate
                            isBuyingInsurance:self.search.isBuyingInsurance];
    
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
        
        if (!self.search.country) {
            self.countryTextField.text = @"";
        } else {
            self.countryTextField.text = self.search.country;
        }
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
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *b = [NSBundle bundleWithPath:bundlePath];
    UIStoryboard *settingsStoryboard = [UIStoryboard storyboardWithName:@"StepOne" bundle:b];
    SettingsSelectionViewController *vc = [settingsStoryboard instantiateViewControllerWithIdentifier:@"SettingsSelectionViewController"];
    [vc setSettingsType:SettingsTypeCountry];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
    
    __weak typeof (self) weakSelf = self;
    
    vc.settingsCompletion = ^(CSVItem *item){
        self.countryTextField.text = item.name;
        weakSelf.search.country = item.name;
        weakSelf.groundSearch.country = item.name;
        weakSelf.groundSearch.countryCode = item.code;
    };
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
