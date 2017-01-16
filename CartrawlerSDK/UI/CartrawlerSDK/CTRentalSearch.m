//
//  CTRentalSearch.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTRentalSearch.h"
#import "CTSDKSettings.h"

@implementation CTRentalSearch

+ (instancetype)instance
{
    static CTRentalSearch *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CTRentalSearch alloc] init];
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
    _driverAge = [NSNumber numberWithInteger:0];
    _passengerQty = [NSNumber numberWithInteger:1];
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
    [CTSDKSettings instance].queryID = @"";
}

- (void)setEngineInfoFromAvail
{
    if (self.vehicleAvailability) {
        if (self.vehicleAvailability.items.firstObject) {
            if (self.vehicleAvailability.items.firstObject.engineInfo.queryID) {
                [CTSDKSettings instance].queryID = self.vehicleAvailability.items.firstObject.engineInfo.queryID;
            }
        }
    }
}

- (NSString *)concatinatedAddress
{
    if (![self.addressLine2 isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%@, %@, %@, %@, %@", self.addressLine1, self.addressLine2, self.city, self.postcode, self.country];
    } else {
        return [NSString stringWithFormat:@"%@, %@, %@, %@", self.addressLine1, self.city, self.postcode, self.country];
    }
}

- (void)setFromCopy:(CTRentalSearch *)copy
{
    self.vehicleAvailability = copy.vehicleAvailability;
    self.selectedVehicle = copy.selectedVehicle;
    self.pickupLocation = copy.pickupLocation;
    self.dropoffLocation = copy.dropoffLocation;
    self.pickupDate = copy.pickupDate;
    self.dropoffDate = copy.dropoffDate;
    self.driverAge = copy.driverAge;
    self.passengerQty = copy.passengerQty;
    self.insurance = copy.insurance;
    self.insuranceItem = copy.insuranceItem;
    self.isBuyingInsurance = copy.isBuyingInsurance;
    self.firstName = copy.firstName;
    self.surname = copy.surname;
    self.email = copy.email;
    self.phone = copy.phone;
    self.flightNumber = copy.flightNumber;
    self.addressLine1 = copy.addressLine1;
    self.addressLine2 = copy.addressLine2;
    self.city = copy.city;
    self.postcode = copy.postcode;
    self.country = copy.country;
}

- (id)copyWithZone:(NSZone *)zone
{
    CTRentalSearch *copy = [[[self class] alloc] init];
    
    if (copy) {
        copy.vehicleAvailability = self.vehicleAvailability;
        copy.selectedVehicle = self.selectedVehicle;
        copy.pickupLocation = self.pickupLocation;
        copy.dropoffLocation = self.dropoffLocation;
        copy.pickupDate = self.pickupDate;
        copy.dropoffDate = self.dropoffDate;
        copy.driverAge = self.driverAge;
        copy.passengerQty = self.passengerQty;
        copy.insurance = self.insurance;
        copy.insuranceItem = self.insuranceItem;
        copy.isBuyingInsurance = self.isBuyingInsurance;
        copy.firstName = self.firstName;
        copy.surname = self.surname;
        copy.email = self.email;
        copy.phone = self.phone;
        copy.flightNumber = self.flightNumber;
        copy.addressLine1 = self.addressLine1;
        copy.addressLine2 = self.addressLine2;
        copy.city = self.city;
        copy.postcode = self.postcode;
        copy.country = self.country;
    }
    
    return copy;
}

@end
