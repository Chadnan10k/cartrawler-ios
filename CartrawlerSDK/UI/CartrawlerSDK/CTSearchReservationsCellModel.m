//
//  CTSearchReservationsCellModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 21/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchReservationsCellModel.h"
#import "CartrawlerSDK+NSDateUtils.h"

@interface CTSearchReservationsCellModel ()
@property (nonatomic, readwrite) UIColor *primaryColor;
@property (nonatomic, readwrite) UIColor *secondaryColor;
@property (nonatomic, readwrite) NSString *button;
@property (nonatomic, readwrite) NSString *trip;
@property (nonatomic, readwrite) NSString *destination;
@property (nonatomic, readwrite) NSString *dates;
@property (nonatomic, readwrite) CTRentalBooking *booking;
@end

@implementation CTSearchReservationsCellModel

+ (instancetype)viewModelForBooking:(CTRentalBooking *)rentalBooking
                       primaryColor:(UIColor *)primaryColor
                     secondaryColor:(UIColor *)secondaryColor {
    CTSearchReservationsCellModel *cellModel = [CTSearchReservationsCellModel new];
    cellModel.primaryColor = primaryColor;
    cellModel.secondaryColor = secondaryColor;
    cellModel.button = @"View booking";
    cellModel.trip = @"Trip to";
    cellModel.destination = rentalBooking.pickupLocation;
    cellModel.dates = [NSString stringWithFormat:@"%@ - %@", [rentalBooking.pickupDate shortDescriptionFromDate], [rentalBooking.dropoffDate shortDescriptionFromDate]];
    cellModel.booking = rentalBooking;
    return cellModel;
}

@end
