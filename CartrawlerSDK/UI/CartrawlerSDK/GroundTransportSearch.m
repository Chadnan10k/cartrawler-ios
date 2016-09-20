//
//  GroundTransportSearch.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GroundTransportSearch.h"

@implementation GroundTransportSearch


+ (instancetype)instance
{
    static GroundTransportSearch *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GroundTransportSearch alloc] init];
    });
    return sharedInstance;
}

- (void)reset
{
    _availability = nil;
    _selectedService = nil;
    _selectedShuttle = nil;
    _airport = nil;
    _pickupLocation = nil;
    _dropoffLocation = nil;
    _airportIsPickupLocation = nil;
    _returnTrip = nil;
    _adultQty = nil;
    _childQty = nil;
    _infantQty = nil;
    _firstName = nil;
    _surname = nil;
    _email = nil;
    _phone = nil;
    _flightNumber = nil;
    _addressLine1 = nil;
    _addressLine2 = nil;
    _city = nil;
    _postcode = nil;
    _country = nil;
    _countryCode = nil;
    _specialInstructions = nil;
    _booking = nil;
}

@end
