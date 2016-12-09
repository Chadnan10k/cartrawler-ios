//
//  CTDataStore.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTDataStore.h"

@implementation CTDataStore

NSString * const RentalBookingKey = @"cartrawler_rental_bookings";
NSString * const GTBookingKey = @"cartrawler_gt_bookings";
NSString * const PotentialBookingKey = @"cartrawler_potenital_booking";

+ (void)storeRentalBooking:(CTRentalBooking *)booking
{
    NSMutableArray<CTRentalBooking *> *arr = [[NSMutableArray alloc] initWithArray:[self retrieveRentalBookings]];
    [arr addObject:booking];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:arr];
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:RentalBookingKey];
}

+ (void)storeGTBooking:(GTBooking *)booking
{
    NSMutableArray<GTBooking *> *arr = [[NSMutableArray alloc] initWithArray:[self retrieveGTBookings]];
    [arr addObject:booking];
    NSArray *arrToStore = [[NSArray alloc] initWithArray:arr];
    [[NSUserDefaults standardUserDefaults] setObject:arrToStore forKey:GTBookingKey];
}

+ (NSArray<CTRentalBooking *> *)retrieveRentalBookings
{
    NSArray *data = [NSKeyedUnarchiver unarchiveObjectWithData:
                     [[NSUserDefaults standardUserDefaults] objectForKey:RentalBookingKey]];
    return data ?: @[];
}

+(NSArray<GTBooking *> *)retrieveGTBookings
{
    NSArray *data = [NSKeyedUnarchiver unarchiveObjectWithData:
                     [[NSUserDefaults standardUserDefaults] objectForKey:GTBookingKey]];
    return data ?: @[];
}

+ (BOOL)checkHasUpcomingBookings
{
    NSDate *refDate = [NSDate date];
    NSMutableArray <CTRentalBooking *> *filteredBookings = [NSMutableArray new];
    BOOL hasUpcomingDates = NO;
    for (CTRentalBooking *booking in [self retrieveRentalBookings]) {
        if (!([booking.pickupDate timeIntervalSinceDate:refDate] < -86400)) {
            [filteredBookings addObject:booking];
            hasUpcomingDates = YES;
        }
    }
    return hasUpcomingDates;
}

#pragma mark In Path

+ (void)cachePotentialInPathBooking:(CTRentalBooking *)potentialBooking
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:potentialBooking];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:PotentialBookingKey];
}

+ (void)didMakeInPathBooking:(NSString *)referenceNumber
{
    CTRentalBooking *potentialBooking = [NSKeyedUnarchiver unarchiveObjectWithData:
                                         [[NSUserDefaults standardUserDefaults] objectForKey:PotentialBookingKey]];
    
    if (potentialBooking) {
        potentialBooking.bookingId = referenceNumber;
        NSMutableArray<CTRentalBooking *> *arr = [[NSMutableArray alloc] initWithArray:[self retrieveRentalBookings]];
        [arr addObject:potentialBooking];
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:arr];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:RentalBookingKey];
    }
}

@end
