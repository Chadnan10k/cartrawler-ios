//
//  GTPassengerDetailsValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTPassengerDetailsValidation.h"

@implementation GTPassengerDetailsValidation

- (void)validateGroundTransport:(GroundTransportSearch *)search
                  cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
                     completion:(CTSearchValidation)completion
{
    if (search.pickupLocation == nil) {
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.pickupLocation IS NOT SET \n\n");
        return;
    }
    
    if (search.dropoffLocation == nil) {
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.dropoffLocation IS NOT SET \n\n");
        return;
    }
    
    if (search.selectedService == nil && search.selectedShuttle == nil) {
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT AS selectedService or selectedShuttle IS NOT SET \n\n");
        return;
    }
    
    if (search.firstName == nil) {
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.firstName IS NOT SET \n\n");
        return;
    }
    
    if (search.surname == nil) {
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.surname IS NOT SET \n\n");
        return;
    }
    
    if (search.email == nil) {
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.email IS NOT SET \n\n");
        return;
    }
    
    if (search.phone == nil) {
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.phone IS NOT SET \n\n");
        return;
    }
    
    if (search.addressLine1 == nil) {
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.addressLine1 IS NOT SET \n\n");
        return;
    }
    
    if (search.addressLine2 == nil) {
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.addressLine2 IS NOT SET \n\n");
        return;
    }
    
    if (search.city == nil) {
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.city IS NOT SET \n\n");
        return;
    }
    
    if (search.postcode == nil) {
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.postcode IS NOT SET \n\n");
        return;
    }
    
    if (search.country == nil) {
        completion(NO, @"\n\n ERROR: CANNOT PUSH TO PAYMENT AS self.country IS NOT SET \n\n");
        return;
    }
    
    completion(YES, nil);
}

@end
