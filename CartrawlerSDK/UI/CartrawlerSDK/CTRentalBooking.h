//
//  RentalBooking.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTRentalSearch.h"

@interface CTRentalBooking : NSObject <NSCoding>

@property (nonatomic, strong) NSString *bookingId;
@property (nonatomic, strong) NSString *pickupLocation;
@property (nonatomic, strong) NSString *dropoffLocation;
@property (nonatomic, strong) NSDate   *pickupDate;
@property (nonatomic, strong) NSDate   *dropoffDate;
@property (nonatomic, strong) NSString *vehicleImage;
@property (nonatomic, strong) NSString *vehicleName;

- (instancetype)initFromSearch:(CTRentalSearch *)rentalSearch;

@end
