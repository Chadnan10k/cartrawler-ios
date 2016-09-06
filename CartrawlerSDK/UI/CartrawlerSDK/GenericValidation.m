//
//  GenericValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GenericValidation.h"

@implementation GenericValidation

+ (BOOL)validate:(CarRentalSearch *)search
{
    if (search.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupLocation IS NOT SET \n\n");
        return NO;
    }
    
    if (search.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffLocation IS NOT SET \n\n");
        return NO;
    }
    
    if (search.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupDate IS NOT SET \n\n");
        return NO;
    }
    
    if (search.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffDate IS NOT SET \n\n");
        return NO;
    }
    
    if (search.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.driverAge IS NOT SET \n\n");
        return NO;
    }
    
    if (search.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.vehicleAvailability IS NOT SET \n\n");
        return NO;
    }
    
    return YES;
}

@end
