//
//  PaymentViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentRequest.h"
#import "CTSearch.h"
#import "CTSDKSettings.h"
#import "NSDateUtils.h"
#import "PaymentCompletionViewController.h"
#import "Reachability.h"

@interface PaymentViewController () <UIWebViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIAlertView *alertView;
@property (strong, nonatomic) Reachability *reachability;
@end

@implementation PaymentViewController
{
    BOOL hasLoaded;
    NSString *viewState;
}

+(void)forceLinkerLoad_
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.webView.delegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    
    [self registerForKeyboardNotifications];
    
    viewState = @"";
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *b = [NSBundle bundleWithPath:bundlePath];
    
    NSString *htmlFile = [b pathForResource:@"CTPCI" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    NSString *s = [PaymentRequest OTA_VehResRQ:[NSDateUtils stringFromDateWithFormat:[CTSearch instance].pickupDate
                                                                              format:@"yyyy-MM-dd'T'HH:mm:ss"]
                                returnDateTime:[NSDateUtils stringFromDateWithFormat:[CTSearch instance].dropoffDate
                                                                              format:@"yyyy-MM-dd'T'HH:mm:ss"]
                            pickupLocationCode:[CTSearch instance].pickupLocation.code
                           dropoffLocationCode:[CTSearch instance].dropoffLocation.code
                                   homeCountry:[CTSDKSettings instance].homeCountryCode
                                     driverAge:[CTSearch instance].driverAge.stringValue
                                 numPassengers:[CTSearch instance].passengerQty.stringValue
                                  flightNumber:[CTSearch instance].flightNumber
                                         refID:[CTSearch instance].selectedVehicle.refID
                                  refTimeStamp:[CTSearch instance].selectedVehicle.refTimeStamp
                                        refURL:[CTSearch instance].selectedVehicle.refURL
                                   extrasArray:[CTSearch instance].selectedVehicle.extraEquipment
                                     givenName:[CTSearch instance].firstName
                                       surName:[CTSearch instance].surname
                                  emailAddress:[CTSearch instance].email
                                       address:[CTSearch instance].addressLine1
                                   phoneNumber:[CTSearch instance].phone
                               insuranceObject:[CTSearch instance].insurance
                             isBuyingInsurance:[CTSearch instance].isBuyingInsurance
                                      clientID:[CTSDKSettings instance].clientId
                                        target:@"Test"
                                        locale:[CTSDKSettings instance].languageCode
                                      currency:[CTSDKSettings instance].currencyCode];
    
    NSString *escapedString = [s stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    escapedString = [escapedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    NSString *urlStr;
    
    if ([CTSDKSettings instance].isDebug) {
        urlStr = [NSString stringWithFormat:@"http://otatest.cartrawler.com:20002/cartrawlerpay/paymentform?type=OTA_VehResRQ&mobile=true&hideButton=true&msg=%@", escapedString];
    } else {
        urlStr = [NSString stringWithFormat:@"https://otasecure.cartrawler.com/cartrawlerpay/paymentform?type=OTA_VehResRQ&mobile=true&hideButton=true&msg=%@", escapedString];
    }
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"[URLPLACEHOLDER]" withString:urlStr];
    
    [self.webView loadHTMLString:htmlString baseURL: [b bundleURL]];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self deregisterForKeyboardNotifications];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _reachability = [Reachability reachabilityWithHostName:@"www.google.com"];

    [self.reachability startNotifier];
        
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];


    [self startTimer];
}

- (void)reachabilityChanged:(NSNotification *)notification {
    Reachability *reachability = [notification object];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {
        [self.timer invalidate];
        viewState = @"ConnectionError";
    }
    else if (remoteHostStatus == ReachableViaWiFi) {
        [self.timer invalidate];
        [self startTimer];
        viewState = @"";
    }
    else if (remoteHostStatus == ReachableViaWWAN) {
        [self.timer invalidate];
        [self startTimer];
        viewState = @"";
    }
}

- (void)startTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                              target:self
                                            selector:@selector(currentState)
                                            userInfo:nil
                                             repeats:YES];
}

  - (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    CGPoint top = CGPointMake(0, 0); 
    [self.webView.scrollView setContentOffset:top animated:YES];
}

- (void)keyboardWillShow:(NSNotification *)n
{
    
}


#pragma mark Web View

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

- (void)currentState
{
    if (![viewState isEqualToString:[self.webView stringByEvaluatingJavaScriptFromString:@"getCurrentState()"]]) {
        if ([viewState isEqualToString:@"PaymentError"] || [viewState isEqualToString:@"ConnectionError"]) {
            return;
        }
        viewState = [self.webView stringByEvaluatingJavaScriptFromString:@"getCurrentState()"];
    }
    
    if ([viewState isEqualToString:@"SendingPayment"]) {
        [self.timer invalidate];
        [self pushToDestination];
    }

}

- (void)showError:(NSString *)title message:(NSString *)message
{
    _alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [self.alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self startTimer];
}

- (IBAction)bookNow:(id)sender {
    
    if ([viewState isEqualToString:@"PaymentError"] || [viewState isEqualToString:@"ConnectionError"]) {
        [self.timer invalidate];
        [self showError:@"Payment error" message:@"Please try again"];
    } else {
        [self.webView stringByEvaluatingJavaScriptFromString:@"validateAndBook()"];
    }
}

@end
