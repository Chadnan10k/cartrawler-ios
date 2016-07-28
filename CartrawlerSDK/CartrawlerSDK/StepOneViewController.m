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
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "CTViewManager.h"

@interface StepOneViewController ()

@end

@implementation StepOneViewController

- (void)pushToStepTwo
{
     if (![CTViewManager canTransitionToStep:self.destinationViewController search:self.search])
     {
         self.stepOneCompletion(NO, @"");
         return;
     }
    
    CartrawlerAPI *cartrawlerAPI = [[CartrawlerAPI alloc] initWithClientKey:[CTSDKSettings instance].clientId
                                                                   language:[CTSDKSettings instance].languageCode
                                                                      debug:[CTSDKSettings instance].isDebug];
    [self.destinationViewController setCartrawlerAPI:cartrawlerAPI];

    
    
    [cartrawlerAPI enableLogging:YES];
    [cartrawlerAPI requestVehicleAvailabilityForLocation:self.search.pickupLocation.code
                                           returnLocationCode:self.search.dropoffLocation.code
                                          customerCountryCode:[CTSDKSettings instance].homeCountryCode
                                                 passengerQty:@3
                                                    driverAge:self.search.driverAge
                                               pickUpDateTime:self.search.pickupDate
                                               returnDateTime:self.search.dropoffDate
                                                 currencyCode:[CTSDKSettings instance].currencyCode
                                                   completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                                                       if (response) {
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               if (self.stepOneCompletion) {
                                                                   self.stepOneCompletion(YES, nil);
                                                               }
                                                               [CTSearch instance].vehicleAvailability = response;
                                                               [self.navigationController pushViewController:self.destinationViewController animated:YES];
                                                               [self.destinationViewController refresh];
                                                           });
                                                       } else {
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               if (self.stepOneCompletion) {
                                                                   self.stepOneCompletion(NO, error.errorMessage);
                                                               }
                                                           });
                                                       }
                                                   }];
    
    
}

+ (void)forceLinkerLoad_
{
    
}

@end
