//
//  StepTwoViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "StepTwoViewController.h"

@interface StepTwoViewController ()

@end

@implementation StepTwoViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushToStepThree:(CTVehicle *)vehicle
{
    [self.stepThreeViewController setSelectedVehicle:vehicle];
    [self.stepThreeViewController setPickupDate:self.pickupDate];
    [self.stepThreeViewController setDropoffDate:self.dropoffDate];
    [self.stepThreeViewController setPickupLocation:self.pickupLocation];
    [self.stepThreeViewController setDropoffLocation:self.dropoffLocation];
    [self.stepThreeViewController setDriverAge:self.driverAge];
    [self.stepThreeViewController setPassengerQty:self.passengerQty];

    [self.navigationController pushViewController:self.stepThreeViewController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
