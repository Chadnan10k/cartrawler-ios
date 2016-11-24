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
#import "CartrawlerSDK+NSDateUtils.h"
#import "PaymentCompletionViewController.h"
#import "CTPaymentView.h"
#import "CTCheckbox.h"
#import "HTMLParser.h"
#import "CTAppearance.h"
#import "TermsViewController.h"
#import "CTNextButton.h"
#import "CTAppearance.h"
#import "DataStore.h"
#import "Reachability.h"
#import "CartrawlerSDK+NSNumber.h"
#import "CTPaymentLoadingViewController.h"

@interface PaymentViewController () <UITextViewDelegate, CTPaymentViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *webViewContainer;
@property (strong, nonatomic) CTPaymentView *paymentView;
@property (weak, nonatomic) IBOutlet UITextView *termsLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet CTNextButton *confirmButton;
@property (nonatomic) BOOL loadingViewVisible;

@property (nonatomic) Reachability *internetReachability;

@property (nonatomic, strong) UIAlertView *alertView;

@end

@implementation PaymentViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.backButton.enabled = YES;
    
    Reachability* curReach = self.internetReachability;
    NetworkStatus networkStatus = [curReach currentReachabilityStatus];
    switch (networkStatus) {
        case NotReachable:
            NSLog(@"no internet");
            [self presentAlertView:@"No Internet Connection"
                           message:@"In order to complete your booking you will need an internet connection"];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case ReachableViaWiFi:
            NSLog(@"has internet");
            break;
        case ReachableViaWWAN:
            NSLog(@"has internet");
            break;
        default:
            break;
    }
    
    _loadingViewVisible = NO;
}

- (void)refresh
{
    if (self.paymentView) {
        [self.paymentView setForCarRentalPayment:self.search];
    }
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
    
    __weak typeof(self) weakSelf = self;
    NSString *buttonText = [NSString stringWithFormat:@"Book now for %@", [self.search.selectedVehicle.vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode]];
    [self.confirmButton setText:buttonText didTap:^{
        [weakSelf confirmPayment];
    }];
    
    _paymentView = [[CTPaymentView alloc] initWithFrame:CGRectZero];
    self.paymentView.delegate = self;
    [self.paymentView presentInView:self.webViewContainer];
    [self.paymentView setForCarRentalPayment:self.search];//for initial load

    _internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    NSString *link1 = @"<a href='www.cartrawler.com'><b>Terms and conditions</b></a>";
    
    NSString *termsStr = [NSString stringWithFormat:@"Tap ‘Book now’ to complete your booking and accept our %@", link1];
    
    //seems lazy but efficient
    self.termsLabel.attributedText = [HTMLParser htmlStringWithFontFamily:[CTAppearance instance].fontName
                                                                pointSize:15.0
                                                                     text:termsStr
                                                            boldFontColor:@"#000000"
                                                                fontColor:@"#000000"];
    self.termsLabel.delegate = self;
    self.paymentView.backgroundColor = [UIColor whiteColor];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepThree" bundle:bundle];
    UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"TermsViewControllerNav"];
    TermsViewController *vc = (TermsViewController *)nav.topViewController;
    [vc setData:self.search cartrawlerAPI:self.cartrawlerAPI];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:nav animated:YES completion:nil];
    });
    return NO;
}
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)confirmPayment
{
    //[self enableControls:NO];
    [self.paymentView confirmPayment];
}

- (void)enableControls:(BOOL)enabled
{
    if (enabled) {
        self.backButton.enabled = YES;
        self.backButton.alpha = 1;
        self.confirmButton.userInteractionEnabled = YES;
        self.confirmButton.alpha = 1;
        self.termsLabel.userInteractionEnabled = YES;
    } else {
        self.backButton.enabled = NO;
        self.backButton.alpha = 0.8;
        self.confirmButton.userInteractionEnabled = NO;
        self.confirmButton.alpha = 0.8;
        self.termsLabel.userInteractionEnabled = NO;
    }
}

#pragma mark CTPaymentViewDelegate

- (void)paymentFailed
{
    if (self.loadingViewVisible) {
        [CTPaymentLoadingViewController dismiss];
        _loadingViewVisible = NO;
    }
    if (!self.loadingViewVisible) {
        [self enableControls:YES];
    }
}

- (void)willMakeBooking
{
    if (!self.loadingViewVisible) {
        [CTPaymentLoadingViewController present:self];
    }
    _loadingViewVisible = YES;
    [self enableControls:NO];
}

- (void)didLoadPaymentView
{

}

- (void)didFailLoadingPaymentView
{
    //retry
    if (!self.loadingViewVisible) {
        [self presentAlertView:@"Sorry"
                       message:@"We are having trouble loading the payment screen"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didMakeBooking
{
    [CTPaymentLoadingViewController dismiss];
    [self enableControls:YES];
    [self pushToDestination];
    if (self.delegate) {
        [self.delegate didBookVehicle:self.search.booking];
    }
}

#pragma mark Reachability

- (void)reachabilityChanged:(NSNotification *)not
{
    Reachability* curReach = [not object];
    NetworkStatus networkStatus = [curReach currentReachabilityStatus];
    switch (networkStatus) {
        case NotReachable:
            NSLog(@"retry webview load");
            //retry
            
            //also disallow the user to make payment as they are going to a dead end
            if (!self.loadingViewVisible) {
                [self presentAlertView:@"No Internet Connection"
                               message:@"In order to complete your booking you will need an internet connection"];
                
                [self.navigationController popViewControllerAnimated:YES];
            }

            break;
        case ReachableViaWiFi:
            //carry on
            [self.paymentView reload];
            [self dismissAlertView];
            [self enableControls:YES];
            break;
            
        case ReachableViaWWAN:
            //carry on
            [self.paymentView reload];
            [self dismissAlertView];
            [self enableControls:YES];
            break;
        default:
            break;
    }
}

#pragma mark UIAlertView

- (void)dismissAlertView
{
    if (self.alertView) {
        [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
    }
}

- (void)presentAlertView:(NSString *)title message:(NSString *)message
{
    if (self.alertView) {
        self.alertView.title = title;
        self.alertView.message = message;
    } else {
        _alertView = [[UIAlertView alloc] initWithTitle:title
                                                message:message
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil, nil];
    }
    [self.alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}

@end
