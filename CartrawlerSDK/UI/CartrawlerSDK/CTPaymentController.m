//
//  CTPaymentController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 15/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTPaymentController.h"
#import <CTPayment/CTPayment.h>
#import "CTPaymentRequestGenerator.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CartrawlerSDK+NSNumber.h"

@interface CTPaymentController () <CTPaymentDelegate, UITextFieldDelegate>
@property (nonatomic, strong) CTPayment *payment;
@end

@implementation CTPaymentController

- (instancetype)initWithContainerView:(UIView *)containerView {
    self = [super init];
    if (self) {
        _payment = [[CTPayment alloc] initWithContainerView:containerView
                                                   language:@"en"
                                                 appearance:nil
                                                      debug:YES
                                                     active:NO];
        _payment.delegate = self;
    }
    return self;
}

- (void)makePaymentWithState:(CTAppState *)appState {
    CTSearchState *searchState = appState.searchState;
    CTUserSettingsState *userSettingsState = appState.userSettingsState;
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    CTVehicle *selectedVehicle = selectedVehicleState.selectedAvailabilityItem.vehicle;
    CTBookingState *bookingState = appState.bookingState;
    
    // TODO: Extract
    NSString *target = userSettingsState.debugMode ? @"Test" : @"Production";
    
    NSDate *pickupDate = [NSDate mergeTimeWithDateWithTime:searchState.selectedPickupTime
                                               dateWithDay:searchState.selectedPickupDate];
    NSDate *dropoffDate = [NSDate mergeTimeWithDateWithTime:searchState.selectedDropoffTime
                                                dateWithDay:searchState.selectedDropoffDate];
    
    CTMatchedLocation *dropoffLocation = searchState.dropoffLocationRequired ? searchState.selectedDropoffLocation : searchState.selectedPickupLocation;
    
    NSString *age = searchState.driverAgeRequired ? searchState.displayedDriverAge : @"30";
    
    NSString *json = [CTPaymentRequestGenerator OTA_VehResRQ:[pickupDate stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]
                                              returnDateTime:[dropoffDate stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]
                                          pickupLocationCode:searchState.selectedPickupLocation.code
                                         dropoffLocationCode:dropoffLocation.code
                                                 homeCountry:userSettingsState.countryCode
                                                   driverAge:age
                                               numPassengers:@"1"
                                                flightNumber:bookingState.flightNumber
                                                       refID:selectedVehicle.refID
                                                refTimeStamp:selectedVehicle.refTimeStamp
                                                      refURL:selectedVehicle.refURL
                                                 extrasArray:@[]
                                                   givenName:bookingState.firstName
                                                     surName:bookingState.lastName
                                                emailAddress:bookingState.emailAddress
                                                     address:nil
                                                 phoneNumber:bookingState.phoneNumber
                                             insuranceObject:selectedVehicleState.insurance
                                           isBuyingInsurance:selectedVehicleState.insuranceAdded
                                                    clientID:userSettingsState.clientID
                                                      target:target
                                                      locale:userSettingsState.languageCode
                                                    currency:userSettingsState.currencyCode];
     [self.payment makePaymentWithJSON:json];
}

- (void)payment:(CTPayment *)payment didSucceedWithResponse:(NSDictionary *)response {
    
}

/**
 Callback for makePaymentWithJSON indicating failure
 
 @param payment the CTPayment instance
 @param error the error, see CTPaymentErrorCodes to interpret error code
 */
- (void)payment:(CTPayment *)payment didFailWithError:(NSError *)error {
    
}


/**
 Callback for when there is invalid data in the text inputs
 @param successfulValidation indicates successful validation
 */
- (void)payment:(CTPayment *)payment didSucceedValidation:(BOOL)successfulValidation {
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

@end
