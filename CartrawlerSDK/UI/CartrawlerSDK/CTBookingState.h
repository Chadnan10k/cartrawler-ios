//
//  CTBookingState.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 15/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTCSVItem.h"

typedef NS_ENUM(NSInteger, CTBookingTextfield) {
    CTBookingTextfieldNone,
    CTBookingTextfieldFirstName,
    CTBookingTextfieldLastName,
    CTBookingTextfieldEmailAddress,
    CTBookingTextfieldPrefix,
    CTBookingTextfieldPhoneNumber,
    CTBookingTextfieldCountry,
    CTBookingTextfieldFlightNumber,
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
@property (nonatomic) CTCSVItem *country;
@property (nonatomic) NSString *flightNumber;
@end
