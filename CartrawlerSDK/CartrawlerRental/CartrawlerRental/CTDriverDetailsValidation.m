//
//  CTDriverDetailsValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 23/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTDriverDetailsValidation.h"

@implementation CTDriverDetailsValidation

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
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.vehicleAvailability IS NOT SET \n\n");
        completion(NO, @"ERROR: CANNOT PUSH TO DESTINATION VIEW CONTROLLER", NO);
        return;
    }
    
    if (search.firstName == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.firstName IS NOT SET \n\n");
        completion(NO, @"ERROR: CANNOT PUSH TO DESTINATION VIEW CONTROLLER", NO);
        return;
    }
    
    if (search.surname == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.surname IS NOT SET \n\n");
        completion(NO, @"ERROR: CANNOT PUSH TO DESTINATION VIEW CONTROLLER", NO);
        return;
    }
    
    if (search.email == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.email IS NOT SET \n\n");
        completion(NO, @"ERROR: CANNOT PUSH TO DESTINATION VIEW CONTROLLER", NO);
        return;
    }
    
    if (search.phone == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.phone IS NOT SET \n\n");
        completion(NO, @"ERROR: CANNOT PUSH TO DESTINATION VIEW CONTROLLER", NO);
        return;
    }
    
    if (search.isBuyingInsurance) {
        completion(YES, nil, NO);
    } else {
        completion(NO, nil, NO);
    }

}

@end
