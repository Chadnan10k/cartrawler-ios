//
//  StepOneViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "StepOneViewController.h"
#import "StepTwoViewController.h"
#import "CTSDKSettings.h"

@interface StepOneViewController ()

@end

@implementation StepOneViewController

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
    
    self.stepTwoViewController.pickupLocation = self.pickupLocation;
    self.stepTwoViewController.dropoffLocation = self.dropoffLocation;
    self.stepTwoViewController.pickupDate = self.pickupDate;
    self.stepTwoViewController.dropoffDate = self.dropoffDate;
    self.stepTwoViewController.driverAge = self.driverAge;
    self.stepTwoViewController.vehicleAvailability = self.vehicleAvailability;
    self.stepTwoViewController.stepThreeViewController = self.stepThreeViewController;
    self.stepTwoViewController.stepFourViewController = self.stepFourViewController;
    self.stepTwoViewController.stepFiveViewController = self.stepFiveViewController;

    
    CartrawlerAPI *cartrawlerAPI = [[CartrawlerAPI alloc] initWithClientKey:[CTSDKSettings instance].clientId
                                                                   language:[CTSDKSettings instance].languageCode
                                                                      debug:[CTSDKSettings instance].isDebug];
    self.stepTwoViewController.cartrawlerAPI = cartrawlerAPI;

    [cartrawlerAPI enableLogging:YES];
    [cartrawlerAPI requestVehicleAvailabilityForLocation:self.pickupLocation.code
                                           returnLocationCode:self.dropoffLocation.code
                                          customerCountryCode:@"IE"
                                                 passengerQty:@3
                                                    driverAge:self.driverAge
                                               pickUpDateTime:self.pickupDate
                                               returnDateTime:self.dropoffDate
                                                 currencyCode:@"EUR"
                                                   completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                                                       if (response) {
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               if (self.stepOneCompletion) {
                                                                   self.stepOneCompletion(YES, nil);
                                                               }
                                                               [self setVehicleAvailability: response];
                                                               self.stepTwoViewController.vehicleAvailability = self.vehicleAvailability;
                                                               [self.navigationController pushViewController:self.stepTwoViewController animated:YES];
                                                           });
                                                       } else {
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               if (self.stepOneCompletion) {
                                                                   self.stepOneCompletion(YES, error.errorMessage);
                                                               }
                                                           });
                                                           NSLog(@"CANNOT PUSH TO STEP TWO: %@", error.errorMessage);
                                                       }
                                                   }];
}

+ (void)forceLinkerLoad_
{
    
}

@end
