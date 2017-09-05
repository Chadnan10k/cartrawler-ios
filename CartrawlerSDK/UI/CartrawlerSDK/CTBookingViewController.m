//
//  CTBookingViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 14/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTBookingViewController.h"
#import "CTBookingViewModel.h"
#import "JVFloatLabeledTextField.h"
#import "CTAppController.h"
#import "CTPaymentSummaryViewController.h"

@interface CTBookingViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *navigationBar;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *paymentSummaryContainer;
@property (weak, nonatomic) IBOutlet UILabel *driverDetails;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *firstName;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *lastName;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailAddress;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *prefix;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneNumber;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *flightNumber;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *addressLine1;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *addressLine2;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *city;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *postcode;
@property (weak, nonatomic) IBOutlet UIView *addressDetailsContainer;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *country;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressDetailsHeight;

@property (weak, nonatomic) IBOutlet UIView *paymentDetailsContainerView;
@property (weak, nonatomic) IBOutlet UILabel *securePayment;
@property (weak, nonatomic) IBOutlet UIView *paymentContainer;
@property (weak, nonatomic) IBOutlet UILabel *conditions;
@property (weak, nonatomic) IBOutlet UILabel *extrasReminder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *extrasReminderHeight;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIBarButtonItem *cancelButton;
@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (nonatomic, weak) CTPaymentSummaryViewController  *paymentSummaryVC;
@property (weak, nonatomic) IBOutlet UIView *paymentSummaryContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *paymentSummaryHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardSpacer;
@end

@implementation CTBookingViewController

+ (Class)viewModelClass {
    return CTBookingViewModel.class;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(didTapCancel:)];
    self.doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(didTapDone:)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:nil
                                                                           action:nil];
    [self.toolbar setItems:@[self.cancelButton, space]];
    
    // Interface Builder won't allow adjusting of height with rounded rect selected
    for (UITextField *textfield in @[self.firstName, self.lastName, self.emailAddress, self.prefix, self.phoneNumber, self.flightNumber, self.addressLine1, self.addressLine2, self.city, self.postcode, self.country]) {
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        textfield.inputAccessoryView = self.toolbar;
    }
    
    self.addressDetailsHeight.constant = 0;
    self.keyboardSpacer.constant = 0;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PaymentSummary" bundle:[NSBundle bundleForClass:self.class]];
    self.paymentSummaryVC = [storyboard instantiateViewControllerWithIdentifier:@"CTPaymentSummaryViewController"];
    [self addChildViewController:self.paymentSummaryVC];
    self.paymentSummaryVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.paymentSummaryContainer addSubview:self.paymentSummaryVC.view];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.paymentSummaryVC.view.leadingAnchor constraintEqualToAnchor:self.paymentSummaryContainer.leadingAnchor],
                                              [self.paymentSummaryVC.view.trailingAnchor constraintEqualToAnchor:self.paymentSummaryContainer.trailingAnchor],
                                              [self.paymentSummaryVC.view.topAnchor constraintEqualToAnchor:self.paymentSummaryContainer.topAnchor],
                                              [self.paymentSummaryVC.view.bottomAnchor constraintEqualToAnchor:self.paymentSummaryContainer.bottomAnchor]
                                              ]
     ];
    
    [self.paymentSummaryVC didMoveToParentViewController:self];
    
    [CTAppController dispatchAction:CTActionBookingPaymentContainerViewDidLoad payload:self.paymentContainer];
}

- (void)updateWithViewModel:(CTBookingViewModel *)viewModel {
    // Force view to load
    self.view = self.view;
    
    self.navigationBar.backgroundColor = viewModel.navigationBarColor;
    self.totalAmount.text = viewModel.totalAmount;
    
    self.firstName.placeholder = viewModel.firstNamePlaceholder;
    self.lastName.placeholder = viewModel.lastNamePlaceholder;
    self.emailAddress.placeholder = viewModel.emailAddressPlaceholder;
    self.prefix.placeholder = viewModel.prefixPlaceholder;
    self.phoneNumber.placeholder = viewModel.phoneNumberPlaceholder;
    self.country.placeholder = viewModel.countryPlaceholder;
    self.flightNumber.placeholder = viewModel.flightNumberPlaceholder;
    
    self.firstName.text = viewModel.firstName;
    self.lastName.text = viewModel.lastName;
    self.emailAddress.text = viewModel.emailAddress;
    self.prefix.text = viewModel.prefix;
    self.phoneNumber.text = viewModel.phoneNumber;
    self.flightNumber.text = viewModel.flightNumber;
    self.addressLine1.text = viewModel.addressLine1;
    self.addressLine2.text = viewModel.addressLine2;
    self.city.text = viewModel.city;
    self.postcode.text = viewModel.postcode;
    self.country.text = viewModel.country;
    
    if (viewModel.showAddressDetails) {
        // TODO: Extract constant
        self.addressDetailsHeight.constant = 377;
    }
    UIView *selectedView;
    
    // If keyboard update, but there are no first responders, must be payment
    BOOL textfieldSelected = NO;
    CGFloat scrollAdjustment = 0.0;
    NSArray *driverDetailsTextfields = @[self.firstName, self.lastName, self.emailAddress, self.prefix, self.phoneNumber, self.flightNumber];
    for (UITextField *textfield in driverDetailsTextfields) {
        if ([textfield isFirstResponder]) {
            textfieldSelected = YES;
            scrollAdjustment = 0;
        }
    }
    NSArray *addressDetailsTextfields = @[self.addressLine1, self.addressLine2, self.city, self.postcode, self.country];
    for (UITextField *textfield in addressDetailsTextfields) {
        if ([textfield isFirstResponder]) {
            textfieldSelected = YES;
            scrollAdjustment = self.addressDetailsContainer.frame.origin.y;
        }
    }
    CTBookingTextfield selectedTextfield = viewModel.selectedTextfield;
    if (viewModel.keyboardHeight && !textfieldSelected) {
        selectedTextfield = CTBookingTextfieldPayment;
    }
    
    switch (selectedTextfield) {
        case CTBookingTextfieldNone:
            if (selectedView != self.paymentDetailsContainerView) {
                [self.view endEditing:YES];
            }
            break;
        case CTBookingTextfieldFirstName:
            selectedView = self.firstName;
            break;
        case CTBookingTextfieldLastName:
            selectedView = self.lastName;
            break;
        case CTBookingTextfieldEmailAddress:
            selectedView = self.emailAddress;
            break;
        case CTBookingTextfieldPrefix:
            selectedView = self.prefix;
            break;
        case CTBookingTextfieldPhoneNumber:
            selectedView = self.phoneNumber;
            break;
        case CTBookingTextfieldFlightNumber:
            selectedView = self.flightNumber;
            break;
        case CTBookingTextfieldAddressLine1:
            selectedView = self.addressLine1;
            break;
        case CTBookingTextfieldAddressLine2:
            selectedView = self.addressLine2;
            break;
        case CTBookingTextfieldCity:
            selectedView = self.city;
            break;
        case CTBookingTextfieldPostcode:
            selectedView = self.postcode;
            break;
        case CTBookingTextfieldCountry:
            selectedView = self.country;
            [self.view endEditing:YES];
            break;
        case CTBookingTextfieldPayment:
            selectedView = self.paymentDetailsContainerView;
            break;
        default:
            break;
    }
   
    self.keyboardSpacer.constant = viewModel.keyboardHeight ? viewModel.keyboardHeight.floatValue : 0;

//    if (selectedTextfield != CTBookingTextfieldNone && selectedTextfield != CTBookingTextfieldPayment) {
//        if (![selectedView isFirstResponder]) {
//            [selectedView becomeFirstResponder];
//        }
//    }

    if (selectedView) {
        CGFloat padding = 8;
        CGFloat adjustedHeight = selectedView.frame.origin.y + scrollAdjustment - padding;
        CGPoint scrollPoint = CGPointMake(0, adjustedHeight);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    
    if (viewModel.shakeAnimations) {
        [self shakeAnimations:viewModel];
        [CTAppController dispatchAction:CTActionBookingValidationAnimationFinished payload:nil];
    }
    
    self.extrasReminder.text = viewModel.extrasReminder;
    self.extrasReminderHeight.active = self.extrasReminder.text == nil;
    self.payButton.backgroundColor = viewModel.buttonColor;
    [self.paymentSummaryVC updateWithViewModel:viewModel.paymentSummaryViewModel];
    self.paymentSummaryHeight.constant = [self.paymentSummaryVC.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
}

- (void)shakeAnimations:(CTBookingViewModel *)viewModel {
    if (viewModel.shakeFirstName) {
        [self.firstName shakeAnimation];
    }
    if (viewModel.shakeLastName) {
        [self.lastName shakeAnimation];
    }
    if (viewModel.shakeEmailAddress) {
        [self.emailAddress shakeAnimation];
    }
    if (viewModel.shakePrefix) {
        [self.prefix shakeAnimation];
    }
    if (viewModel.shakePhoneNumber) {
        [self.phoneNumber shakeAnimation];
    }
    if (viewModel.shakeFlightNumber) {
        [self.flightNumber shakeAnimation];
    }
    if (viewModel.shakeAddressLine1) {
        [self.addressLine1 shakeAnimation];
    }
    if (viewModel.shakeAddressLine2) {
        [self.addressLine2 shakeAnimation];
    }
    if (viewModel.shakeCity) {
        [self.city shakeAnimation];
    }
    if (viewModel.shakePostcode) {
        [self.postcode shakeAnimation];
    }
    if (viewModel.shakeCountry) {
        [self.country shakeAnimation];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isFirstResponder]) {
        return YES;
    }
    if (textField == self.firstName) {
        [CTAppController dispatchAction:CTActionBookingUserDidTapFirstName payload:nil];
    }
    if (textField == self.lastName) {
        [CTAppController dispatchAction:CTActionBookingUserDidTapLastName payload:nil];
    }
    if (textField == self.emailAddress) {
        [CTAppController dispatchAction:CTActionBookingUserDidTapEmailAddress payload:nil];
    }
    if (textField == self.prefix) {
        [CTAppController dispatchAction:CTActionBookingUserDidTapPrefix payload:nil];
    }
    if (textField == self.phoneNumber) {
        [CTAppController dispatchAction:CTActionBookingUserDidTapPhoneNumber payload:nil];
    }
    if (textField == self.flightNumber) {
        [CTAppController dispatchAction:CTActionBookingUserDidTapFlightNumber payload:nil];
    }
    if (textField == self.addressLine1) {
        [CTAppController dispatchAction:CTActionBookingUserDidTapAddressLine1 payload:nil];
    }
    if (textField == self.addressLine2) {
        [CTAppController dispatchAction:CTActionBookingUserDidTapAddressLine2 payload:nil];
    }
    if (textField == self.city) {
        [CTAppController dispatchAction:CTActionBookingUserDidTapCity payload:nil];
    }
    if (textField == self.postcode) {
        [CTAppController dispatchAction:CTActionBookingUserDidTapPostcode payload:nil];
    }
    if (textField == self.country) {
        [CTAppController dispatchAction:CTActionBookingUserDidTapCountry payload:nil];
        return NO;
    }
    return YES;
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    if (textField == self.firstName) {
//        [CTAppController dispatchAction:CTActionBookingUserDidTapFirstName payload:nil];
//    }
//    if (textField == self.lastName) {
//        [CTAppController dispatchAction:CTActionBookingUserDidTapLastName payload:nil];
//    }
//    if (textField == self.emailAddress) {
//        [CTAppController dispatchAction:CTActionBookingUserDidTapEmailAddress payload:nil];
//    }
//    if (textField == self.prefix) {
//        [CTAppController dispatchAction:CTActionBookingUserDidTapPrefix payload:nil];
//    }
//    if (textField == self.phoneNumber) {
//        [CTAppController dispatchAction:CTActionBookingUserDidTapPhoneNumber payload:nil];
//    }
//    if (textField == self.flightNumber) {
//        [CTAppController dispatchAction:CTActionBookingUserDidTapFlightNumber payload:nil];
//    }
//    if (textField == self.addressLine1) {
//        [CTAppController dispatchAction:CTActionBookingUserDidTapAddressLine1 payload:nil];
//    }
//    if (textField == self.addressLine2) {
//        [CTAppController dispatchAction:CTActionBookingUserDidTapAddressLine2 payload:nil];
//    }
//    if (textField == self.city) {
//        [CTAppController dispatchAction:CTActionBookingUserDidTapCity payload:nil];
//    }
//    if (textField == self.postcode) {
//        [CTAppController dispatchAction:CTActionBookingUserDidTapPostcode payload:nil];
//    }
//    if (textField == self.country) {
//        [CTAppController dispatchAction:CTActionBookingUserDidTapCountry payload:nil];
//    }
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [CTAppController dispatchAction:CTActionBookingUserDidEnterCharacters payload:text];
    return NO;
}

- (void)didTapCancel:(id)sender {
    [CTAppController dispatchAction:CTActionBookingInputViewUserDidSelectCancel payload:nil];
}

- (IBAction)totalButtonTapped:(id)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Coming Soon" message:@"This feature is under construction" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    [controller addAction:okAction];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)didTapDone:(id)sender {
    [CTAppController dispatchAction:CTActionBookingInputViewUserDidSelectDone payload:nil];
}

- (IBAction)backButtonTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionBookingUserDidTapBack payload:nil];
}

- (IBAction)payButtonTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionBookingUserDidTapNext payload:nil];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}

@end
