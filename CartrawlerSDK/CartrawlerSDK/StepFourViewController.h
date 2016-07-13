//
//  StepFourViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "StepFiveViewController.h"
#import "StepSixViewController.h"
#import "StepSevenViewController.h"

@interface StepFourViewController : UIViewController

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;
@property (nonatomic, strong) CTVehicle *selectedVehicle;
@property (nonatomic, strong) CTMatchedLocation *pickupLocation;
@property (nonatomic, strong) CTMatchedLocation *dropoffLocation;
@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSDate *dropoffDate;
@property (nonatomic, strong) NSNumber *driverAge;
@property (nonatomic, strong) NSNumber *passengerQty;
@property (nonatomic, strong) CTInsurance *insurance;
@property (nonatomic, strong) StepFiveViewController *stepFiveViewController;
@property (nonatomic, strong) StepSixViewController *stepSixViewController;
@property (nonatomic, strong) StepSevenViewController *stepSevenViewController;

- (void)pushToStepFive:(NSArray<CTExtraEquipment *> *)extras insuranceSelected:(BOOL)selected;

@end
