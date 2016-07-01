//
//  StepTwoViewController.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTMatchedLocation.h>
#import <CartrawlerAPI/CTVehicleAvailability.h>
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface StepTwoViewController : UIViewController

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;
@property (nonatomic, strong) CTMatchedLocation *pickupLocation;
@property (nonatomic, strong) CTMatchedLocation *dropoffLocation;
@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSDate *dropoffDate;
@property (nonatomic, strong) NSNumber *driverAge;
@property (nonatomic, strong) CTVehicleAvailability *vehicleAvailability;

+ (void)forceLinkerLoad_;

- (void)pushToStepThree;

@end
