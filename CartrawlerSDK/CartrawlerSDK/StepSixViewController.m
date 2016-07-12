//
//  StepSixViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "StepSixViewController.h"

@interface StepSixViewController ()

@end

@implementation StepSixViewController

- (void)pushToStepSeven
{
    if (self.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.pickupLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.dropoffLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.pickupDate IS NOT SET \n\n");
        return;
    }
    
    if (self.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.dropoffDate IS NOT SET \n\n");
        return;
    }
    
    if (self.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.driverAge IS NOT SET \n\n");
        return;
    }
    
    if (self.cartrawlerAPI == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.cartrawlerAPI IS NOT SET \n\n");
        return;
    }
    
    if (self.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.vehicleAvailability IS NOT SET \n\n");
        return;
    }
    
    if (self.insurance == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.insurance IS NOT SET \n\n");
        return;
    }
    
    if (self.extras == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.extras IS NOT SET \n\n");
        return;
    }
    
    if (self.fullName == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.fullName IS NOT SET \n\n");
        return;
    }
    
    if (self.email == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.email IS NOT SET \n\n");
        return;
    }
    
    if (self.phone == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.phone IS NOT SET \n\n");
        return;
    }
    
    if (self.flightNumber == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.flightNumber IS NOT SET \n\n");
        return;
    }
    
//    if (self.stepSixViewController == nil) {
//        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.stepSixViewController IS NOT SET \n\n");
//        return;
//    }
}

@end
