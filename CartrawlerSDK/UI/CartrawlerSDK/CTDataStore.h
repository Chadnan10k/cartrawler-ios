//
//  CTDataStore.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTRentalBooking.h"
#import "GTBooking.h"

@interface CTDataStore : NSObject

+ (void)storeRentalBooking:(CTRentalBooking *)booking;
+ (void)storeGTBooking:(GTBooking *)booking;

+ (NSArray<CTRentalBooking *> *)retrieveRentalBookings;
+ (NSArray<GTBooking *> *)retrieveGTBookings;

+ (BOOL)checkHasUpcomingBookings;

@end
