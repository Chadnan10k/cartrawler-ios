//
//  CTPaymentView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentView.h"
#import "Reachability.h"
#import "PaymentRequest.h"
#import "CTSDKSettings.h"
#import "NSDateUtils.h"
#import "CTButton.h"
#import "GTPaymentRequest.h"

@interface CTPaymentView() <UIWebViewDelegate, UIAlertViewDelegate, NSURLConnectionDataDelegate>

typedef NS_ENUM(NSUInteger, CTPaymentType) {
    
    CTPaymentTypeCarRental = 0,
    
    CTPaymentTypeGroundTransport,
    
};

@property (nonatomic, strong) UIWebView *webView;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIAlertView *alertView;
@property (strong, nonatomic) Reachability *reachability;
@property (strong, nonatomic) NSString *htmlString;
@property (strong, nonatomic) NSBundle *bundle;
@property (strong, nonatomic) NSString *jsonResponse;

@property (nonatomic) BOOL runLoop;
@property (nonatomic) BOOL termsChecked;
@property (nonatomic) CTPaymentType paymentType;

@end

@implementation CTPaymentView

- (void)presentInView:(UIView *)parentView
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    _bundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString *htmlFile = [self.bundle pathForResource:@"CTPCI" ofType:@"html"];
    _htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addSubview:self];
    [self addSubview:self.webView];
    
    //first bind the entire view to superview
    NSLayoutConstraint *viewTopConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:parentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0];
    
    NSLayoutConstraint *viewBottomConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:parentView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:0];
    
    NSLayoutConstraint *viewLeftConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:parentView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0];
    
    NSLayoutConstraint *viewRightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:parentView
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:0];
    [parentView addConstraints:@[viewTopConstraint,
                           viewBottomConstraint,
                           viewLeftConstraint,
                           viewRightConstraint]];
    
    //Now bind webview to self
    NSLayoutConstraint *webTopConstraint = [NSLayoutConstraint constraintWithItem:self.webView
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0
                                                                          constant:0];
    
    NSLayoutConstraint *webBottomConstraint = [NSLayoutConstraint constraintWithItem:self.webView
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1.0
                                                                             constant:40];
    
    NSLayoutConstraint *webLeftConstraint = [NSLayoutConstraint constraintWithItem:self.webView
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.0
                                                                           constant:0];
    
    NSLayoutConstraint *webRightConstraint = [NSLayoutConstraint constraintWithItem:self.webView
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1.0
                                                                            constant:0];
    [self addConstraints:@[webTopConstraint,
                                 webBottomConstraint,
                                 webLeftConstraint,
                                 webRightConstraint]];

    
    self.webView.delegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    
    [self registerForKeyboardNotifications];
    
    _reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];

    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    [self setupWebView];
}

- (void)setForGTPayment:(GroundTransportSearch *)search
{
    
    _paymentType = CTPaymentTypeGroundTransport;
    
    NSString *flightNo = [[search.flightNumber componentsSeparatedByCharactersInSet:
                           [NSCharacterSet decimalDigitCharacterSet].invertedSet]
                          componentsJoinedByString:@""];
    
    NSString *airline = [[search.flightNumber componentsSeparatedByCharactersInSet:
                          [NSCharacterSet letterCharacterSet].invertedSet]
                         componentsJoinedByString:@""];
    
    NSNumberFormatter *f = [NSNumberFormatter new];
    f.maximumFractionDigits = 5;
    f.numberStyle = NSNumberFormatterDecimalStyle;

    NSString *s = [GTPaymentRequest
                      CT_GroundBook:[NSDateUtils stringFromDateWithFormat:search.pickupLocation.dateTime format:@"yyyy-MM-dd'T'HH:mm:ss"]
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
                    dropOffdateTime:[NSDateUtils stringFromDateWithFormat:[search.pickupLocation.dateTime
                                                                           dateByAddingTimeInterval:1*24*60*60] format:@"yyyy-MM-dd'T'HH:mm:ss"]
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
                        childrenQty:@"0"
                          infantQty:@"0"
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
        urlStr = [NSString stringWithFormat:@"https://external-dev.cartrawler.com/cartrawlerpay/paymentform?type=OTA_GroundBookRQ&hideButton=true&mobile=true&msg=%@", escapedString];
    } else {
        urlStr = [NSString stringWithFormat:@"https://otasecure.cartrawler.com/cartrawlerpay/paymentform?type=OTA_GroundBookRQ&hideButton=true&mobile=true&msg=%@", escapedString];
    }

    self.htmlString = [self.htmlString stringByReplacingOccurrencesOfString:@"[URLPLACEHOLDER]" withString:urlStr];
    
    [self.webView loadHTMLString:self.htmlString baseURL: self.bundle.bundleURL];
    
    [self setupWebView];
}

- (void)setForCarRentalPayment:(CarRentalSearch *)search
{
    _runLoop = NO;
    _paymentType = CTPaymentTypeCarRental;

    NSString *s = [PaymentRequest OTA_VehResRQ:[NSDateUtils stringFromDateWithFormat:search.pickupDate format:@"yyyy-MM-dd'T'HH:mm:ss"]
                                returnDateTime:[NSDateUtils stringFromDateWithFormat:search.dropoffDate format:@"yyyy-MM-dd'T'HH:mm:ss"]
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

    self.htmlString = [self.htmlString stringByReplacingOccurrencesOfString:@"[URLPLACEHOLDER]" withString:urlStr];
    
    [self.webView loadHTMLString:self.htmlString baseURL: self.bundle.bundleURL];

    [self setupWebView];
    
    NSLog(@"VEHREF: %@, %@", search.selectedVehicle.vehicle.refID, self.htmlString);
}

- (void)setupWebView
{
    self.alpha = 1;
    [self startTimer];
}

- (void)reachabilityChanged:(NSNotification *)notification {
    Reachability *reachability = notification.object;
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {
        [self showError:@"Error" message:@"No internet connection"];
    } else {
        NSLog(@"INTERNET AVAILABLE");
    }
}

- (void)startTimer
{
    //Invalidate timer does not seem to work even when explicitly stating the thread
    _runLoop = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                  target:self
                                                selector:@selector(currentState)
                                                userInfo:nil
                                                 repeats:YES];
    });
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

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"CARTRAWLERSDK PAYMENTVIEW FAILED LOAD");
    [self showError:@"Error" message:@"Cannot load payment"];
}

- (void)currentState
{
    if (self.runLoop) {
        
        _jsonResponse = [self.webView stringByEvaluatingJavaScriptFromString:@"getJsonResponse()"];
        
        if (![self.jsonResponse isEqualToString:@""]) {
            NSError *jsonError;
            NSData *objectData = [self.jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
            
            if ([self.jsonResponse containsString:@"Errors"]) {
                NSLog(@"%@", self.jsonResponse);
                CTErrorResponse *error = [[CTErrorResponse alloc] initWithDictionary:json];
                [self showError:@"Error" message:error.errorMessage];
                _runLoop = NO;
                [self.webView stringByEvaluatingJavaScriptFromString:@"resetResponses()"];
            } else {
                _runLoop = NO;
                if (self.completion) {
                    [self.webView stringByEvaluatingJavaScriptFromString:@"resetResponses()"];
                    switch (self.paymentType) {
                        case CTPaymentTypeCarRental: {
                            CTBooking *booking = [[CTBooking alloc] initFromVehReservationDictionary:json];
                            self.completion(booking);
                        }
                            break;
                        case CTPaymentTypeGroundTransport: {
                            CTGroundBooking *booking = [[CTGroundBooking alloc] initWithDictionary:json];
                            self.completion(booking);
                        }
                            break;
                        default:
                            break;
                    }
                }
            }
        }
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
        [self startTimer];
    }
}

- (void)termsAndConditionsChecked:(BOOL)check
{
    _termsChecked = check;
}

- (void)confirmPayment
{
    if (self.termsChecked) {
        [self.webView stringByEvaluatingJavaScriptFromString:@"validateAndBook()"];
    } else {
        [self showError:@"Sorry" message:@"You must check terms and conditions"];
    }
}

@end
