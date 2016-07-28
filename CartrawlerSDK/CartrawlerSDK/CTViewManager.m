//
//  CTViewManager.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTViewManager.h"
#import "StepTwoViewController.h"

@interface CTViewManager()

@end

@implementation CTViewManager

+ (BOOL)canTransitionToStep:(CTViewController *)step search:(CTSearch *)search
{
    if ([step isKindOfClass:[StepTwoViewController class]]) {
        return [self vehicleSelectionValidation:search];
    }
    
    return NO;
}

+ (BOOL)searchDetailsValidation:(CTSearch *)search;
{
    return YES;
}

+ (BOOL)vehicleSelectionValidation:(CTSearch *)search;
{
    
    if (search.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.pickupLocation IS NOT SET \n\n");
        return NO;
    }
    
    if (search.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.dropoffLocation IS NOT SET \n\n");
        return NO;
    }
    
    if (search.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.pickupDate IS NOT SET \n\n");
        return NO;
    }
    
    if (search.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.dropoffDate IS NOT SET \n\n");
        return NO;
    }
    
    if (search.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.driverAge IS NOT SET \n\n");
        return NO;
    }
    
    return YES;
}

@end
