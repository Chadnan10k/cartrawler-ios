//
//  CTReservationsState.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 21/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTRentalBooking.h"

@interface CTReservationsState : NSObject

@property (nonatomic) NSArray <CTRentalBooking *> *reservations;
@property (nonatomic) CTRentalBooking *selectedReservation;
@end
