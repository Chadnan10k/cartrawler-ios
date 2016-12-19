//
//  SearchValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "SearchValidation.h"
#import <CartrawlerSDK/CTSDKSettings.h>
#import <CartrawlerSDK/CartrawlerSDK+NSDateUtils.h>

@implementation SearchValidation

- (void)validateCarRental:(CTRentalSearch *)search
            cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
               completion:(CTSearchValidation)completion
{

    if ([CTRentalSearch instance].pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupLocation IS NOT SET \n\n");
        completion(NO, @"search.pickupLocation is not set", NO);
        return;
    }

    if ([CTRentalSearch instance].dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffLocation IS NOT SET \n\n");
        completion(NO, @"search.dropoffLocation is not set", NO);
        return;
    }

    if ([CTRentalSearch instance].pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupDate IS NOT SET \n\n");
        completion(NO, @"search.pickupDate is not set", NO);
        return;
    }

    if ([CTRentalSearch instance].dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffDate IS NOT SET \n\n");
        completion(NO, @"search.dropoffDate is not set", NO);
        return;
    }

    if ([CTRentalSearch instance].driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.driverAge IS NOT SET \n\n");
        completion(NO, @"search.driverAge is not set", NO);
        return;
    }
    
    NSLog(@"Payment pickup: %@", [search.pickupDate stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]);
    NSLog(@"Payment dropoff: %@", [search.dropoffDate stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]);
    
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
                                                      });
                                                  }
                                              }];
    

}
@end
