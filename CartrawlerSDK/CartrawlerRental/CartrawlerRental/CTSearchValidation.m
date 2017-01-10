//
//  CTSearchValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSearchValidation.h"
#import <CartrawlerSDK/CTSDKSettings.h>
#import <CartrawlerSDK/CartrawlerSDK+NSDateUtils.h>

@implementation CTSearchValidation

- (void)validateCarRental:(CTRentalSearch *)search
            cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
               completion:(CTSearchValidationCompletion)completion
{

    if (search.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupLocation IS NOT SET \n\n");
        completion(NO, @"search.pickupLocation is not set", NO);
        return;
    }

    if (search.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffLocation IS NOT SET \n\n");
        completion(NO, @"search.dropoffLocation is not set", NO);
        return;
    }

    if (search.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupDate IS NOT SET \n\n");
        completion(NO, @"search.pickupDate is not set", NO);
        return;
    }

    if (search.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffDate IS NOT SET \n\n");
        completion(NO, @"search.dropoffDate is not set", NO);
        return;
    }

    if (search.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.driverAge IS NOT SET \n\n");
        completion(NO, @"search.driverAge is not set", NO);
        return;
    }
    
    if (search.vehicleAvailability) {
        completion(YES, nil, NO);
    } else {
        [cartrawlerAPI requestVehicleAvailabilityForLocation:search.pickupLocation.code
                                          returnLocationCode:search.dropoffLocation.code
                                         customerCountryCode:[CTSDKSettings instance].homeCountryCode
                                                passengerQty:@3
                                                   driverAge:search.driverAge
                                              pickUpDateTime:search.pickupDate
                                              returnDateTime:search.dropoffDate
                                                currencyCode:[CTSDKSettings instance].currencyCode
                                                  completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                                                      if (response) {
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              search.vehicleAvailability = response;
                                                              completion(YES, nil, NO);
                                                          });
                                                      } else {
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              completion(NO, error.errorMessage, NO);
                                                              [CTAnalytics tagError:@"step1" event:@"VehAvail search" message:error.errorMessage];
                                                          });
                                                      }
                                                  }];
    }
    

}
@end
