//
//  StepOneViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSearchDetailsViewController.h"
#import "CTSDKSettings.h"
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "CTViewManager.h"

@interface CTSearchDetailsViewController ()

@end

@implementation CTSearchDetailsViewController

- (void)pushToDestination
{
     if (![CTViewManager canTransitionToStep:self.destinationViewController search:self.search])
     {
         self.searchDetailsCompletion(NO, @"");
         return;
     }

    [self.cartrawlerAPI requestVehicleAvailabilityForLocation:self.search.pickupLocation.code
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
                                                               if (self.searchDetailsCompletion) {
                                                                   self.searchDetailsCompletion(YES, nil);
                                                               }
                                                               [CTSearch instance].vehicleAvailability = response;
                                                               [self.navigationController pushViewController:self.destinationViewController animated:YES];
                                                               [self.destinationViewController refresh];
                                                           });
                                                       } else {
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               if (self.searchDetailsCompletion) {
                                                                   self.searchDetailsCompletion(NO, error.errorMessage);
                                                               }
                                                           });
                                                       }
                                                   }];
}

+ (void)forceLinkerLoad_
{
    
}

@end
