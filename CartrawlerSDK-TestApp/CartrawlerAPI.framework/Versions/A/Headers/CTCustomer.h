//
//  Customer.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 15/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  CTCustomer
 */
@interface CTCustomer : NSObject

/**
 *  the Customers age
 */
@property (nonatomic, strong) NSNumber *age;
/**
 *  The customers home country
 */
@property (nonatomic, strong) NSString *homeCountry;
/**
 *  the customers first name
 */
@property (nonatomic, strong) NSString *firstName;
/**
 *  The customers last name
 */
@property (nonatomic, strong) NSString *lastName;
/**
 *  The customers email
 */
@property (nonatomic, strong) NSString *email;
/**
 *  The customers address
 */
@property (nonatomic, strong) NSString *address;
/**
 *  The customers phone number
 */
@property (nonatomic, strong) NSString *phone;

/**
 *  Creates a customer object
 *
 *  @param homeCountry  Customer home country code eg. IE
 *  @param age          Customer age
 *  @param namePrefix   Use NamePrefix enum
 *  @param firstName    First name
 *  @param lastName     Surname
 *  @param email        Customer Email
 *  @param address      Customer Address
 *  @param numberPrefix Must contain numbers only eg. +353 -> 353
 *  @param phone        Customer phone number
 *
 *  @return Initialized Customer object
 */
- (id)initWithHomeCountry:(NSString *)homeCountry
                      age:(NSNumber *)age
                firstName:(NSString *)firstName
                 lastName:(NSString *)lastName
                    email:(NSString *)email
                  address:(NSString *)address
                    phone:(NSString *)phone;

@end
