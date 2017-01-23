//
//  CTPaymentValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentValidation.h"

@implementation CTPaymentValidation

- (void)validateCarRental:(CTRentalSearch *)search
            cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
               completion:(CTSearchValidationCompletion)completion
{
    if (search.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.pickupLocation IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.pickupLocation IS NOT SET \n\n", NO);
        return;
    }
    
    if (search.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.dropoffLocation IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
        return;
    }
    
    if (search.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.pickupDate IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
        return;
    }
    
    if (search.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.dropoffDate IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
        return;
    }
    
    if (search.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.driverAge IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
        return;
    }
    
    if (search.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.vehicleAvailability IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
        return;
    }
    
    if (search.insurance == nil && search.isBuyingInsurance) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.insurance IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
        return;
    }
    
    if (search.firstName == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.firstName IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
        return;
    }
    
    if (search.surname == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.surname IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
        return;
    }
    
    if (search.email == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.email IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
        return;
    }
    
    if (search.phone == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.phone IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
        return;
    }
    
    if (search.flightNumber == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.flightNumber IS NOT SET \n\n");
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
        return;
    }
    
    if (search.isBuyingInsurance) {
        if (search.addressLine1 == nil) {
            NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.addressLine1 IS NOT SET \n\n");
            completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
            return;
        }
    
        if (search.addressLine2 == nil) {
            NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.addressLine2 IS NOT SET \n\n");
            completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
            return;
        }
    
        if (search.city == nil) {
            NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.city IS NOT SET \n\n");
            completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
            return;
        }
    
        if (search.postcode == nil) {
            NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.postcode IS NOT SET \n\n");
            completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
            return;
        }
    
        if (search.country == nil) {
            NSLog(@"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.country IS NOT SET \n\n");
            completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT", NO);
            return;
        }
    }
    
    
    completion(YES, nil, NO);

}

@end
