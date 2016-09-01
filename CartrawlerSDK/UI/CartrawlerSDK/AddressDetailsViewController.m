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
    NSDictionary* userInfo = n.userInfo;
    
    // get the size of the keyboard
    CGSize keyboardSize = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height - kTabBarHeight);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    (self.scrollView).frame = viewFrame;
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = n.userInfo;
    
    // get the size of the keyboard
    CGSize keyboardSize = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
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
