//
//  BookingCompletionValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 19/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "BookingCompletionValidation.h"

@implementation BookingCompletionValidation

- (void)validateCarRental:(CarRentalSearch *)search
            cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
               completion:(CTSearchValidation)completion
{
    if (search.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.pickupLocation IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.pickupLocation IS NOT SET \n\n", NO);
        return;
    }
    
    if (search.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.dropoffLocation IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.pickupDate IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.dropoffDate IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.driverAge IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.vehicleAvailability IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.insurance == nil && search.isBuyingInsurance) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.insurance IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.firstName == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.firstName IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.surname == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.surname IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.email == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.email IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.phone == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.phone IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.flightNumber == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.flightNumber IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.addressLine1 == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.addressLine1 IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.addressLine2 == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.addressLine2 IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.city == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.city IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.postcode == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.postcode IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
    if (search.country == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.country IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION", NO);
        return;
    }
    
//    if (search.booking == nil) {
//        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION AS self.booking IS NOT SET \n\n");
//        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT COMPLETION COMPLETION");
//        return;
//    }
    
    completion(YES, nil, NO);
    
}


@end
