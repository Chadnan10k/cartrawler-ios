//
//  DataStore.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "DataStore.h"

@implementation DataStore

NSString * const RentalBookingKey = @"cartrawler_rental_bookings";
NSString * const GTBookingKey = @"cartrawler_gt_bookings";

+ (void)storeRentalBooking:(RentalBooking *)booking
{
    NSMutableArray<RentalBooking *> *arr = [[NSMutableArray alloc] initWithArray:[self retrieveRentalBookings]];
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

+ (NSArray<RentalBooking *> *)retrieveRentalBookings
{
    NSArray *data = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:RentalBookingKey]];
    return data ?: @[];
}

+(NSArray<GTBooking *> *)retrieveGTBookings
{
    NSArray *data = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:GTBookingKey]];
    return data ?: @[];
}

@end
