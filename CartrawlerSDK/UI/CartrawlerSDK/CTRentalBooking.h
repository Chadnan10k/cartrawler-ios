//
//  RentalBooking.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CTRentalSearch;

@interface CTRentalBooking : NSObject <NSCoding>

@property (nonatomic, readonly) NSString *bookingId;
@property (nonatomic, readonly) NSString *pickupLocation;
@property (nonatomic, readonly) NSString *dropoffLocation;
@property (nonatomic, readonly) NSDate   *pickupDate;
@property (nonatomic, readonly) NSDate   *dropoffDate;
@property (nonatomic, readonly) NSString *vehicleImage;
@property (nonatomic, readonly) NSString *vehicleName;
@property (nonatomic, readonly) NSString *supplier;

- (instancetype)initFromSearch:(CTRentalSearch *)rentalSearch;

- (instancetype)initWithBookingID:(NSString *)bookingID
                   pickupLocation:(NSString *)pickupLocation
                  dropoffLocation:(NSString *)dropoffLocation
                       pickupDate:(NSDate *)pickupDate
                      dropoffDate:(NSDate *)dropoffDate
                     vehicleImage:(NSString *)vehicleImage
                      vehicleName:(NSString *)vehicleName
                         supplier:(NSString *)supplier;

@end
