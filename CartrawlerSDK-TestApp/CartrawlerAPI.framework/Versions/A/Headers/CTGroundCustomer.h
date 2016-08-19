//
//  CTGroundCustomer.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 24/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTCustomer.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  CTGroundCustomer
 */
@interface CTGroundCustomer : NSObject

/**
 *  Customers addesss line 1
 */
@property (nonatomic, nonnull, readonly) NSString *addressLine1;
/**
 *  Customers address line 2 if available
 */
@property (nonatomic, nonnull, readonly) NSString *addressLine2;
/**
 *  The town the customer lives in
 */
@property (nonatomic, nonnull, readonly) NSString *addressTown;
/**
 *  The city the customer lives in
 */
@property (nonatomic, nonnull, readonly) NSString *addressCity;
/**
 *  The customers post code if available
 */
@property (nonatomic, nonnull, readonly) NSString *addressPostCode;
/**
 *  The customers State / Province if available
 */
@property (nonatomic, nonnull, readonly) NSString *addressStateProvince;
/**
 *  The customers country code
 */
@property (nonatomic, nonnull, readonly) NSString *countryCode;
/**
 *  The customers country name
 */
@property (nonatomic, nonnull, readonly) NSString *countryName;
/**
 *  The customers email address
 */
@property (nonatomic, nonnull, readonly) NSString *email;
/**
 *  The customers phone numebr
 */
@property (nonatomic, nonnull, readonly) NSString *phone;
/**
 *  The customers first name
 */
@property (nonatomic, nonnull, readonly) NSString *firstName;
/**
 *  The customers surname
 */
@property (nonatomic, nonnull, readonly) NSString *surname;

/**
 *  Creates a CTGroundCustomer object
 *
 *  @param AddressLine1          The customer address line 1
 *  @param AddressLine2          The customer address line 2
 *  @param AddressTown           The customers town address
 *  @param AddressCity           The customers city address
 *  @param AddressPostCode       The customers post code if available
 *  @param AddressStateProvince The customers State / Provience eg. Florida, Leinster
 *  @param CountryCode           The customers country code eg. IE, US
 *  @param CountryName           the customer country name eg. Ireland
 *  @param Email                 The customers email
 *  @param Phone                 The customers phone number
 *  @param FirstName             the customers first name
 *  @param Surname               The customers surname
 *  @param NamePrefix            The customers name prefix
 *
 *  @return returns initialised object
 */
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
                   surname:(NSString *)surname;

@end

NS_ASSUME_NONNULL_END
