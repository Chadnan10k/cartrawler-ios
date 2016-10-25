//
//  DataStore.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RentalBooking.h"
#import "GTBooking.h"

@interface DataStore : NSObject

+ (void)storeRentalBooking:(RentalBooking *)booking;
+ (void)storeGTBooking:(GTBooking *)booking;

+ (NSArray<RentalBooking *> *)retrieveRentalBookings;
+ (NSArray<GTBooking *> *)retrieveGTBookings;

@end
