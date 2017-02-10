//
//  CTPaymentView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentView.h"
#import "CTPaymentRequest.h"
#import "CTSDKSettings.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CTButton.h"
#import "GTPaymentRequest.h"
#import "CTDataStore.h"
#import "Reachability.h"
#import <WebKit/WebKit.h>
#import "CartrawlerSDK+WKWebView.h"
#import "CTAnalytics.h"

@interface CTPaymentView() <UIAlertViewDelegate, NSURLConnectionDataDelegate, WKScriptMessageHandler, WKNavigationDelegate>

typedef NS_ENUM(NSUInteger, CTPaymentType) {
    CTPaymentTypeCarRental = 0,
    CTPaymentTypeGroundTransport,
};

@property (nonatomic, strong) WKWebView *webView;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIAlertView *alertView;
@property (strong, nonatomic) NSString *htmlString;
@property (strong, nonatomic) NSBundle *bundle;
@property (strong, nonatomic) NSString *jsonResponse;

@property (nonatomic) CTPaymentType paymentType;

@property (nonatomic, copy) CTRentalSearch *carRentalSearch;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic) BOOL iframeLoaded;

@end

@implementation CTPaymentView

- (void)presentInView:(UIView *)parentView
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *htmlFile = [self.bundle pathForResource:@"CTPCI" ofType:@"html"];
    _htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    [wkWebConfig.userContentController addScriptMessageHandler:self name:@"CTWebView"];
    
    _webView = [[WKWebView alloc] initWithFrame:self.frame configuration:wkWebConfig];

    self.webView.navigationDelegate = self;
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addSubview:self];
    [self addSubview:self.webView];
    
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"view" : self}]];
    
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"view" : self}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[view]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.webView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.webView}]];
    
    _activityIndicator = [UIActivityIndicatorView new];
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.activityIndicator];
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.activityIndicator startAnimating];
    self.activityIndicator.alpha = 1;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[view]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.activityIndicator}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.activityIndicator}]];

    //self.webView.UIDelegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    
    [self registerForKeyboardNotifications];
    [self setupWebView];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSDictionary *sentData = (NSDictionary*)message.body;
    
    if (sentData[@"iframeDidLoad"]) {
        _iframeLoaded = YES;
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha = 0;
        [self.delegate didLoadPaymentView];
    }
    
    if (sentData[@"jsonResponse"]) {
        _jsonResponse = sentData[@"jsonResponse"];
        NSError *jsonError;
        NSData *objectData = [self.jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&jsonError];
        
        if ([self.jsonResponse containsString:@"ErrorCode"] || [self.jsonResponse containsString:@"@ShortText"]) {
            if (self.delegate) {
                [self.delegate paymentFailed];
            }
            
            CTErrorResponse *error = [[CTErrorResponse alloc] initWithDictionary:json];
            [self showError:@"Error" message:error.errorMessage];
            [self.webView evaluateJavaScript:@"resetResponses()" completionHandler:nil];
            
        } else {
            
            [self.webView evaluateJavaScript:@"resetResponses()" completionHandler:nil];
            switch (self.paymentType) {
                    
                case CTPaymentTypeCarRental: {
                    CTBooking *booking = [[CTBooking alloc] initFromVehReservationDictionary:json];
                    self.carRentalSearch.booking = booking;
                    
                    CTRentalBooking *savedBooking = [[CTRentalBooking alloc] initFromSearch:self.carRentalSearch];
                    savedBooking.bookingId = booking.confID;
                    [CTDataStore storeRentalBooking:savedBooking];
                    
                }
                    break;
                default:
                    break;
            }
            
            if (self.delegate) {
                [self.delegate didMakeBooking];
            }
            
        }
    }
    
    if (sentData[@"backButtonEnabled"]) {
        if ([sentData[@"backButtonEnabled"] intValue] == 0) {
            if (self.delegate) {
                [self.delegate willMakeBooking];
            }
        } else {
            if (self.delegate) {
                [self.delegate paymentFailed];
            }
        }
    }
}

- (void)setForCarRentalPayment:(CTRentalSearch *)search
{
    _carRentalSearch = search;
    _paymentType = CTPaymentTypeCarRental;

    NSString *s = [CTPaymentRequest OTA_VehResRQ:[search.pickupDate stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]
                                returnDateTime:[search.dropoffDate stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]
                            pickupLocationCode:search.pickupLocation.code
                           dropoffLocationCode:search.dropoffLocation.code
                                   homeCountry:[CTSDKSettings instance].homeCountryCode
                                     driverAge:search.driverAge.stringValue
                                 numPassengers:search.passengerQty.stringValue
                                  flightNumber:search.flightNumber
                                         refID:search.selectedVehicle.vehicle.refID
                                  refTimeStamp:search.selectedVehicle.vehicle.refTimeStamp
                                        refURL:search.selectedVehicle.vehicle.refURL
                                   extrasArray:search.selectedVehicle.vehicle.extraEquipment
                                     givenName:search.firstName
                                       surName:search.surname
                                  emailAddress:search.email
                                       address:search.concatinatedAddress
                                   phoneNumber:search.phone
                               insuranceObject:search.insurance
                             isBuyingInsurance:search.isBuyingInsurance
                                      clientID:[CTSDKSettings instance].clientId
                                        target:[CTSDKSettings instance].target
                                        locale:[CTSDKSettings instance].languageCode
                                      currency:[CTSDKSettings instance].currencyCode];
    
    NSString *escapedString = [s stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    escapedString = [escapedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    NSString *urlStr;
    
    if ([CTSDKSettings instance].isDebug) {
        urlStr = [NSString stringWithFormat:@"http://external-dev.cartrawler.com/cartrawlerpay/paymentform?type=OTA_VehResRQ&hideButton=true&mobile=true&msg=%@", escapedString];
    } else {
        urlStr = [NSString stringWithFormat:@"https://otasecure.cartrawler.com/cartrawlerpay/paymentform?type=OTA_VehResRQ&hideButton=true&mobile=true&msg=%@", escapedString];
    }

    NSString *htmlFile = [self.bundle pathForResource:@"CTPCI" ofType:@"html"];
    _htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    self.htmlString = [self.htmlString stringByReplacingOccurrencesOfString:@"[URLPLACEHOLDER]" withString:urlStr];
    [self.webView loadHTMLString:self.htmlString baseURL: self.bundle.bundleURL];
    _iframeLoaded = NO;
    [self.activityIndicator startAnimating];
    self.activityIndicator.alpha = 1;
    [self setupWebView];

}

- (void)setupWebView
{
    self.alpha = 1;
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

- (void)reload
{
    [self.webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.delegate) {
        [self.delegate didLoadPaymentView];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if (self.delegate) {
        [self.delegate didFailLoadingPaymentView];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if (self.delegate) {
        [self.delegate didFailLoadingPaymentView];
    }
}

- (void)showError:(NSString *)title message:(NSString *)message
{
    [[CTAnalytics instance] tagError:@"step8" event:title message:message];
    _alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [self.alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (self.carRentalSearch) {
            [self setForCarRentalPayment:self.carRentalSearch];
        }
    }
}

- (void)confirmPayment
{
    if (self.iframeLoaded) {
        [self.webView evaluateJavaScript:@"validateAndBook()" completionHandler:nil];
        if (self.delegate) {
            [self.delegate willMakeBooking];
        }
    }
}

@end
