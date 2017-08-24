//
//  CTRentalSearch.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartrawlerAPI.h"

@interface CTRentalSearch : NSObject <NSCopying>

@property (nonatomic, strong) CTVehicleAvailability *vehicleAvailability;
@property (nonatomic, strong) CTAvailabilityItem *selectedVehicle;
@property (nonatomic, strong) CTMatchedLocation *pickupLocation;
@property (nonatomic, strong) CTMatchedLocation *dropoffLocation;
@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSDate *dropoffDate;
@property (nonatomic, strong) NSNumber *driverAge;
@property (nonatomic, strong) NSNumber *passengerQty;
@property (nonatomic, strong) CTInsurance *insurance;
@property (nonatomic, strong) CTInsuranceSelectorItem *insuranceItem;
@property (nonatomic) BOOL isBuyingInsurance;
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
@property (nonatomic, strong) CTBooking *booking;

@property (nonatomic, strong, readonly) NSString *concatinatedAddress;

+ (instancetype)instance;

- (void)setFromCopy:(CTRentalSearch *)copy;

- (void)reset;

- (void)resetUserSelections;

- (void)setEngineInfoFromAvail;

@end
