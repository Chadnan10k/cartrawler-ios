//
//  StepOneViewController.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "StepTwoViewController.h"
#import "StepThreeViewController.h"
#import "StepFourViewController.h"

@interface StepOneViewController : UIViewController

typedef void (^StepOneCompletion)(BOOL success, NSString *errorMessage);

@property (nonatomic) StepOneCompletion stepOneCompletion;

//These properties must be set

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

- (void)pushToStepTwo;

+ (void)forceLinkerLoad_;

@end
