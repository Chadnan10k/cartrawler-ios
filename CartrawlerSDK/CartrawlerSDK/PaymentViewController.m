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

@interface PaymentViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

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
    //self.webView.scrollView.scrollEnabled = NO;
    
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

    NSString *urlStr = [NSString stringWithFormat:@"http://external-dev.cartrawler.com:20002/cartrawlerpay/paymentform?type=OTA_VehResRQ&mobile=true&hideButton=true&msg=%@", escapedString];
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"[URLPLACEHOLDER]" withString:urlStr];
    
    [self.webView loadHTMLString:htmlString baseURL: [b bundleURL]];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:0.1f
                                     target:self
                                   selector:@selector(currentState)
                                   userInfo:nil
                                    repeats:YES];
    
}

  - (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
        viewState = [self.webView stringByEvaluatingJavaScriptFromString:@"getCurrentState()"];
        NSLog(@"WEBVIEW STATE: %@", viewState);
    }
    
    if ([viewState isEqualToString:@"SendingPayment"]) {
        
    }
}

- (IBAction)bookNow:(id)sender {

    [self.webView stringByEvaluatingJavaScriptFromString:@"validateAndBook()"];
}

@end
