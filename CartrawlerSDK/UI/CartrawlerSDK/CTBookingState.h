//
//  CTBookingState.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 15/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTCSVItem.h"
#import <CartrawlerAPI/CTBooking.h>

typedef NS_ENUM(NSInteger, CTBookingTextfield) {
    CTBookingTextfieldNone,
    CTBookingTextfieldFirstName,
    CTBookingTextfieldLastName,
    CTBookingTextfieldEmailAddress,
    CTBookingTextfieldPrefix,
    CTBookingTextfieldPhoneNumber,
    CTBookingTextfieldFlightNumber,
    CTBookingTextfieldAddressLine1,
    CTBookingTextfieldAddressLine2,
    CTBookingTextfieldCity,
    CTBookingTextfieldPostcode,
    CTBookingTextfieldCountry,
    CTBookingTextfieldPayment,
};

@interface CTBookingState : NSObject
@property (nonatomic) id paymentView;
@property (nonatomic) CTBookingTextfield selectedTextfield;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *emailAddress;
@property (nonatomic) NSString *prefix;
@property (nonatomic) NSString *phoneNumber;
@property (nonatomic) NSString *flightNumber;
@property (nonatomic) NSString *addressLine1;
@property (nonatomic) NSString *addressLine2;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *postcode;
@property (nonatomic) CTCSVItem *country;
@property (nonatomic) BOOL wantsBooking;
@property (nonatomic) BOOL animateValidationFailed;
@property (nonatomic) CTBooking *bookingConfirmation;
@property (nonatomic) NSError *bookingConfirmationError;
@end
