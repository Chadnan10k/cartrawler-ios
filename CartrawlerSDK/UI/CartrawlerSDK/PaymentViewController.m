//
//  PaymentViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentRequest.h"
#import "CTSDKSettings.h"
#import "NSDateUtils.h"
#import "PaymentCompletionViewController.h"
#import "Reachability.h"
#import "CTPaymentView.h"
#import "CTCheckbox.h"
#import "HTMLParser.h"
#import "CTAppearance.h"
#import "TermsViewController.h"
#import "CTButton.h"
#import "CTAppearance.h"

@interface PaymentViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *webViewContainer;
@property (strong, nonatomic) CTPaymentView *paymentView;
@property (weak, nonatomic) IBOutlet CTCheckbox *termsCheckbox;
@property (weak, nonatomic) IBOutlet UITextView *termsLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet CTButton *confirmButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *termsAndCondHeight;

@end

@implementation PaymentViewController

+(void)forceLinkerLoad_
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.paymentView setForCarRentalPayment:self.search];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _paymentView = [[CTPaymentView alloc] initWithFrame:CGRectZero];
    [self.paymentView presentInView:self.webViewContainer];
    
    __weak typeof (self) weakSelf = self;
    
    self.paymentView.completion = ^(BOOL success){
        [weakSelf enableControls:YES];
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf pushToDestination];
            });
        } else {
            
        }
    };
    self.termsCheckbox.viewTapped = ^(BOOL tapped){
        [weakSelf.paymentView termsAndConditionsChecked:tapped];
    };
    
    NSString *link1 = @"<a href='www.cartrawler.com'><b>Rental conditions</b></a>";
    
    NSString *termsStr = [NSString stringWithFormat:@"I agree to the %@<style>body {text-align: center;}</style>", link1];
    
    //seems lazy but efficient
    self.termsLabel.attributedText = [HTMLParser htmlStringWithFontFamily:[CTAppearance instance].fontName
                                                                pointSize:15.0
                                                                     text:termsStr
                                                            boldFontColor:@"#000000"];
    self.termsLabel.delegate = self;
    
//    CGSize textSize = [self.termsLabel.text
//                       sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:[CTAppearance instance].boldFontName size:15]}];
//    
//    self.termsAndCondHeight.constant = textSize.height;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSBundle* bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle]URLForResource:@"CartrawlerResources" withExtension:@"bundle"]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepThree" bundle:bundle];
    UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"TermsViewControllerNav"];
    TermsViewController *vc = (TermsViewController *)nav.topViewController;
    [vc setData:self.search cartrawlerAPI:self.cartrawlerAPI];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:nav animated:YES completion:nil];
    });
    return NO;
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)confirmPayment:(id)sender {
    [self enableControls:NO];
    [self.paymentView confirmPayment];
}

- (void)enableControls:(BOOL)enabled
{
    if (enabled) {
        self.backButton.enabled = YES;
        self.backButton.alpha = 1;
        self.confirmButton.enabled = YES;
        self.confirmButton.alpha = 1;
        self.termsLabel.userInteractionEnabled = YES;
        self.termsCheckbox.userInteractionEnabled = YES;
    } else {
        self.backButton.enabled = NO;
        self.backButton.alpha = 0.8;
        self.confirmButton.enabled = NO;
        self.confirmButton.alpha = 0.8;
        self.termsLabel.userInteractionEnabled = NO;
        self.termsCheckbox.userInteractionEnabled = NO;

    }
}

@end
