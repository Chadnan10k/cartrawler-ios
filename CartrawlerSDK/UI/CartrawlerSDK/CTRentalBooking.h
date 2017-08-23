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
@property (nonatomic, readonly) NSString *driverName;
@property (nonatomic, readonly) NSString *driverEmail;
@property (nonatomic, readonly) NSString *driverPhoneNumber;
@property (nonatomic, readonly) NSString *insuranceIncluded;
@property (nonatomic, readonly) NSString *vehicleName;
@property (nonatomic, readonly) NSString *seats;
@property (nonatomic, readonly) NSString *bags;
@property (nonatomic, readonly) NSString *doors;
@property (nonatomic, readonly) NSString *transmission;
@property (nonatomic, readonly) NSString *extraFeatures;
@property (nonatomic, readonly) NSString *vehicleURL;
@property (nonatomic, readonly) NSString *vendorURL;
@property (nonatomic, readonly) NSString *carRentalAmount;
@property (nonatomic, readonly) NSString *insuranceAmount;
@property (nonatomic, readonly) NSString *totalAmount;

- (instancetype)initFromSearch:(CTRentalSearch *)rentalSearch;

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
                      totalAmount:(NSString *)totalAmount;


@end
