//
//  GTSelectionValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTSelectionValidation.h"

@implementation GTSelectionValidation

- (void)validateGroundTransport:(GroundTransportSearch *)search
                  cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
                     completion:(CTSearchValidation)completion
{
    if (!search.airport) {
        completion(NO, @"CTAirport not set", NO);
        return;
    }

    if (!search.pickupLocation) {
        completion(NO, @"Ground Transport Pickup location not set", NO);
        return;
    }

    if (!search.dropoffLocation) {
        completion(NO, @"Ground Transport Dropoff location not set", NO);
        return;
    }

    if (!search.adultQty) {    //we just need 1 adult passenger to make call
        completion(NO, @"No passengers set for Ground transport", NO);
        return;
    }
    
    if (!search.availability) {
        completion(NO, @"No availability set for Ground transport", NO);
        return;
    }
    
    if (!search.selectedService && !search.selectedShuttle) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.selectedService IS NOT SET \n\n");
        completion(NO, @"ERROR: CANNOT PUSH TO DESTINATION VIEW CONTROLLER", NO);
        return;
    }
    
    completion(YES, nil, NO);
}

@end
