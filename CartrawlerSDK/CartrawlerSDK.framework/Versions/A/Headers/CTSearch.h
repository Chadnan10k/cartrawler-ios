//
//  CTSearch.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "StepTwoViewController.h"
#import "StepThreeViewController.h"
#import "StepFourViewController.h"
#import "StepFiveViewController.h"
#import "StepSixViewController.h"
#import "StepSevenViewController.h"

@interface CTSearch : NSObject

@property (nonatomic, strong) CTMatchedLocation *pickupLocation;
@property (nonatomic, strong) CTMatchedLocation *dropoffLocation;
@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSDate *dropoffDate;
@property (nonatomic, strong) NSNumber *driverAge;
@property (nonatomic, strong) NSNumber *passengerQty;
@property (nonatomic, strong) CTVehicleAvailability *vehicleAvailability;
@property (nonatomic, strong) StepTwoViewController *stepTwoViewController;
@property (nonatomic, strong) StepThreeViewController *stepThreeViewController;
@property (nonatomic, strong) StepFourViewController *stepFourViewController;
@property (nonatomic, strong) StepFiveViewController *stepFiveViewController;
@property (nonatomic, strong) StepSixViewController *stepSixViewController;
@property (nonatomic, strong) StepSevenViewController *stepSevenViewController;

@end
