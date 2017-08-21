//
//  CTSearchReservationsCellModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 21/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTRentalBooking.h"

@interface CTSearchReservationsCellModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) UIColor *primaryColor;
@property (nonatomic, readonly) UIColor *secondaryColor;
@property (nonatomic, readonly) NSString *button;
@property (nonatomic, readonly) NSString *trip;
@property (nonatomic, readonly) NSString *destination;
@property (nonatomic, readonly) NSString *dates;
@property (nonatomic, readonly) CTRentalBooking *booking;

+ (instancetype)viewModelForBooking:(CTRentalBooking *)rentalBooking primaryColor:(UIColor *)primaryColor secondaryColor:(UIColor *)secondaryColor;
@end
