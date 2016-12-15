//
//  CTPaymentView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentView.h"
#import "PaymentRequest.h"
#import "CTSDKSettings.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CTButton.h"
#import "GTPaymentRequest.h"
#import "CTDataStore.h"
#import "Reachability.h"
#import <WebKit/WebKit.h>
#import "CartrawlerSDK+WKWebView.h"
#import "CTPaymentCheck.h"

@interface CTPaymentView() <UIAlertViewDelegate, NSURLConnectionDataDelegate, WKScriptMessageHandler, WKNavigationDelegate, CTPaymentCheckDelegate>

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

@property (nonatomic, copy) GroundTransportSearch *groundSearch;
@property (nonatomic, copy) CTRentalSearch *carRentalSearch;
@property (nonatomic, strong) CTPaymentCheck *paymentCheck;
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
                [self.paymentCheck stop];
                [self.delegate paymentFailed];
            }
            
            CTErrorResponse *error = [[CTErrorResponse alloc] initWithDictionary:json];
            [self showError:@"Error" message:error.errorMessage];
            [self.webView evaluateJavaScript:@"resetResponses()" completionHandler:nil];
            
        } else {
            
            [self.webView evaluateJavaScript:@"resetResponses()" completionHandler:nil];
            
            if (self.delegate) {
                [self.paymentCheck stop];
                if (self.delegate) {
                    [self.delegate didMakeBooking];
                }
            }
            
            switch (self.paymentType) {
                    
                case CTPaymentTypeCarRental: {
                    CTBooking *booking = [[CTBooking alloc] initFromVehReservationDictionary:json];
                    self.carRentalSearch.booking = booking;
                    
                    CTRentalBooking *savedBooking = [[CTRentalBooking alloc] init];
                    savedBooking.bookingId = booking.confID;
                    savedBooking.pickupLocation = self.carRentalSearch.pickupLocation.name;
                    savedBooking.dropoffLocation = self.carRentalSearch.dropoffLocation.name;
                    savedBooking.pickupDate = self.carRentalSearch.pickupDate;
                    savedBooking.dropoffDate = self.carRentalSearch.dropoffDate;
                    savedBooking.vehicleImage = self.carRentalSearch.selectedVehicle.vehicle.pictureURL.absoluteString;
                    savedBooking.vehicleName = self.carRentalSearch.selectedVehicle.vehicle.makeModelName;
                    [CTDataStore storeRentalBooking:savedBooking];
                    
                }
                    
                    break;
                case CTPaymentTypeGroundTransport: {
                    CTGroundBooking *booking = [[CTGroundBooking alloc] initWithDictionary:json];
                    self.groundSearch.booking = booking;
                    
                    GTBooking *savedBooking = [[GTBooking alloc] init];
                    savedBooking.bookingId = booking.confirmationId;
                    savedBooking.pickupLocation = self.groundSearch.pickupLocation.name;
                    savedBooking.dropoffLocation = self.groundSearch.dropoffLocation.name;
                    savedBooking.pickupDate = self.groundSearch.pickupLocation.dateTime;
                    savedBooking.dropoffDate = self.groundSearch.dropoffLocation.dateTime;
                    savedBooking.vehicleImage = self.groundSearch.selectedService.vehicleImage != nil ? self.groundSearch.selectedService.vehicleImage.absoluteString : self.groundSearch.selectedShuttle.vehicleImage.absoluteString;
                    savedBooking.vehicleName = self.groundSearch.selectedShuttle != nil ? self.groundSearch.selectedShuttle.companyName : self.groundSearch.selectedService.companyName;
                    [CTDataStore storeGTBooking:savedBooking];
                    
                }
                    break;
                default:
                    break;
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

- (void)setForGTPayment:(GroundTransportSearch *)search
{
    _groundSearch = search;
    _paymentType = CTPaymentTypeGroundTransport;
    
    NSString *flightNo = [[search.flightNumber componentsSeparatedByCharactersInSet:
                           [NSCharacterSet decimalDigitCharacterSet].invertedSet]
                          componentsJoinedByString:@""];
    
    NSString *airline = [[search.flightNumber componentsSeparatedByCharactersInSet:
                          [NSCharacterSet letterCharacterSet].invertedSet]
                         componentsJoinedByString:@""];
    
    NSNumberFormatter *f = [NSNumberFormatter new];
    [f setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    f.maximumFractionDigits = 5;
    f.numberStyle = NSNumberFormatterDecimalStyle;

    NSString *s = [GTPaymentRequest
                      CT_GroundBook:[search.pickupLocation.dateTime  stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]
                     pickupLatitude:[f stringFromNumber:search.pickupLocation.latitude]
                    pickupLongitude:[f stringFromNumber:search.pickupLocation.longitude]
                       addressLine1:search.addressLine1
                       addressLine2:search.addressLine2
                               town:search.city
                               city:search.city
                           postcode:search.postcode
                        countryCode:search.countryCode
                        countryName:search.country
                 pickupLocationType:search.pickupLocation.locationTypeDescription
                 pickupLocationName:search.pickupLocation.name
                specialInstructions:search.specialInstructions
                   dropOffdateTime:[[search.pickupLocation.dateTime
                                     dateByAddingTimeInterval:1*24*60*60] stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]
                    dropoffLatitude:[f stringFromNumber:search.dropoffLocation.latitude]
                   dropoffLongitude:[f stringFromNumber:search.dropoffLocation.longitude]
                dropoffLocationType:search.dropoffLocation.locationTypeDescription
                    airportIsPickup:search.airportIsPickupLocation
                         returnTrip:search.returnTrip
                        airportCode:search.airport.IATACode
                         terminalNo:search.airport.terminalNumber
                          airlineId:airline
                         flightType:search.airport.flightType
                           flightNo:flightNo
                          firstName:search.firstName
                            surname:search.surname
                              phone:search.phone
               passengerCountryCode:search.countryCode
                     passengerEmail:search.email
                 additionalAdultQty:search.adultQty.stringValue
                        childrenQty:search.childQty.stringValue
                          infantQty:search.infantQty.stringValue
                          seniorQty:search.seniorQty.stringValue
                              refId:search.selectedService != nil ? search.selectedService.refId : search.selectedShuttle.refId
                             refUrl:search.selectedService != nil ? search.selectedService.refUrl : search.selectedShuttle.refUrl
                       currencyCode:[CTSDKSettings instance].currencyCode
                           clientID:[CTSDKSettings instance].clientId
                             target:[CTSDKSettings instance].target
                             locale:[CTSDKSettings instance].languageCode
                          ipaddress:@"127.0.0.1"];
    
    NSString *urlStr;
    NSString *escapedString = [s stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    escapedString = [escapedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    if ([CTSDKSettings instance].isDebug) {
        urlStr = [NSString stringWithFormat:@"https://internal-dev.cartrawler.com/cartrawlerpay/paymentform?type=OTA_GroundBookRQ&hideButton=true&mobile=true&msg=%@", escapedString];
    } else {
        urlStr = [NSString stringWithFormat:@"https://otasecure.cartrawler.com/cartrawlerpay/paymentform?type=OTA_GroundBookRQ&hideButton=true&mobile=true&msg=%@", escapedString];
    }
    
    NSString *htmlFile = [self.bundle pathForResource:@"CTPCI" ofType:@"html"];
    _htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    _htmlString = [self.htmlString stringByReplacingOccurrencesOfString:@"[URLPLACEHOLDER]" withString:urlStr];
    
    [self.webView loadHTMLString:self.htmlString baseURL: self.bundle.bundleURL];
    
    [self setupWebView];
    
}

- (void)setForCarRentalPayment:(CTRentalSearch *)search
{
    _carRentalSearch = search;
    _paymentType = CTPaymentTypeCarRental;

    _paymentCheck = [[CTPaymentCheck alloc] initWithRequestorId:[CTSDKSettings instance].clientId
                                                    sandboxMode:[CTSDKSettings instance].isDebug
                                                     pickupDate:self.carRentalSearch.pickupDate
                                                          email:self.carRentalSearch.email];
    self.paymentCheck.delegate = self;
    
    NSLog(@"Payment pickup: %@", [search.pickupDate stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]);
    NSLog(@"Payment dropoff: %@", [search.dropoffDate stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]);

    NSString *s = [PaymentRequest OTA_VehResRQ:[search.pickupDate stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]
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
    [self.paymentCheck start];

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
    _alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [self.alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        if (self.groundSearch) {
            [self setForGTPayment:self.groundSearch];
        } else if (self.carRentalSearch) {
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

#pragma mark CTPaymentCheckDelegate

- (void)checkDidReceiveResponse:(CTPaymentStatus)status
{
    switch (status) {
        case CTPaymentStatusSuccess:
            if (self.delegate) {
                [self.delegate didMakeBooking];
            }
            [self.paymentCheck stop];
            break;
        case CTPaymentStatusNotAvailable:
            
            break;
        case CTPaymentStatusError:
            
            break;
        default:
            break;
    }
}

@end
