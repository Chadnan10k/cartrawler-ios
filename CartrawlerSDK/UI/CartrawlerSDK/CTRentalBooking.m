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
    _vehicleImage = [aDecoder decodeObjectForKey:@"vehicleImage"];
    _vehicleName = [aDecoder decodeObjectForKey:@"vehicleName"];
    _supplier = [aDecoder decodeObjectForKey:@"supplier"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.bookingId forKey:@"bookingId"];
    [aCoder encodeObject:self.pickupLocation forKey:@"pickupLocation"];
    [aCoder encodeObject:self.dropoffLocation forKey:@"dropoffLocation"];
    [aCoder encodeObject:self.pickupDate forKey:@"pickupDate"];
    [aCoder encodeObject:self.dropoffDate forKey:@"dropoffDate"];
    [aCoder encodeObject:self.vehicleImage forKey:@"vehicleImage"];
    [aCoder encodeObject:self.vehicleName forKey:@"vehicleName"];
    [aCoder encodeObject:self.supplier forKey:@"supplier"];
}

- (instancetype)initFromSearch:(CTRentalSearch *)rentalSearch
{
    self = [super init];
    _pickupLocation = rentalSearch.pickupLocation.name;
    _dropoffLocation = rentalSearch.dropoffLocation.name;
    _pickupDate = rentalSearch.pickupDate;
    _dropoffDate = rentalSearch.dropoffDate;
    _vehicleImage = rentalSearch.selectedVehicle.vehicle.pictureURL.absoluteString;
    _vehicleName = rentalSearch.selectedVehicle.vehicle.makeModelName;
    _supplier = rentalSearch.selectedVehicle.vendor.name;
    return self;
}

- (instancetype)initWithBookingID:(NSString *)bookingID
                   pickupLocation:(NSString *)pickupLocation
                  dropoffLocation:(NSString *)dropoffLocation
                       pickupDate:(NSDate *)pickupDate
                      dropoffDate:(NSDate *)dropoffDate
                     vehicleImage:(NSString *)vehicleImage
                      vehicleName:(NSString *)vehicleName
                         supplier:(NSString *)supplier {
    self = [super init];
    if (self) {
        _bookingId = bookingID;
        _pickupLocation = pickupLocation;
        _dropoffLocation = dropoffLocation;
        _pickupDate = pickupDate;
        _dropoffDate = dropoffDate;
        _vehicleImage = vehicleImage;
        _vehicleName = vehicleName;
        _supplier = supplier;
    }
    return self;
}

@end
