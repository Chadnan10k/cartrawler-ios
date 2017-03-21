//
//  CTPassenger.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 20/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTPassenger : NSObject

@property (nonatomic, strong, readwrite, nonnull) NSString *firstName;
@property (nonatomic, strong, readwrite, nonnull) NSString *lastName;
@property (nonatomic, strong, readwrite, nonnull) NSString *addressLine1;
@property (nonatomic, strong, readwrite, nonnull) NSString *addressLine2;
@property (nonatomic, strong, readwrite, nonnull) NSString *city;
@property (nonatomic, strong, readwrite, nonnull) NSString *postcode;
@property (nonatomic, strong, readwrite, nonnull) NSString *countryCode;
@property (nonatomic, strong, readwrite, nonnull) NSNumber *age;
@property (nonatomic, strong, readwrite, nonnull) NSString *email;
@property (nonatomic, strong, readwrite, nonnull) NSString *phone;
@property (nonatomic, readwrite) BOOL isPrimaryDriver;


/**
 Designated initialiser for CTPassenger

 @param firstName The passengers first name
 @param lastName The passengers last name
 @param addressLine1 The passengers address
 @param addressLine2 The passengers address (cont. if available)
 @param city The passengers city of residence
 @param postcode The passengers postcode
 @param countryCode The passengers country code
 @param age the passengers age
 @param isPrimaryDriver Bool to state is the passenger is the lead driver
 @return CTPassenger
 */
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
                                isPrimaryDriver:(BOOL)isPrimaryDriver;

@end
