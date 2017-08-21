//
//  CTLocalStorageController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 21/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTLocalStorageController.h"
#import "CTDataStore.h"

NSString * const CTRentalBookingKey = @"cartrawler_rental_bookings";

@implementation CTLocalStorageController

+ (void)storeRentalBooking:(CTRentalBooking *)booking {
    NSMutableArray<CTRentalBooking *> *arr = [[NSMutableArray alloc] initWithArray:[self retrieveRentalBookings]];
    [arr addObject:booking];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:arr];
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:CTRentalBookingKey];
}

+ (NSArray *)upcomingBookings {
    NSDate *refDate = [NSDate date];
    NSMutableArray <CTRentalBooking *> *filteredBookings = [NSMutableArray new];
    for (CTRentalBooking *booking in [self retrieveRentalBookings]) {
        if (!([booking.pickupDate timeIntervalSinceDate:refDate] < -86400)) {
            [filteredBookings addObject:booking];
        }
    }
    return filteredBookings.copy;
}

+ (NSArray<CTRentalBooking *> *)retrieveRentalBookings {
    NSArray *data = [NSKeyedUnarchiver unarchiveObjectWithData:
                     [[NSUserDefaults standardUserDefaults] objectForKey:CTRentalBookingKey]];
    return data ?: @[];
}

@end
