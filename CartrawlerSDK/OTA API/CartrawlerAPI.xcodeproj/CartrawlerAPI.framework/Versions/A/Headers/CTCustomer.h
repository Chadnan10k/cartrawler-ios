//
//  Customer.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 15/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCustomer : NSObject

@property (nonatomic, strong) NSString *homeCountry;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSString *namePrefix;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *numberPrefix;
@property (nonatomic, strong) NSString *phone;

- (id)initWithHomeCountry:(NSString *)homeCountry
                      age:(NSNumber *)age
               namePrefix:(NSString *)namePrefix
                firstName:(NSString *)firstName
                 lastName:(NSString *)lastName
                    email:(NSString *)email
                  address:(NSString *)address
             numberPrefix:(NSString *)numberPrefix
                    phone:(NSString *)phone;

@end
