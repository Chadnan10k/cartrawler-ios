//
//  StepThreeViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 01/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "StepThreeViewController.h"
#import "CTSDKSettings.h"

@interface StepThreeViewController ()

@end

@implementation StepThreeViewController

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

- (void)pushToStepFour
{

    if (self.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FOUR AS self.pickupLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FOUR AS self.dropoffLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FOUR AS self.pickupDate IS NOT SET \n\n");
        return;
    }
    
    if (self.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FOUR AS self.dropoffDate IS NOT SET \n\n");
        return;
    }
    
    if (self.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FOUR AS self.driverAge IS NOT SET \n\n");
        return;
    }
    
    if (self.cartrawlerAPI == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FOUR AS self.cartrawlerAPI IS NOT SET \n\n");
        return;
    }
    
    if (self.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FOUR AS self.vehicleAvailability IS NOT SET \n\n");
        return;
    }
    
    if (self.stepFourViewController == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FOUR AS self.stepFourViewController IS NOT SET \n\n");
        return;
    }
    
    [self.stepFourViewController setSelectedVehicle:self.selectedVehicle];
    [self.stepFourViewController setPickupDate:self.pickupDate];
    [self.stepFourViewController setDropoffDate:self.dropoffDate];
    [self.stepFourViewController setPickupLocation:self.pickupLocation];
    [self.stepFourViewController setDropoffLocation:self.dropoffLocation];
    [self.stepFourViewController setDriverAge:self.driverAge];
    [self.stepFourViewController setPassengerQty:self.passengerQty];
    [self.stepFourViewController setCartrawlerAPI:self.cartrawlerAPI];
    [self.stepFourViewController setStepFiveViewController:self.stepFiveViewController];
    [self.stepFourViewController setStepSixViewController:self.stepSixViewController];
    [self.stepFourViewController setStepSevenViewController:self.stepSevenViewController];

    [self.cartrawlerAPI requestInsuranceQuoteForVehicle:[CTSDKSettings instance].homeCountryCode
                                               currency:[CTSDKSettings instance].currencyCode
                                              totalCost:[NSString stringWithFormat:@"%.02f", self.selectedVehicle.totalPriceForThisVehicle.doubleValue]
                                         pickupDateTime:self.pickupDate
                                         returnDateTime:self.dropoffDate
                                 destinationCountryCode:self.pickupLocation.codeContext
                                             completion:^(CTInsurance *response, CTErrorResponse *error) {
                                                 if (response) {
                                                     
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         [self.stepFourViewController setInsurance:response];
                                                         [self.navigationController pushViewController:self.stepFourViewController animated:YES];
                                                     });
                                                     
                                                 } else {
                                                     NSLog(@"ERROR: CANNOT PUSH TO STEP FOUR AS %@", error.errorMessage);
                                                 }
                                             }];
    
}

@end
