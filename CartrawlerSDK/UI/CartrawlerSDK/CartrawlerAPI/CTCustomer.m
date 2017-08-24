//
//  Customer.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 15/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTCustomer.h"

@implementation CTCustomer

- (instancetype)initWithHomeCountry:(NSString *)homeCountry
                      age:(NSNumber *)age
                firstName:(NSString *)firstName
                 lastName:(NSString *)lastName
                    email:(NSString *)email
                  address:(NSString *)address
                    phone:(NSString *)phone
{
    _homeCountry = homeCountry;
    _age = age;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _address = address;
    _phone = phone;
    return self;
}

@end
