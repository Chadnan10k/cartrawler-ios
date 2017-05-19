//
//  CTGenericValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTGenericValidation.h"

@implementation CTGenericValidation

- (void)validateCarRental:(CTRentalSearch *)search
            cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
               completion:(CTSearchValidationCompletion)completion
{
    if (search.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupLocation IS NOT SET \n\n");
        completion(NO, @"ERROR: CANNOT PUSH TO DESTINATION VIEW CONTROLLER", NO);
        return;
    }
    
    if (search.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffLocation IS NOT SET \n\n");
        completion(NO, @"ERROR: CANNOT PUSH TO DESTINATION VIEW CONTROLLER", NO);
        return;
    }
    
    if (search.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupDate IS NOT SET \n\n");
        completion(NO, @"ERROR: CANNOT PUSH TO DESTINATION VIEW CONTROLLER", NO);
        return;
    }
    
    if (search.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffDate IS NOT SET \n\n");
        completion(NO, @"ERROR: CANNOT PUSH TO DESTINATION VIEW CONTROLLER", NO);
        return;
    }
    
    if (search.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.driverAge IS NOT SET \n\n");
        completion(NO, @"ERROR: CANNOT PUSH TO DESTINATION VIEW CONTROLLER", NO);
        return;
    }
    
    if (search.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.selectedVehicle IS NOT SET \n\n");
        completion(NO, @"ERROR: CANNOT PUSH TO DESTINATION VIEW CONTROLLER", NO);
        return;
    }
    
    completion(YES, nil, NO);
}

@end
