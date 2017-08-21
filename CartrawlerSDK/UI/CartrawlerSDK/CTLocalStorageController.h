//
//  CTLocalStorageController.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 21/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTRentalBooking.h"

@interface CTLocalStorageController : NSObject

+ (void)storeRentalBooking:(CTRentalBooking *)booking;

+ (NSArray *)upcomingBookings;

@end
