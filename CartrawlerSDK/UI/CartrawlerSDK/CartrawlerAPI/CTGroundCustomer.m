//
//  CTGroundCustomer.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 24/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTGroundCustomer.h"

@implementation CTGroundCustomer

- (instancetype)initWithAddressLine1:(NSString *)addressLine1
              addressLine2:(NSString *)addressLine2
               addressTown:(NSString *)addressTown
               addressCity:(NSString *)addressCity
           addressPostCode:(NSString *)addressPostCode
     addressStateProvince:(NSString *)addressStateProvince
               countryCode:(NSString *)countryCode
               countryName:(NSString *)countryName
                     email:(NSString *)email
                     phone:(NSString *)phone
                 firstName:(NSString *)firstName
                   surname:(NSString *)surname
{
    _addressLine1 = addressLine1;
    
    if (addressLine2 != nil) {
        _addressLine2 = addressLine2;
    }
    
    _addressTown = addressTown;
    _addressCity = addressCity;
    _addressPostCode = addressPostCode;
    
    if (addressStateProvince != nil) {
        _addressStateProvince = addressStateProvince;
    }
    
    _countryCode = countryCode;
    _countryName = countryName;
    _email = email;
    _phone = phone;
    _firstName = firstName;
    _surname = surname;
    
    return self;
}

@end
