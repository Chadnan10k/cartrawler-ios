//
//  GTGenericValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTGenericValidation.h"

@implementation GTGenericValidation
- (void)validateGroundTransport:(GroundTransportSearch *)search
                  cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
                     completion:(CTSearchValidation)completion
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
    
    if (search.adultQty == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.adultQty IS NOT SET \n\n");
        completion(NO, @"ERROR: CANNOT PUSH TO DESTINATION VIEW CONTROLLER", NO);
        return;
    }
    
    if (search.selectedService == nil && search.selectedShuttle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.selectedService IS NOT SET \n\n");
        completion(NO, @"ERROR: CANNOT PUSH TO DESTINATION VIEW CONTROLLER", NO);
        return;
    }
    
    completion(YES, nil, NO);
}
@end
