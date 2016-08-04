//
//  CTSearch.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSearch.h"

@implementation CTSearch

+ (instancetype)instance
{
    static CTSearch *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CTSearch alloc] init];
    });
    return sharedInstance;
}

- (void)reset
{
    _vehicleAvailability = nil;
    _selectedVehicle = nil;
    _pickupLocation = nil;
    _dropoffLocation = nil;
    _pickupDate = nil;
    _dropoffDate = nil;
    _driverAge = nil;
    _passengerQty = nil;
    _insurance = nil;
    _insuranceItem = nil;
    _isBuyingInsurance = NO;
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
}

@end
