//
//  StepOneViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "StepOneViewController.h"
#import "StepTwoViewController.h"

@interface StepOneViewController ()

@end

@implementation StepOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushToStepTwo
{
    if (self.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.pickupLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.dropoffLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.pickupDate IS NOT SET \n\n");
        return;
    }
    
    if (self.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.dropoffDate IS NOT SET \n\n");
        return;
    }
    
    if (self.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.driverAge IS NOT SET \n\n");
        return;
    }
    
    self.stepTwoViewController.cartrawlerAPI = self.cartrawlerAPI;
    self.stepTwoViewController.pickupLocation = self.pickupLocation;
    self.stepTwoViewController.dropoffLocation = self.dropoffLocation;
    self.stepTwoViewController.pickupDate = self.pickupDate;
    self.stepTwoViewController.dropoffDate = self.dropoffDate;
    self.stepTwoViewController.driverAge = self.driverAge;
    self.stepTwoViewController.vehicleAvailability = self.vehicleAvailability;
    
    [self.navigationController pushViewController:self.stepTwoViewController animated:YES];
}

+ (void)forceLinkerLoad_
{
    
}

@end
