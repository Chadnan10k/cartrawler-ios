//
//  SearchValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "SearchValidation.h"

@implementation SearchValidation

+ (BOOL)validate:(CTSearch *)search
{

    if ([CTSearch instance].pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupLocation IS NOT SET \n\n");
        //completion(NO, @"search.pickupLocation is not set");
        return NO;
    }

    if ([CTSearch instance].dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffLocation IS NOT SET \n\n");
        //completion(NO, @"search.dropoffLocation is not set");
        return NO;
    }

    if ([CTSearch instance].pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupDate IS NOT SET \n\n");
        //completion(NO, @"search.pickupDate is not set");
        return NO;
    }

    if ([CTSearch instance].dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffDate IS NOT SET \n\n");
        //completion(NO, @"search.dropoffDate is not set");
        return NO;
    }

    if ([CTSearch instance].driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.driverAge IS NOT SET \n\n");
        //completion(NO, @"search.driverAge is not set");
        return NO;
    }
    
    return YES;

}
@end
