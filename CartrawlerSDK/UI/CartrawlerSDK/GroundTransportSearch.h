//
//  GroundTransportSearch.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface GroundTransportSearch : NSObject

@property (nonatomic, strong) CTGroundAvailability *availability;
@property (nonatomic, strong) CTGroundService *selectedService;
@property (nonatomic, strong) CTGroundShuttle *selectedShuttle;
@property (nonatomic, strong) CTAirport *airport;
@property (nonatomic, strong) CTGroundLocation *pickupLocation;
@property (nonatomic, strong) CTGroundLocation *dropoffLocation;
@property (nonatomic) BOOL airportIsPickupLocation;
@property (nonatomic, strong) NSNumber *adultQty;
@property (nonatomic, strong) NSNumber *childQty;
@property (nonatomic, strong) NSNumber *infantQty;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *surname;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *flightNumber;
@property (nonatomic, strong) NSString *addressLine1;
@property (nonatomic, strong) NSString *addressLine2;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *postcode;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *specialInstructions;

+ (instancetype)instance;

- (void)reset;

@end
