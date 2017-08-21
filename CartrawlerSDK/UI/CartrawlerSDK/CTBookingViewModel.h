//
//  CTBookingViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 14/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTPaymentSummaryViewModel.h"

@interface CTBookingViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) CTPaymentSummaryViewModel *paymentSummaryViewModel;
@property (nonatomic, readonly) CTBookingTextfield selectedTextfield;

@property (nonatomic, readonly) NSString *total;
@property (nonatomic, readonly) NSString *totalAmount;

@property (nonatomic, readonly) NSString *firstNamePlaceholder;
@property (nonatomic, readonly) NSString *lastNamePlaceholder;
@property (nonatomic, readonly) NSString *emailAddressPlaceholder;
@property (nonatomic, readonly) NSString *prefixPlaceholder;
@property (nonatomic, readonly) NSString *phoneNumberPlaceholder;
@property (nonatomic, readonly) NSString *flightNumberPlaceholder;
@property (nonatomic, readonly) NSString *addressLine1Placeholder;
@property (nonatomic, readonly) NSString *addressLine2Placeholder;
@property (nonatomic, readonly) NSString *cityPlaceholder;
@property (nonatomic, readonly) NSString *postcodePlaceholder;
@property (nonatomic, readonly) NSString *countryPlaceholder;

@property (nonatomic, readonly) NSString *firstName;
@property (nonatomic, readonly) NSString *lastName;
@property (nonatomic, readonly) NSString *emailAddress;
@property (nonatomic, readonly) NSString *prefix;
@property (nonatomic, readonly) NSString *phoneNumber;
@property (nonatomic, readonly) NSString *flightNumber;
@property (nonatomic, readonly) NSString *addressLine1;
@property (nonatomic, readonly) NSString *addressLine2;
@property (nonatomic, readonly) NSString *city;
@property (nonatomic, readonly) NSString *postcode;
@property (nonatomic, readonly) NSString *country;

@property (nonatomic, readonly) BOOL shakeAnimations;
@property (nonatomic, readonly) BOOL shakeFirstName;
@property (nonatomic, readonly) BOOL shakeLastName;
@property (nonatomic, readonly) BOOL shakeEmailAddress;
@property (nonatomic, readonly) BOOL shakePrefix;
@property (nonatomic, readonly) BOOL shakePhoneNumber;
@property (nonatomic, readonly) BOOL shakeFlightNumber;
@property (nonatomic, readonly) BOOL shakeAddressLine1;
@property (nonatomic, readonly) BOOL shakeAddressLine2;
@property (nonatomic, readonly) BOOL shakeCity;
@property (nonatomic, readonly) BOOL shakePostcode;
@property (nonatomic, readonly) BOOL shakeCountry;

@property (nonatomic, readonly) NSString *extrasReminder;

@property (nonatomic, readonly) BOOL showAddressDetails;
@property (nonatomic, readonly) NSNumber *keyboardHeight;
@property (nonatomic, readonly) UIColor *navigationBarColor;
@property (nonatomic, readonly) UIColor *buttonColor;

@end
