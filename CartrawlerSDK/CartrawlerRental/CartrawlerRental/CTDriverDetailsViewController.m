//
//  CTDriverDetailsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTDriverDetailsViewController.h"
#import <CartrawlerSDK/CTTextField.h>
#import <CartrawlerSDK/CTButton.h>
#import "CTAddressDetailsViewController.h"
#import <CartrawlerSDK/CTFlightNumberValidation.h>
#import <CartrawlerSDK/CTNextButton.h>
#import <CartrawlerSDK/CartrawlerSDK+UITextField.h>
#import <CartrawlerSDK/CartrawlerSDK+UIView.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CTPayment/CTPayment.h>
#import "CartrawlerSDK/CTPaymentRequestGenerator.h"
#import "CartrawlerSDK/CTLayoutManager.h"
#import "CartrawlerSDK/CTAlertViewController.h"
#import "CTPaymentLoadingViewController.h"
#import "CTPaymentSummaryExpandedView.h"
#import "CTRentalConstants.h"
#import "CTTermsViewController.h"
#import "CartrawlerAPI/CTBooking.h"

@interface CTDriverDetailsViewController () <UITextFieldDelegate, CTPaymentDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet CTNextButton *nextButton;
@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet CTPaymentSummaryExpandedView *summaryView;
@property (strong, nonatomic) UIView *paymentContainer;
@property (strong, nonatomic) CTPayment *paymentView;
@property (strong, nonatomic) UIView *selectedView;

@property (strong, nonatomic) CTTextField *firstNameTextField;
@property (strong, nonatomic) CTTextField *lastNameTextField;
@property (strong, nonatomic) CTTextField *emailTextField;
@property (strong, nonatomic) CTTextField *phoneTextField;
@property (strong, nonatomic) CTTextField *flightNoTextField;

@property (strong, nonatomic) CTTextField *addressTextField;
@property (strong, nonatomic) CTTextField *address2TextField;
@property (strong, nonatomic) CTTextField *cityTextField;
@property (strong, nonatomic) CTTextField *postcodeTextField;

@property (weak, nonatomic) IBOutlet CTButton *summaryButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *dimmingView;

@end

@implementation CTDriverDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *viewTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasTapped)];
    [self.view addGestureRecognizer:viewTapped];
    
    self.titleLabel.text = CTLocalizedString(CTRentalTitleUser);
    [self.nextButton setText:CTLocalizedString(CTRentalCTAContinue)];
    [self createViews];
}

- (void)createViews
{
    _firstNameTextField = [CTTextField new];
    _lastNameTextField = [CTTextField new];
    _emailTextField = [CTTextField new];
    _phoneTextField = [CTTextField new];
    _flightNoTextField = [CTTextField new];
    _phoneTextField = [CTTextField new];
    
    _addressTextField = [CTTextField new];
    _address2TextField = [CTTextField new];
    _cityTextField = [CTTextField new];
    _postcodeTextField = [CTTextField new];
    _paymentContainer = [UIView new];
}

- (void)setupTextFields
{

    self.firstNameTextField.placeholder = CTLocalizedString(CTRentalUserFirstnameHint);
    self.lastNameTextField.placeholder = CTLocalizedString(CTRentalUserSurnameHint);
    self.emailTextField.placeholder = CTLocalizedString(CTRentalUserEmailHint);
    self.phoneTextField.placeholder = CTLocalizedString(CTRentalUserPhoneHint);
    self.flightNoTextField.placeholder = CTLocalizedString(CTRentalUserFlightHint);
    
    self.addressTextField.placeholder = CTLocalizedString(CTRentalUserAddressLine1Hint);
    self.address2TextField.placeholder = CTLocalizedString(CTRentalUserAddressLine2Hint);
    self.cityTextField.placeholder = CTLocalizedString(CTRentalUserCityHint);
    self.postcodeTextField.placeholder = CTLocalizedString(CTRentalUserPostcodeHint);
    
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.phoneTextField.delegate = self;
    self.flightNoTextField.delegate = self;
    
    self.addressTextField.delegate = self;
    self.address2TextField.delegate = self;
    self.cityTextField.delegate = self;
    self.postcodeTextField.delegate = self;

    [self.firstNameTextField addDoneButton];
    [self.lastNameTextField addDoneButton];
    [self.emailTextField addDoneButton];
    [self.phoneTextField addDoneButton];
    [self.flightNoTextField addDoneButton];
    [self.phoneTextField addDoneButton];
    
    [self.addressTextField addDoneButton];
    [self.address2TextField addDoneButton];
    [self.cityTextField addDoneButton];
    [self.postcodeTextField addDoneButton];
    
    _selectedView = self.firstNameTextField;
    

    CTLabel *driverDetailsTitle = [[CTLabel alloc] init:17
                                              textColor:[CTAppearance instance].buttonTextColor
                                          textAlignment:NSTextAlignmentLeft
                                               boldFont:YES];
    driverDetailsTitle.text = CTLocalizedString(CTRentalTitleUser);
    
    
    CTLabel *addressDetailsTitle = [[CTLabel alloc] init:17
                                              textColor:[CTAppearance instance].buttonTextColor
                                          textAlignment:NSTextAlignmentLeft
                                               boldFont:YES];
    addressDetailsTitle.text = CTLocalizedString(CTRentalAddressDetailsTitle);
    
    CTLabel *paymentDetailsTitle = [[CTLabel alloc] init:17
                                               textColor:[CTAppearance instance].buttonTextColor
                                           textAlignment:NSTextAlignmentLeft
                                                boldFont:YES];
    paymentDetailsTitle.text = CTLocalizedString(CTRentalTitlePayment);
    
    [self.firstNameTextField setHeightConstraint:@60 priority:@1000];
    [self.lastNameTextField setHeightConstraint:@60 priority:@1000];
    [self.emailTextField setHeightConstraint:@60 priority:@1000];
    [self.phoneTextField setHeightConstraint:@60 priority:@1000];
    [self.flightNoTextField setHeightConstraint:@60 priority:@1000];

    [self.addressTextField setHeightConstraint:@60 priority:@1000];
    [self.address2TextField setHeightConstraint:@60 priority:@1000];
    [self.cityTextField setHeightConstraint:@60 priority:@1000];
    [self.postcodeTextField setHeightConstraint:@60 priority:@1000];
    [self.paymentContainer setHeightConstraint:@220 priority:@1000];

    CTLayoutManager *layoutManager = [CTLayoutManager layoutManagerWithContainer:self.containerView];
    
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 0, 8) view:driverDetailsTitle];
    [layoutManager insertView:UIEdgeInsetsMake(0, 8, 8, 8) view:self.firstNameTextField];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.lastNameTextField];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.emailTextField];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.phoneTextField];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.flightNoTextField];

    if (self.search.isBuyingInsurance) {
        [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:addressDetailsTitle];
        [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.addressTextField];
        [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.address2TextField];
        [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.cityTextField];
        [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.postcodeTextField];
    }
    
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 0, 8) view:paymentDetailsTitle];
    [layoutManager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:self.paymentContainer];
    [layoutManager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:[self termsAndConditionsView]];

    [layoutManager layoutViews];
}

- (void)setupPaymentView
{
    CTPaymentAppearance *paymentAppearance = [CTPaymentAppearance new];
    _paymentView = [[CTPayment alloc] initWithContainerView:self.paymentContainer
                                                 language:[CTSDKSettings instance].languageCode
                                               appearance:paymentAppearance
                                                    debug:YES
                                                   active:NO];
    self.paymentView.delegate = self;
}

- (void)viewWasTapped
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *v in self.containerView.subviews) {
        [v removeFromSuperview];
    }
    
    [self setupTextFields];
    [self setupPaymentView];
    
    [self tagScreen];
    [self registerForKeyboardNotifications];
    
    _selectedView = self.firstNameTextField;
    
    self.firstNameTextField.text = self.search.firstName == nil ? @"" : self.search.firstName;
    self.lastNameTextField.text = self.search.surname == nil ? @"" : self.search.surname;
    self.emailTextField.text = self.search.email == nil ? @"" : self.search.email;
    self.phoneTextField.text = self.search.phone == nil ? @"" : self.search.phone;
    self.flightNoTextField.text = self.search.flightNumber == nil ? @"" : self.search.flightNumber;
    
    self.addressTextField.text = self.search.addressLine1 == nil ? @"" : self.search.addressLine1;
    self.address2TextField.text = self.search.addressLine2 == nil ? @"" : self.search.addressLine2;
    self.cityTextField.text = self.search.city == nil ? @"" : self.search.city;
    self.postcodeTextField.text = self.search.postcode == nil ? @"" : self.search.postcode;
    
    [self updateDetailedPriceSummary];
    
    NSAttributedString *priceString = [NSString attributedText:CTLocalizedString(CTRentalCarRentalTotal)
                                                     boldColor:[UIColor whiteColor]
                                                      boldSize:17
                                                   regularText:[self.search.selectedVehicle.vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode]
                                                  regularColor:[UIColor whiteColor]
                                                   regularSize:17
                                                      useSpace:YES];
    
    [self.summaryButton setAttributedTitle:priceString forState:UIControlStateNormal];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self.firstNameTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [self deregisterForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)validate
{
    self.search.firstName = self.firstNameTextField.text;
    self.search.surname = self.lastNameTextField.text;
    self.search.email = self.emailTextField.text;
    self.search.phone = self.phoneTextField.text;
    self.search.flightNumber = self.flightNoTextField.text;
    
    BOOL validated = YES;
    
    if ([self.firstNameTextField.text isEqualToString: @""] || [self.firstNameTextField containsOnlyWhitespace]) {
        [self.firstNameTextField shakeAnimation];
        validated = NO;
    }
    
    if ([self.lastNameTextField.text isEqualToString: @""] || [self.lastNameTextField containsOnlyWhitespace]) {
        [self.lastNameTextField shakeAnimation];
        validated = NO;
    }
    
    if ([self.emailTextField.text isEqualToString: @""] || ![self.emailTextField isValidEmail] || [self.emailTextField containsOnlyWhitespace]) {
        [self.emailTextField shakeAnimation];
        validated = NO;
    }
    
    if ([self.phoneTextField.text isEqualToString: @""] || [self.phoneTextField containsOnlyWhitespace]) {
        [self.phoneTextField shakeAnimation];
        validated = NO;
    }
    
    if (![self.flightNoTextField.text isEqualToString: @""] && ![CTFlightNumberValidation isValid:self.flightNoTextField.text]) {
        [self.flightNoTextField shakeAnimation];
        validated = NO;
    }
    
    if (!self.search.isBuyingInsurance) {
        return validated;
    }
    
    if ([self.addressTextField.text isEqualToString: @""] || [self.addressTextField containsOnlyWhitespace]) {
        [self.addressTextField shakeAnimation];
        validated = NO;
    }
    
    if ([self.cityTextField.text isEqualToString: @""] || [self.cityTextField containsOnlyWhitespace]) {
        [self.cityTextField shakeAnimation];
        validated = NO;
    }
    
    if ([self.postcodeTextField.text isEqualToString: @""] || [self.postcodeTextField containsOnlyWhitespace]) {
        [self.postcodeTextField shakeAnimation];
        validated = NO;
    }
    return validated;

}

- (IBAction)confirmDetails:(id)sender
{
    BOOL validated = [self validate];
    if (validated) {
        NSString *req = [CTPaymentRequestGenerator requestFromSearch:self.search];
        [self.paymentView makePaymentWithJSON:req];
        [CTPaymentLoadingViewController present:self];
    }
}

- (IBAction)openTotal:(id)sender
{
    [self showDetailedPriceSummary];
}

- (void)done
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _selectedView = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  
    switch (textField.tag) {
        case 0:
            if (self.firstNameTextField.text.length > 0 && ![self.firstNameTextField containsOnlyWhitespace]) {
                [self.lastNameTextField becomeFirstResponder];
            } else {
                [self.firstNameTextField shakeAnimation];
            }
            return NO;
            break;
        case 1:
            if (self.lastNameTextField.text.length > 0) {
                [self.emailTextField becomeFirstResponder];
            } else {
                [self.lastNameTextField shakeAnimation];
            }
            return NO;
            break;
        case 2:
            if (![self.emailTextField isValidEmail]) {
                [self.emailTextField shakeAnimation];
            } else {
                [self.phoneTextField becomeFirstResponder];
            }
            return NO;
            break;
        case 3:
            if (self.phoneTextField.text.length > 0) {
                [self.flightNoTextField becomeFirstResponder];
            } else {
                [self.phoneTextField shakeAnimation];
            }
            return NO;
            break;
        case 4:
            [self.view endEditing:YES];
            return YES;
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
    }
    
    if (textField == self.firstNameTextField || textField == self.lastNameTextField) {
        NSMutableCharacterSet *characterSet = [NSMutableCharacterSet alphanumericCharacterSet];
        [characterSet addCharactersInString:@" -'"];
        NSCharacterSet *blockedCharacterSet = [characterSet invertedSet];
        return ([string rangeOfCharacterFromSet:blockedCharacterSet].location == NSNotFound);
    }
    
    return YES;
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
    [self.navigationController popViewControllerAnimated:YES];
}

//MARK: Payment Summary

- (void)updateDetailedPriceSummary
{
    [self.summaryView updateWithSearch:self.search];
    self.summaryViewHeightConstraint.constant = self.summaryView.desiredHeight;
    self.summaryViewTopConstraint.constant = -self.summaryView.desiredHeight;
    [self.view layoutIfNeeded];
}

- (void)showDetailedPriceSummary
{
    [self updateDetailedPriceSummary];
    self.summaryViewTopConstraint.constant = 0;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.dimmingView.alpha = 0.3;
                         [self.view layoutIfNeeded];
                     }];
}

- (void)hideDetailedPriceSummary
{
    self.summaryViewTopConstraint.constant = -self.summaryView.desiredHeight;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.dimmingView.alpha = 0;
                         [self.view layoutIfNeeded];
                     }];
}

- (IBAction)didInteractWithDetailedPriceSummary:(UIGestureRecognizer *)gestureRecognizer {
    [self hideDetailedPriceSummary];
}

//MARK: Terms and conditions

- (UIView *)termsAndConditionsView
{
    UIView *view = [UIView new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    UITextView *textView = [UITextView new];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    textView.scrollEnabled = NO;
    textView.backgroundColor = [UIColor clearColor];
    textView.font = [UIFont fontWithName:[CTAppearance instance].fontName size:15];
    textView.editable = NO;
    textView.selectable = YES;
    textView.delegate = self;
    
    CTLabel *secureLabel = [[CTLabel alloc] init:17 textColor:[UIColor darkGrayColor] textAlignment:NSTextAlignmentCenter boldFont:YES];
    secureLabel.text = CTLocalizedString(CTRentalPaymentSecure);
    [secureLabel setHeightConstraint:@25 priority:@1000];
    
    CTLayoutManager *manager = [CTLayoutManager layoutManagerWithContainer:view];
    [manager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:textView];
    [manager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:secureLabel];
    [manager layoutViews];

    NSString *link1 = [NSString stringWithFormat:@"<a href='www.cartrawler.com'><b>%@</b></a>", CTLocalizedString(CTRentalPaymentText2)];
    NSString *termsStr = [NSString stringWithFormat:CTLocalizedString(CTRentalPaymentText1), link1];
    
    textView.attributedText = [CTHTMLParser htmlStringWithFontFamily:[CTAppearance instance].fontName
                                                                  pointSize:15.0
                                                                       text:termsStr
                                                              boldFontColor:@"#000000"
                                                                  fontColor:@"#000000"];
    [view setHeightConstraint:@100 priority:@100];
    
    return view;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:CTRentalVehicleDetailsStoryboard bundle:bundle];
    UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"CTTermsViewControllerNav"];
    CTTermsViewController *vc = (CTTermsViewController *)nav.topViewController;
    [vc setData:self.search cartrawlerAPI:self.cartrawlerAPI];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:nav animated:YES completion:nil];
    });
    return NO;
}

//MARK: Analytics

- (void)tagScreen
{
    [[CTAnalytics instance] tagScreen:@"step" detail:@"vehicles-d" step:@5];
    [self sendEvent:NO customParams:@{@"eventName" : @"Driver Details Step",
                                      @"stepName" : @"Step5",
                                      } eventName:@"Step of search" eventType:@"Step"];
}

//MARK: Payment

- (void)payment:(CTPayment *)payment didFailWithError:(NSError *)error
{
    [CTPaymentLoadingViewController dismiss];
    CTAlertViewController *alertView = [CTAlertViewController alertControllerWithTitle:CTLocalizedString(CTRentalErrorPaymentLoading1) message:error.localizedDescription];
    CTAlertAction *okAction = [CTAlertAction actionWithTitle:CTLocalizedString(CTRentalCTAClose) handler:^(CTAlertAction *action) {
        [alertView dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertView addAction:okAction];
    [self presentModalViewController:alertView];
}

- (void)payment:(CTPayment *)payment didSucceedWithResponse:(NSDictionary *)response
{
    [CTPaymentLoadingViewController dismiss];
    
    CTBooking *booking = [[CTBooking alloc] initFromVehReservationDictionary:response];
    self.search.booking = booking;
    
    CTRentalBooking *savedBooking = [[CTRentalBooking alloc] initFromSearch:self.search];
    savedBooking.bookingId = booking.confID;
    [CTDataStore storeRentalBooking:savedBooking];
    
    [self trackSale];
    if (self.delegate) {
        [self.delegate didBookVehicle:self.search.booking];
    }
    
    [self pushToDestination];
}


@end
