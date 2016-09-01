//
//  InsuranceValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "InsuranceValidation.h"

@implementation InsuranceValidation

+ (BOOL)validate:(CTSearch *)search {

if ([CTSearch instance].pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupLocation IS NOT SET \n\n");
        return NO;
    }

    if ([CTSearch instance].dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffLocation IS NOT SET \n\n");
        return NO;
    }

    if ([CTSearch instance].pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupDate IS NOT SET \n\n");
        return NO;
    }

    if ([CTSearch instance].dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffDate IS NOT SET \n\n");
        return NO;
    }

    if ([CTSearch instance].driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.driverAge IS NOT SET \n\n");
        return NO;
    }

    if ([CTSearch instance].selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.vehicleAvailability IS NOT SET \n\n");
        return NO;
    }

    if ([CTSearch instance].selectedVehicle.vehicle.extraEquipment == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS extras IS NOT SET \n\n");
        return NO;
    }
    
    
    return YES;
    
}

@end
