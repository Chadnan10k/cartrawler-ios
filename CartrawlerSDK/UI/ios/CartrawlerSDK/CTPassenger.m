//
//  CTPassenger.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 20/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTPassenger.h"

@implementation CTPassenger

+ (nonnull CTPassenger *)passengerWithFirstName:(nonnull NSString *)firstName
                                       lastName:(nonnull NSString *)lastName
                                   addressLine1:(nonnull NSString *)addressLine1
                                   addressLine2:(nullable NSString *)addressLine2
                                           city:(nonnull NSString *)city
                                       postcode:(nonnull NSString *)postcode
                                    countryCode:(nonnull NSString *)countryCode
                                            age:(nonnull NSNumber *)age
                                          email:(nullable NSString *)email
                                          phone:(nullable NSString *)phone
                                isPrimaryDriver:(BOOL)isPrimaryDriver
{
    CTPassenger *passeger = [CTPassenger new];
    passeger.firstName = firstName;
    passeger.lastName = lastName;
    passeger.addressLine1 = addressLine1;
    passeger.addressLine2 = addressLine2 ?: @"";
    passeger.city = city;
    passeger.postcode = postcode;
    passeger.countryCode = countryCode;
    passeger.age = age;
    passeger.isPrimaryDriver = isPrimaryDriver;
    passeger.email = email ?: @"";
    passeger.phone = phone ?: @"";
    return passeger;
}

@end
