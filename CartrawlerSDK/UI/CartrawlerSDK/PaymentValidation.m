//
//  PaymentValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentValidation.h"

@implementation PaymentValidation

+ (BOOL)validate:(CTSearch *)search
{
    if (search.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.pickupLocation IS NOT SET \n\n");
        return NO;
    }
    
    if (search.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.dropoffLocation IS NOT SET \n\n");
        return NO;
    }
    
    if (search.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.pickupDate IS NOT SET \n\n");
        return NO;
    }
    
    if (search.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.dropoffDate IS NOT SET \n\n");
        return NO;
    }
    
    if (search.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.driverAge IS NOT SET \n\n");
        return NO;
    }
    
    if (search.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.vehicleAvailability IS NOT SET \n\n");
        return NO;
    }
    
    if (search.insurance == nil && search.isBuyingInsurance) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.insurance IS NOT SET \n\n");
        return NO;
    }
    
    if (search.firstName == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.firstName IS NOT SET \n\n");
        return NO;
    }
    
    if (search.surname == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.surname IS NOT SET \n\n");
        return NO;
    }
    
    if (search.email == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.email IS NOT SET \n\n");
        return NO;
    }
    
    if (search.phone == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.phone IS NOT SET \n\n");
        return NO;
    }
    
    if (search.flightNumber == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.flightNumber IS NOT SET \n\n");
        return NO;
    }
    
    if (search.addressLine1 == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.addressLine1 IS NOT SET \n\n");
        return NO;
    }
    
    if (search.addressLine2 == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.addressLine2 IS NOT SET \n\n");
        return NO;
    }
    
    if (search.city == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.city IS NOT SET \n\n");
        return NO;
    }
    
    if (search.postcode == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.postcode IS NOT SET \n\n");
        return NO;
    }
    
    if (search.country == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.country IS NOT SET \n\n");
        return NO;
    }
    
    return YES;
}

@end
