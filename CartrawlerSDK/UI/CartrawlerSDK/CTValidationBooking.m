//
//  CTValidationBooking.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 17/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTValidationBooking.h"
#import "CTFlightNumberValidation.h"

@implementation CTValidationBooking

+ (NSArray *)validateBookingStep:(CTAppState *)appState {
    CTBookingState *bookingState = appState.bookingState;
    NSMutableArray *validationFailures = [NSMutableArray new];
    
    if (!bookingState.firstName || ![self validateString:bookingState.firstName]) {
        [validationFailures addObject:@(CTValidationBookingFailedFirstName)];
    }
    if (!bookingState.lastName || ![self validateString:bookingState.lastName]) {
        [validationFailures addObject:@(CTValidationBookingFailedLastName)];
    }
    if (!bookingState.emailAddress || ![self validateString:bookingState.emailAddress]) {
        [validationFailures addObject:@(CTValidationBookingFailedEmailAddress)];
    }
    if (!bookingState.prefix || ![self validateString:bookingState.prefix] || ![self validatePhone:bookingState.prefix]) {
        [validationFailures addObject:@(CTValidationBookingFailedPrefix)];
    }
    if (!bookingState.phoneNumber || ![self validateString:bookingState.phoneNumber] || ![self validatePhone:bookingState.phoneNumber]) {
        [validationFailures addObject:@(CTValidationBookingFailedPhoneNumber)];
    }
    if (!bookingState.flightNumber || ![self validateString:bookingState.flightNumber] || ![self validateFlight:bookingState.flightNumber]) {
        [validationFailures addObject:@(CTValidationBookingFailedFlightNumber)];
    }
    if (appState.selectedVehicleState.insuranceAdded) {
        if (!bookingState.addressLine1 || ![self validateString:bookingState.addressLine1]) {
            [validationFailures addObject:@(CTValidationBookingFailedAddressLine1)];
        }
        if (!bookingState.city || ![self validateString:bookingState.city]) {
            [validationFailures addObject:@(CTValidationBookingFailedCity)];
        }
        if (!bookingState.postcode || ![self validateString:bookingState.postcode]) {
            [validationFailures addObject:@(CTValidationBookingFailedPostcode)];
        }
        if (!bookingState.country) {
            [validationFailures addObject:@(CTValidationBookingFailedCountry)];
        }
    }
    
    return validationFailures.copy;
}

+ (BOOL)validateString:(NSString *)string; {
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString =  [string stringByTrimmingCharactersInSet:charSet];
    return ![trimmedString isEqualToString: @""];
}

+ (BOOL)validatePhone:(NSString *)phoneNumber {
    NSString *phoneRegex = @"(^\\+|[0-9456])([0-9]{0,15}$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}

+ (BOOL)validateFlight:(NSString *)flightNumber {
    if (![self isAlphaNumeric:flightNumber]) {
        return NO;
    }
    
    NSString *flightNo = [[flightNumber componentsSeparatedByCharactersInSet:
                           [NSCharacterSet decimalDigitCharacterSet].invertedSet]
                          componentsJoinedByString:@""];
    
    NSString *airline = [[flightNumber componentsSeparatedByCharactersInSet:
                          [NSCharacterSet letterCharacterSet].invertedSet]
                         componentsJoinedByString:@""];
    
    if ([flightNo length] > 4) {
        return NO;
    }
    
    if (![flightNo isEqualToString:@""] && ![airline isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}


+ (BOOL)isAlphaNumeric:(NSString *)str {
    NSCharacterSet *unwantedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([str rangeOfCharacterFromSet:unwantedCharacters].location == NSNotFound);
}

@end
