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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *paymentSummaryContainer;
@property (weak, nonatomic) IBOutlet UILabel *driverDetails;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *firstName;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *lastName;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailAddress;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *prefix;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneNumber;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *country;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *flightNumber;
@property (weak, nonatomic) IBOutlet UIView *paymentDetailsContainerView;
@property (weak, nonatomic) IBOutlet UILabel *securePayment;
@property (weak, nonatomic) IBOutlet UILabel *conditions;
@property (weak, nonatomic) IBOutlet UILabel *extrasReminder;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIBarButtonItem *cancelButton;
@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (nonatomic, weak) CTPaymentSummaryViewController  *paymentSummaryVC;
@property (weak, nonatomic) IBOutlet UIView *paymentSummaryContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *paymentSummaryHeight;
@end

@implementation CTBookingViewController

+ (Class)viewModelClass {
    return CTBookingViewModel.class;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Interface Builder won't allow adjusting of height with rounded rect selected
    self.firstName.borderStyle = UITextBorderStyleRoundedRect;
    self.lastName.borderStyle = UITextBorderStyleRoundedRect;
    self.emailAddress.borderStyle = UITextBorderStyleRoundedRect;
    self.prefix.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneNumber.borderStyle = UITextBorderStyleRoundedRect;
    self.country.borderStyle = UITextBorderStyleRoundedRect;
    self.flightNumber.borderStyle = UITextBorderStyleRoundedRect;
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.toolbar.barTintColor = [UIColor lightGrayColor];
    self.cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(didTapCancel:)];
    self.doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(didTapDone:)];
    UIBarButtonItem *space= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                          target:nil
                                                                          action:nil];
    [self.toolbar setItems:@[self.cancelButton, space, self.doneButton]];
    self.firstName.inputAccessoryView = self.toolbar;
    self.lastName.inputAccessoryView = self.toolbar;
    self.emailAddress.inputAccessoryView = self.toolbar;
    self.prefix.inputAccessoryView = self.toolbar;
    self.phoneNumber.inputAccessoryView = self.toolbar;
    self.flightNumber.inputAccessoryView = self.toolbar;
    
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
    
    [CTAppController dispatchAction:CTActionBookingPaymentContainerViewDidLoad payload:self.paymentDetailsContainerView];
}

- (void)updateWithViewModel:(CTBookingViewModel *)viewModel {
    // Force view to load
    self.view = self.view;
    
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
    self.country.text = viewModel.country;
    self.flightNumber.text = viewModel.flightNumber;
    
    switch (viewModel.selectedTextfield) {
        case CTBookingTextfieldNone:
            for (JVFloatLabeledTextField *textfield in @[self.firstName, self.lastName, self.emailAddress, self.prefix, self.phoneNumber, self.country, self.flightNumber]) {
                [textfield resignFirstResponder];
            }
            break;
        case CTBookingTextfieldFirstName:
            if (![self.firstName isFirstResponder]) {
                [self.firstName becomeFirstResponder];
            }
            break;
        case CTBookingTextfieldLastName:
            if (![self.lastName isFirstResponder]) {
                [self.lastName becomeFirstResponder];
            }
            break;
        case CTBookingTextfieldEmailAddress:
            if (![self.emailAddress isFirstResponder]) {
                [self.emailAddress becomeFirstResponder];
            }
            break;
        case CTBookingTextfieldPrefix:
            if (![self.prefix isFirstResponder]) {
                [self.prefix becomeFirstResponder];
            }
            break;
        case CTBookingTextfieldPhoneNumber:
            if (![self.phoneNumber isFirstResponder]) {
                [self.phoneNumber becomeFirstResponder];
            }
            break;
        case CTBookingTextfieldCountry:
            if (![self.country isFirstResponder]) {
                [self.country becomeFirstResponder];
            } else {
                [self.view endEditing:YES];
            }
            break;
        case CTBookingTextfieldFlightNumber:
            if (![self.flightNumber isFirstResponder]) {
                [self.flightNumber becomeFirstResponder];
            }
            break;
        case CTBookingTextfieldPayment:
            [self.scrollView setContentOffset:CGPointMake(0, self.securePayment.frame.origin.y - 24) animated:YES];
            break;
        default:
            break;
    }
    if (viewModel.keyboardHeight) {
        [self keyboardWasShown:viewModel.keyboardHeight.floatValue];
    }
    
    [self.paymentSummaryVC updateWithViewModel:viewModel.paymentSummaryViewModel];
    self.paymentSummaryHeight.constant = [self.paymentSummaryVC.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
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
    if (textField == self.country) {
        [CTAppController dispatchAction:CTActionBookingUserDidTapCountry payload:nil];
    }
    if (textField == self.flightNumber) {
        [CTAppController dispatchAction:CTActionBookingUserDidTapFlightNumber payload:nil];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    [CTAppController dispatchAction:CTActionBookingUserDidEndEditingTextfield payload:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [CTAppController dispatchAction:CTActionBookingUserDidEnterCharacters payload:text];
    return NO;
}

- (void)didTapCancel:(id)sender {
    [CTAppController dispatchAction:CTActionBookingInputViewUserDidSelectCancel payload:nil];
}

- (void)didTapDone:(id)sender {
    [CTAppController dispatchAction:CTActionBookingInputViewUserDidSelectDone payload:nil];
}

- (void)keyboardWasShown:(CGFloat)keyboardHeight {
    CGFloat buffer = 41;
    CGFloat inputViewHeight = keyboardHeight + self.toolbar.frame.size.height + buffer;
    
    for (UIView *view in self.contentView.subviews) {
        if (view.isFirstResponder) {
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            CGFloat screenHeight = screenRect.size.height;
            CGFloat visibleY = screenHeight - inputViewHeight;
                        
            if (view.frame.origin.y + view.frame.size.height > visibleY) {
                CGPoint scrollPoint = CGPointMake(0, view.frame.origin.y + view.frame.size.height - visibleY);
                [self.scrollView setContentOffset:scrollPoint animated:YES];
                return;
            }
        }
    }
}

- (NSArray *)paymentSubviews:(UIView *)view {
    if (view.subviews.count == 0) {
        return @[view];
    }
    NSMutableArray *views = [NSMutableArray new];
    for (UIView *subview in view.subviews) {
        [views addObjectsFromArray:[self paymentSubviews:subview]];
    }
    return views.copy;
}

- (IBAction)payButtonTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionBookingUserDidTapNext payload:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        [CTAppController dispatchAction:CTActionBookingUserDidTapBack payload:nil];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}

@end
