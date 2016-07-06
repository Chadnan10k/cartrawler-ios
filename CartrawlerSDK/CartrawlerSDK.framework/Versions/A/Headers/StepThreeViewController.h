//
//  StepThreeViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 01/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTVehicle.h>
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "StepFourViewController.h"

@interface StepThreeViewController : UIViewController

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic, strong) CTVehicle *selectedVehicle;
@property (nonatomic, strong) CTMatchedLocation *pickupLocation;
@property (nonatomic, strong) CTMatchedLocation *dropoffLocation;
@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSDate *dropoffDate;
@property (nonatomic, strong) NSNumber *driverAge;
@property (nonatomic, strong) NSNumber *passengerQty;
@property (nonatomic, strong) StepFourViewController *stepFourViewController;

+ (void)forceLinkerLoad_;

- (void)pushToStepFour;

@end
