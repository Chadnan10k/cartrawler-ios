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
#import "DataStore.h"

@interface CTPaymentView() <UIWebViewDelegate, UIAlertViewDelegate, NSURLConnectionDataDelegate>

typedef NS_ENUM(NSUInteger, CTPaymentType) {
    
    CTPaymentTypeCarRental = 0,
    
    CTPaymentTypeGroundTransport,
    
};

@property (nonatomic, strong) UIWebView *webView;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIAlertView *alertView;
@property (strong, nonatomic) NSString *htmlString;
@property (strong, nonatomic) NSBundle *bundle;
@property (strong, nonatomic) NSString *jsonResponse;

@property (nonatomic) BOOL runLoop;
@property (nonatomic) BOOL termsChecked;

@property (nonatomic) CTPaymentType paymentType;

@property (nonatomic, copy) GroundTransportSearch *groundSearch;
@property (nonatomic, copy) CarRentalSearch *carRentalSearch;

@end

@implementation CTPaymentView

- (void)presentInView:(UIView *)parentView
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _bundle = [NSBundle bundleForClass:[self class]];
    
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
    
    //_reachability = [Reachability reachabilityForInternetConnection];
    //[self.reachability startNotifier];

    //[[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    [self setupWebView];
}

- (void)setForGTPayment:(GroundTransportSearch *)search
{
    _groundSearch = search;
    _runLoop = NO;
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

- (void)setForCarRentalPayment:(CarRentalSearch *)search
{
    _carRentalSearch = search;
    _runLoop = NO;
    _paymentType = CTPaymentTypeCarRental;

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

    [self setupWebView];
}

- (void)setupWebView
{
    self.alpha = 1;
    [self startTimer];
}

- (void)reachabilityChanged:(NSNotification *)notification {
    /*
    Reachability *reachability = notification.object;
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {
        [self showError:@"Error" message:@"No internet connection"];
    } else {
        NSLog(@"INTERNET AVAILABLE");
    }
     */
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
    NSLog(@"CARTRAWLERSDK: Could not load PCI WebView %@", error.localizedDescription);
    //[self showError:@"Error" message:@"Cannot load payment"];
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
            
            if ([self.jsonResponse containsString:@"ErrorCode"] || [self.jsonResponse containsString:@"@ShortText"]) {
                
                if (self.completion) {
                    self.completion(NO);
                }

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
                            self.carRentalSearch.booking = booking;
                            
                            CTRentalBooking *savedBooking = [[CTRentalBooking alloc] init];
                            savedBooking.bookingId = booking.confID;
                            savedBooking.pickupLocation = self.carRentalSearch.pickupLocation.name;
                            savedBooking.dropoffLocation = self.carRentalSearch.dropoffLocation.name;
                            savedBooking.pickupDate = self.carRentalSearch.pickupDate;
                            savedBooking.dropoffDate = self.carRentalSearch.dropoffDate;
                            savedBooking.vehicleImage = self.carRentalSearch.selectedVehicle.vehicle.pictureURL.absoluteString;
                            savedBooking.vehicleName = self.carRentalSearch.selectedVehicle.vehicle.makeModelName;
                            [DataStore storeRentalBooking:savedBooking];
                            
                            self.completion(YES);
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
                            [DataStore storeGTBooking:savedBooking];
                            
                            self.completion(YES);
                        }
                            
                            break;
                        default:
                            break;
                    }
                }
            }
        } else {
            if ([[self.webView stringByEvaluatingJavaScriptFromString:@"getCurrentState()"] isEqualToString:@"ValidationError"]) {
                [self.webView stringByEvaluatingJavaScriptFromString:@"resetResponses()"];
                if (self.completion) {
                    self.completion(NO);
                }
                _runLoop = NO;
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
        
        if (self.groundSearch) {
            [self setForGTPayment:self.groundSearch];
        } else if (self.carRentalSearch) {
            [self setForCarRentalPayment:self.carRentalSearch];
        }
        
        if (self.completion) {
            self.completion(NO);
        }
    }
}

- (void)termsAndConditionsChecked:(BOOL)check
{
    _termsChecked = check;
}

- (void)confirmPayment
{
    if (!self.runLoop) {
        [self setupWebView];
    }

    [self.webView stringByEvaluatingJavaScriptFromString:@"validateAndBook()"];
    _runLoop = YES;

}

@end
