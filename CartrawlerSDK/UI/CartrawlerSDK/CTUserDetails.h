//
//  CTUserDetails.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 03/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTUserDetails : NSObject

@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *surname;
@property(nonatomic, strong) NSNumber *driverAge;
@property(nonatomic, strong) NSNumber *additionalPassengers;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *phone;
@property(nonatomic, strong) NSString *flightNo;
@property(nonatomic, strong) NSString *addressLine1;
@property(nonatomic, strong) NSString *addressLine2;
@property(nonatomic, strong) NSString *city;
@property(nonatomic, strong) NSString *postcode;
@property(nonatomic, strong) NSString *countryCode;
@property(nonatomic, strong) NSString *currency;
    
@end
