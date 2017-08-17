//
//  CTValidationBooking.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 17/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTAppState.h"

typedef NS_ENUM(NSInteger, CTValidationBookingFailed) {
    CTValidationBookingFailedFirstName,
    CTValidationBookingFailedLastName,
    CTValidationBookingFailedEmailAddress,
    CTValidationBookingFailedPrefix,
    CTValidationBookingFailedPhoneNumber,
    CTValidationBookingFailedFlightNumber,
    CTValidationBookingFailedAddressLine1,
    CTValidationBookingFailedAddressLine2,
    CTValidationBookingFailedCity,
    CTValidationBookingFailedPostcode,
    CTValidationBookingFailedCountry,
};

@interface CTValidationBooking : NSObject

+ (NSArray <NSNumber *> *)validateBookingStep:(CTAppState *)appState;

@end
