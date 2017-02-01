//
//  CTPaymentViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentViewController.h"
#import <CartrawlerSDK/CTPaymentRequest.h>
#import <CartrawlerSDK/CTSDKSettings.h>
#import <CartrawlerSDK/CartrawlerSDK+NSDateUtils.h>
#import "CTPaymentCompletionViewController.h"
#import <CartrawlerSDK/CTPaymentView.h>
#import <CartrawlerSDK/CTHTMLParser.h>
#import <CartrawlerSDK/CTAppearance.h>
#import "CTTermsViewController.h"
#import <CartrawlerSDK/CTNextButton.h>
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTDataStore.h>
#import <CartrawlerSDK/Reachability.h>
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import "CTPaymentLoadingViewController.h"
#import "CTRentalConstants.h"
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTPaymentViewController () <UITextViewDelegate, CTPaymentViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *webViewContainer;
@property (strong, nonatomic) CTPaymentView *paymentView;
@property (weak, nonatomic) IBOutlet UITextView *termsLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet CTNextButton *confirmButton;
@property (nonatomic) BOOL loadingViewVisible;

@property (nonatomic) Reachability *internetReachability;

@property (nonatomic, strong) UIAlertView *alertView;
@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;

@end

@implementation CTPaymentViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CTAnalytics instance] tagScreen:@"step" detail:@"payment" step:@8];

    double total = 0;
    
    if (self.search.isBuyingInsurance) {
        total += self.search.insurance.premiumAmount.doubleValue;
    }
    
    total += self.search.selectedVehicle.vehicle.totalPriceForThisVehicle.doubleValue;
    
    NSString *buttonText = [NSString stringWithFormat:@"%@ %@", CTLocalizedString(CTRentalCTABook), [@(total) numberStringWithCurrencyCode]];
    [self.confirmButton setText:buttonText];

    self.backButton.enabled = YES;
    
    Reachability* curReach = self.internetReachability;
    NetworkStatus networkStatus = [curReach currentReachabilityStatus];
    switch (networkStatus) {
        case NotReachable:
            NSLog(@"no internet");
            [self presentAlertView:CTLocalizedString(CTRentalErrorPaymentNoInternet1)
                           message:CTLocalizedString(CTRentalErrorPaymentNoInternet2)];
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
    
    _paymentView = [[CTPaymentView alloc] initWithFrame:CGRectZero];
    self.paymentView.delegate = self;
    [self.paymentView presentInView:self.webViewContainer];
    [self.paymentView setForCarRentalPayment:self.search];//for initial load
    
    self.titleLabel.text = CTLocalizedString(CTRentalTitlePayment);

    _internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    NSString *link1 = [NSString stringWithFormat:@"<a href='www.cartrawler.com'><b>%@</b></a>", CTLocalizedString(CTRentalPaymentText2)];
    
    NSString *termsStr = [NSString stringWithFormat:@"%@ %@", CTLocalizedString(CTRentalPaymentText1), link1];
    
    //seems lazy but efficient
    self.termsLabel.attributedText = [CTHTMLParser htmlStringWithFontFamily:[CTAppearance instance].fontName
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:CTRentalVehicleDetailsStoryboard bundle:bundle];
    UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"CTTermsViewControllerNav"];
    CTTermsViewController *vc = (CTTermsViewController *)nav.topViewController;
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

- (IBAction)confirmPayment:(id)sender
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
    [[CTAnalytics instance] tagError:@"step8" event:@"Payment webview load" message:@"failed"];
    //retry
    if (!self.loadingViewVisible) {
        [self presentAlertView:CTLocalizedString(CTRentalErrorPaymentLoading1)
                       message:CTLocalizedString(CTRentalErrorPaymentLoading2)];
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
                [self presentAlertView:CTLocalizedString(CTRentalErrorPaymentNoInternet1)
                               message:CTLocalizedString(CTRentalErrorPaymentNoInternet2)];
                
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
                                      cancelButtonTitle:CTLocalizedString(CTRentalErrorOk)
                                      otherButtonTitles:nil, nil];
    }
    [self.alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}

@end
