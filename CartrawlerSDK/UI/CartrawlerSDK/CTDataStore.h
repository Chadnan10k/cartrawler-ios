//
//  CTDataStore.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTRentalBooking.h"

@interface CTDataStore : NSObject

+ (void)storeRentalBooking:(CTRentalBooking *)booking;
+ (NSArray<CTRentalBooking *> *)retrieveRentalBookings;

+ (BOOL)checkHasUpcomingBookings;

/*
 For In Path
*/
+ (void)cachePotentialInPathBooking:(CTRentalBooking *)potentialBooking;
+ (void)removePotentialInPathBooking;
+ (void)didMakeInPathBooking:(NSString *)referenceNumber;
+ (void)deletePotentialInPathBooking;

@end
