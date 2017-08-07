//
//  CTSelectedVehicleRatingsViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleRatingsViewModel.h"

@interface CTSelectedVehicleRatingsViewModel ()
@property (nonatomic, readwrite) NSString *overallRating;
@property (nonatomic, readwrite) NSString *valueForMoney;
@property (nonatomic, readwrite) NSString *cleanliness;
@property (nonatomic, readwrite) NSString *service;
@property (nonatomic, readwrite) NSString *pickupProcess;
@property (nonatomic, readwrite) NSString *dropoffProcess;
@property (nonatomic, readwrite) NSString *averageWaitingTime;
@property (nonatomic, readwrite) NSString *customerRatings;
@end

@implementation CTSelectedVehicleRatingsViewModel

+ (instancetype)viewModelForState:(id)state {
    CTSelectedVehicleRatingsViewModel *viewModel = [CTSelectedVehicleRatingsViewModel new];
    return viewModel;
}

@end
