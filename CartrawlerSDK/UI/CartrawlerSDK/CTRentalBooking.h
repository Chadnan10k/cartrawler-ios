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

@property (nonatomic, strong) NSString *bookingId;
@property (nonatomic, readonly) NSString *pickupLocation;
@property (nonatomic, readonly) NSString *dropoffLocation;
@property (nonatomic, readonly) NSDate   *pickupDate;
@property (nonatomic, readonly) NSDate   *dropoffDate;
@property (nonatomic, readonly) NSString *vehicleImage;
@property (nonatomic, readonly) NSString *vehicleName;
@property (nonatomic, readonly) NSString *supplier;

- (instancetype)initFromSearch:(CTRentalSearch *)rentalSearch;

@end
