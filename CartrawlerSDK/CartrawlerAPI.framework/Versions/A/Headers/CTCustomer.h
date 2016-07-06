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
 *  Name Prefix enum
 */
typedef NS_ENUM(NSUInteger, NamePrefix) {
    /**
     *  Mr. Title
     */
    NamePrefixMr = 0,
    /**
     *  Mrs. Title
     */
    NamePrefixMrs = 1,
    /**
     *  Miss. Title
     */
    NamePrefixMiss = 2
};

/**
 *  the Customers age
 */
@property (nonatomic, strong) NSNumber *age;
/**
 *  The customers home country
 */
@property (nonatomic, strong) NSString *homeCountry;
/**
 *  The customers name prefix in string form
 */
@property (nonatomic, strong) NSString *namePrefix;
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
 *  The customers number prefix
 */
@property (nonatomic, strong) NSString *numberPrefix;
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
               namePrefix:(NamePrefix)namePrefix
                firstName:(NSString *)firstName
                 lastName:(NSString *)lastName
                    email:(NSString *)email
                  address:(NSString *)address
             numberPrefix:(NSString *)numberPrefix
                    phone:(NSString *)phone;

/**
 *  Convenience method for using the NamePrefix enum
 *
 *  @param namePrefix The name prefix
 *
 *  @return Returns a NamePrefix
 */
+ (NamePrefix)namePrefix:(NamePrefix)namePrefix;

/**
 *  Convenience method for using the NamePrefix enum int value
 *
 *  @param namePrefix The name prefix int value
 *
 *  @return Returns a NamePrefix
 */
+ (NamePrefix)namePrefixFromInt:(NSInteger)namePrefix;

/**
 *  Convenience method for using the NamePrefix enum
 *
 *  @param namePrefix The name prefix
 *
 *  @return Returns a NamePrefix string value
 */
+ (NSString *)namePrefixString:(NamePrefix)namePrefix;

@end
