//
//  StepThreeViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 01/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "StepThreeViewController.h"
#import "CTSDKSettings.h"
#import "CTViewManager.h"

@interface StepThreeViewController ()

@end

@implementation StepThreeViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)pushToDestination
{
    if (![CTViewManager canTransitionToStep:self.destinationViewController search:self.search])
    {
        return;
    }
    
    [self.cartrawlerAPI requestInsuranceQuoteForVehicle:[CTSDKSettings instance].homeCountryCode
                                               currency:[CTSDKSettings instance].currencyCode
                                              totalCost:[NSString stringWithFormat:@"%.02f", self.search.selectedVehicle.totalPriceForThisVehicle.doubleValue]
                                         pickupDateTime:self.search.pickupDate
                                         returnDateTime:self.search.dropoffDate
                                 destinationCountryCode:self.search.pickupLocation.codeContext
                                             completion:
     ^(CTInsurance *response, CTErrorResponse *error) {
     if (response) {
         
         dispatch_async(dispatch_get_main_queue(), ^{
             if (self.stepThreeCompletion) {
                 self.stepThreeCompletion(YES, nil);
             }
             [self.search setInsurance:response];
             [self.navigationController pushViewController:self.destinationViewController animated:YES];
         });
         
     } else {
         dispatch_async(dispatch_get_main_queue(), ^{
             if (self.stepThreeCompletion) {
                 self.stepThreeCompletion(NO, error.errorMessage);
             }
             
             if (self.search.selectedVehicle.extraEquipment.count == 0) {
                 [self.fallBackViewController.search setInsurance:nil];
                 self.fallBackViewController.search.isBuyingInsurance = NO;
                 [self.navigationController pushViewController:self.fallBackViewController animated:YES];
             } else {
                 [self.search setInsurance:nil];
                 self.search.isBuyingInsurance = NO;
                 [self.navigationController pushViewController:self.destinationViewController animated:YES];
             }
             
         });
     }
 }];
}

@end
