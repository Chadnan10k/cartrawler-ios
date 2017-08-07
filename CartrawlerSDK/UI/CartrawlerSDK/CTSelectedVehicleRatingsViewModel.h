//
//  CTSelectedVehicleRatingsViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"

@interface CTSelectedVehicleRatingsViewModel : NSObject <CTViewModelProtocol>

@property (nonatomic, readonly) NSString *overall;
@property (nonatomic, readonly) NSString *valueForMoney;
@property (nonatomic, readonly) NSString *cleanliness;
@property (nonatomic, readonly) NSString *service;
@property (nonatomic, readonly) NSString *pickupProcess;
@property (nonatomic, readonly) NSString *dropoffProcess;
@property (nonatomic, readonly) NSString *averageWaitingTime;
@property (nonatomic, readonly) NSString *customerRatings;

@property (nonatomic, readonly) NSString *overallRating;
@property (nonatomic, readonly) NSString *valueForMoneyRating;
@property (nonatomic, readonly) NSString *cleanlinessRating;
@property (nonatomic, readonly) NSString *serviceRating;
@property (nonatomic, readonly) NSString *pickupProcessRating;
@property (nonatomic, readonly) NSString *dropoffProcessRating;
@property (nonatomic, readonly) NSString *averageWaitingTimeRating;

@end
