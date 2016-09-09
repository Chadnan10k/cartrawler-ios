//
//  SearchValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "SearchValidation.h"
#import "CTSDKSettings.h"

@implementation SearchValidation

- (void)validateCarRental:(CarRentalSearch *)search
            cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
               completion:(CTSearchValidation)completion
{

    if ([CarRentalSearch instance].pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupLocation IS NOT SET \n\n");
        completion(NO, @"search.pickupLocation is not set");
        return;
    }

    if ([CarRentalSearch instance].dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffLocation IS NOT SET \n\n");
        completion(NO, @"search.dropoffLocation is not set");
        return;
    }

    if ([CarRentalSearch instance].pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupDate IS NOT SET \n\n");
        completion(NO, @"search.pickupDate is not set");
        return;
    }

    if ([CarRentalSearch instance].dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffDate IS NOT SET \n\n");
        completion(NO, @"search.dropoffDate is not set");
        return;
    }

    if ([CarRentalSearch instance].driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.driverAge IS NOT SET \n\n");
        completion(NO, @"search.driverAge is not set");
        return;
    }
    
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
                                                          completion(YES, nil);
                                                      });
                                                  } else {
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          completion(NO, error.errorMessage);
                                                      });
                                                  }
                                              }];
    

}
@end
