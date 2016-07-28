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

- (void)pushToStepThree
{
    
    if (self.search.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.pickupLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.search.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.dropoffLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.search.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.pickupDate IS NOT SET \n\n");
        return;
    }
    
    if (self.search.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.dropoffDate IS NOT SET \n\n");
        return;
    }
    
    if (self.search.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.driverAge IS NOT SET \n\n");
        return;
    }
    
    if (self.cartrawlerAPI == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.cartrawlerAPI IS NOT SET \n\n");
        return;
    }
    
    if (self.search.vehicleAvailability == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.vehicleAvailability IS NOT SET \n\n");
        return;
    }
    
    [self.navigationController pushViewController:self.destinationViewController animated:YES];
}

- (void)refresh
{
    
}

@end
