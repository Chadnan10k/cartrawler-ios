//
//  StepFiveViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 11/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "StepFiveViewController.h"

@interface StepFiveViewController ()

@end

@implementation StepFiveViewController

- (void)pushToStepSix
{
    if (self.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SIX AS self.pickupLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SIX AS self.dropoffLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SIX AS self.pickupDate IS NOT SET \n\n");
        return;
    }
    
    if (self.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SIX AS self.dropoffDate IS NOT SET \n\n");
        return;
    }
    
    if (self.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SIX AS self.driverAge IS NOT SET \n\n");
        return;
    }
    
    if (self.cartrawlerAPI == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SIX AS self.cartrawlerAPI IS NOT SET \n\n");
        return;
    }
    
    if (self.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SIX AS self.vehicleAvailability IS NOT SET \n\n");
        return;
    }
    
    if (self.insurance == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SIX AS self.insurance IS NOT SET \n\n");
        return;
    }
    
    if (self.extras == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SIX AS self.extras IS NOT SET \n\n");
        return;
    }
    
    if (self.stepSixViewController == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SIX AS self.stepSixViewController IS NOT SET \n\n");
        return;
    }
    
    [self.stepSixViewController setSelectedVehicle:self.selectedVehicle];
    [self.stepSixViewController setPickupDate:self.pickupDate];
    [self.stepSixViewController setDropoffDate:self.dropoffDate];
    [self.stepSixViewController setPickupLocation:self.pickupLocation];
    [self.stepSixViewController setDropoffLocation:self.dropoffLocation];
    [self.stepSixViewController setDriverAge:self.driverAge];
    [self.stepSixViewController setPassengerQty:self.passengerQty];
    [self.stepSixViewController setCartrawlerAPI:self.cartrawlerAPI];
    [self.stepSixViewController setInsurance:self.insurance];
    [self.stepSixViewController setIsBuyingInsurance:self.isBuyingInsurance];
    [self.stepSixViewController setExtras:self.extras];
    
    [self.navigationController pushViewController:self.stepSixViewController animated:YES];
}

@end
