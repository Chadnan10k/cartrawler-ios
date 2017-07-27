//
//  CTValidationSearch.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/24/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTValidationSearch.h"

@implementation CTValidationSearch

+ (BOOL)validateSearchStep:(CTSearchState *)searchState {
    if (!searchState.selectedPickupLocation) {
        return NO;
    }
    
    if (searchState.dropoffLocationRequired && !searchState.selectedDropoffLocation) {
        return NO;
    }
    
    if (!searchState.selectedPickupDate) {
        return NO;
    }
    
    if (!searchState.selectedDropoffDate) {
        return NO;
    }
    
    if (!searchState.selectedPickupTime) {
        return NO;
    }
    
    if (!searchState.selectedDropoffTime) {
        return NO;
    }
    
    if (searchState.driverAgeRequired && !searchState.displayedDriverAge) {
        return NO;
    }
    
    if (searchState.driverAgeRequired && searchState.displayedDriverAge.length < 2) {
        return NO;
    }
    
    return YES;
}

@end
