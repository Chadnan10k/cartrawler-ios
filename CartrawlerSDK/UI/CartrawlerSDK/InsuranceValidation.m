//
//  InsuranceValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "InsuranceValidation.h"

@implementation InsuranceValidation

+ (BOOL)validate:(CarRentalSearch *)search {

if ([CarRentalSearch instance].pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupLocation IS NOT SET \n\n");
        return NO;
    }

    if ([CarRentalSearch instance].dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffLocation IS NOT SET \n\n");
        return NO;
    }

    if ([CarRentalSearch instance].pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupDate IS NOT SET \n\n");
        return NO;
    }

    if ([CarRentalSearch instance].dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffDate IS NOT SET \n\n");
        return NO;
    }

    if ([CarRentalSearch instance].driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.driverAge IS NOT SET \n\n");
        return NO;
    }

    if ([CarRentalSearch instance].selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.vehicleAvailability IS NOT SET \n\n");
        return NO;
    }

    if ([CarRentalSearch instance].selectedVehicle.vehicle.extraEquipment == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS extras IS NOT SET \n\n");
        return NO;
    }
    
    
    return YES;
    
}

@end
