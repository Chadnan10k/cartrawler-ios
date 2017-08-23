//
//  RentalBooking.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTRentalBooking.h"
#import "CTRentalSearch.h"

@implementation CTRentalBooking

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    _bookingId = [aDecoder decodeObjectForKey:@"bookingId"];
    _pickupLocation = [aDecoder decodeObjectForKey:@"pickupLocation"];
    _dropoffLocation = [aDecoder decodeObjectForKey:@"dropoffLocation"];
    _pickupDate = [aDecoder decodeObjectForKey:@"pickupDate"];
    _dropoffDate = [aDecoder decodeObjectForKey:@"dropoffDate"];
    _driverName = [aDecoder decodeObjectForKey:@"driverName"];
    _driverEmail = [aDecoder decodeObjectForKey:@"driverEmail"];
    _driverPhoneNumber = [aDecoder decodeObjectForKey:@"driverPhoneNumber"];
    _insuranceIncluded = [aDecoder decodeObjectForKey:@"insuranceIncluded"];
    _vehicleName = [aDecoder decodeObjectForKey:@"vehicleName"];
    _seats = [aDecoder decodeObjectForKey:@"seats"];
    _bags = [aDecoder decodeObjectForKey:@"bags"];
    _doors = [aDecoder decodeObjectForKey:@"doors"];
    _transmission = [aDecoder decodeObjectForKey:@"transmission"];
    _extraFeatures = [aDecoder decodeObjectForKey:@"extraFeatures"];
    _vehicleURL = [aDecoder decodeObjectForKey:@"vehicleURL"];
    _vendorURL = [aDecoder decodeObjectForKey:@"vendorURL"];
    _carRentalAmount = [aDecoder decodeObjectForKey:@"carRentalAmount"];
    _insuranceAmount = [aDecoder decodeObjectForKey:@"insuranceAmount"];
    _totalAmount = [aDecoder decodeObjectForKey:@"totalAmount"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.bookingId forKey:@"bookingId"];
    [aCoder encodeObject:self.pickupLocation forKey:@"pickupLocation"];
    [aCoder encodeObject:self.dropoffLocation forKey:@"dropoffLocation"];
    [aCoder encodeObject:self.pickupDate forKey:@"pickupDate"];
    [aCoder encodeObject:self.dropoffDate forKey:@"dropoffDate"];
    [aCoder encodeObject:self.driverName forKey:@"driverName"];
    [aCoder encodeObject:self.driverEmail forKey:@"driverEmail"];
    [aCoder encodeObject:self.driverPhoneNumber forKey:@"driverPhoneNumber"];
    [aCoder encodeObject:self.insuranceIncluded forKey:@"insuranceIncluded"];
    [aCoder encodeObject:self.vehicleName forKey:@"vehicleName"];
    [aCoder encodeObject:self.seats forKey:@"seats"];
    [aCoder encodeObject:self.bags forKey:@"bags"];
    [aCoder encodeObject:self.doors forKey:@"doors"];
    [aCoder encodeObject:self.transmission forKey:@"transmission"];
    [aCoder encodeObject:self.extraFeatures forKey:@"extraFeatures"];
    [aCoder encodeObject:self.vehicleURL forKey:@"vehicleURL"];
    [aCoder encodeObject:self.vendorURL forKey:@"vendorURL"];
    [aCoder encodeObject:self.carRentalAmount forKey:@"carRentalAmount"];
    [aCoder encodeObject:self.insuranceAmount forKey:@"insuranceAmount"];
    [aCoder encodeObject:self.totalAmount forKey:@"totalAmount"];
}

- (instancetype)initFromSearch:(CTRentalSearch *)rentalSearch
{
    self = [super init];
    _pickupLocation = rentalSearch.pickupLocation.name;
    _dropoffLocation = rentalSearch.dropoffLocation.name;
    _pickupDate = rentalSearch.pickupDate;
    _dropoffDate = rentalSearch.dropoffDate;
    _vehicleName = rentalSearch.selectedVehicle.vehicle.makeModelName;
    return self;
}

- (instancetype)initWithBookingID:(NSString *)bookingID
                   pickupLocation:(NSString *)pickupLocation
                  dropoffLocation:(NSString *)dropoffLocation
                       pickupDate:(NSDate *)pickupDate
                      dropoffDate:(NSDate *)dropoffDate
                       driverName:(NSString *)driverName
                      driverEmail:(NSString *)driverEmail
                driverPhoneNumber:(NSString *)driverPhoneNumber
                insuranceIncluded:(NSString *)insuranceIncluded
                      vehicleName:(NSString *)vehicleName
                            seats:(NSString *)seats
                             bags:(NSString *)bags
                            doors:(NSString *)doors
                     transmission:(NSString *)transmission
                    extraFeatures:(NSString *)extraFeatures
                       vehicleURL:(NSString *)vehicleURL
                        vendorURL:(NSString *)vendorURL
                  carRentalAmount:(NSString *)carRentalAmount
                  insuranceAmount:(NSString *)insuranceAmount
                      totalAmount:(NSString *)totalAmount {
    self = [super init];
    if (self) {
        _bookingId = bookingID;
        _pickupLocation = pickupLocation;
        _dropoffLocation = dropoffLocation;
        _pickupDate = pickupDate;
        _dropoffDate = dropoffDate;
        _driverName = driverName;
        _driverEmail = driverEmail;
        _driverPhoneNumber = driverPhoneNumber;
        _insuranceIncluded = insuranceIncluded;
        _vehicleName = vehicleName;
        _seats = seats;
        _bags = bags;
        _doors = doors;
        _transmission = transmission;
        _extraFeatures = extraFeatures;
        _vehicleURL = vehicleURL;
        _vendorURL = vendorURL;
        _carRentalAmount = carRentalAmount;
        _insuranceAmount = insuranceAmount;
        _totalAmount = totalAmount;
    }
    return self;
}

@end
