//
//  StepFourViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "StepFourViewController.h"

@interface StepFourViewController ()

@end

@implementation StepFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushToStepFive:(NSArray<CTExtraEquipment *> *)extras insuranceSelected:(BOOL)selected
{
    if (self.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.pickupLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.dropoffLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.pickupDate IS NOT SET \n\n");
        return;
    }
    
    if (self.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.dropoffDate IS NOT SET \n\n");
        return;
    }
    
    if (self.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.driverAge IS NOT SET \n\n");
        return;
    }
    
    if (self.cartrawlerAPI == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.cartrawlerAPI IS NOT SET \n\n");
        return;
    }
    
    if (self.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.vehicleAvailability IS NOT SET \n\n");
        return;
    }
    
    if (self.insurance == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.insurance IS NOT SET \n\n");
        return;
    }
    
    if (extras == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS extras IS NOT SET \n\n");
        return;
    }
    
    [self.stepFiveViewController setSelectedVehicle:self.selectedVehicle];
    [self.stepFiveViewController setPickupDate:self.pickupDate];
    [self.stepFiveViewController setDropoffDate:self.dropoffDate];
    [self.stepFiveViewController setPickupLocation:self.pickupLocation];
    [self.stepFiveViewController setDropoffLocation:self.dropoffLocation];
    [self.stepFiveViewController setDriverAge:self.driverAge];
    [self.stepFiveViewController setPassengerQty:self.passengerQty];
    [self.stepFiveViewController setCartrawlerAPI:self.cartrawlerAPI];
    [self.stepFiveViewController setInsurance:self.insurance];
    [self.stepFiveViewController setIsBuyingInsurance:selected];
    [self.stepFiveViewController setExtras:extras];
    [self.stepFiveViewController setStepSixViewController:self.stepSixViewController];
    [self.stepFiveViewController setStepSevenViewController:self.stepSevenViewController];

    [self.navigationController pushViewController:self.stepFiveViewController animated:YES];

}

@end
