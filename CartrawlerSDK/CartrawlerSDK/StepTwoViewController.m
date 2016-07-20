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

- (void)pushToStepThree:(CTVehicle *)vehicle
{
    
    if (self.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.pickupLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.dropoffLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.pickupDate IS NOT SET \n\n");
        return;
    }
    
    if (self.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.dropoffDate IS NOT SET \n\n");
        return;
    }
    
    if (self.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.driverAge IS NOT SET \n\n");
        return;
    }
    
    if (self.cartrawlerAPI == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.cartrawlerAPI IS NOT SET \n\n");
        return;
    }
    
    if (self.vehicleAvailability == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.vehicleAvailability IS NOT SET \n\n");
        return;
    }
    
    if (self.stepThreeViewController == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.stepThreeViewController IS NOT SET \n\n");
        return;
    }
    
    if (self.stepFourViewController == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.stepFourViewController IS NOT SET \n\n");
        return;
    }
    
    [self.stepThreeViewController setSelectedVehicle:vehicle];
    [self.stepThreeViewController setPickupDate:self.pickupDate];
    [self.stepThreeViewController setDropoffDate:self.dropoffDate];
    [self.stepThreeViewController setPickupLocation:self.pickupLocation];
    [self.stepThreeViewController setDropoffLocation:self.dropoffLocation];
    [self.stepThreeViewController setDriverAge:self.driverAge];
    [self.stepThreeViewController setPassengerQty:self.passengerQty];
    [self.stepThreeViewController setCartrawlerAPI:self.cartrawlerAPI];
    [self.stepThreeViewController setStepFourViewController:self.stepFourViewController];
    [self.stepThreeViewController setStepFiveViewController:self.stepFiveViewController];
    [self.stepThreeViewController setStepSixViewController:self.stepSixViewController];
    [self.stepThreeViewController setStepSevenViewController:self.stepSevenViewController];

    [self.navigationController pushViewController:self.stepThreeViewController animated:YES];
}

- (void)refresh
{
    
}

@end
