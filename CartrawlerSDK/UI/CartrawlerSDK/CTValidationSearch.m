//
//  CTValidationSearch.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/24/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTValidationSearch.h"

@implementation CTValidationSearch

+ (NSArray <NSNumber *> *)validateSearchStep:(CTSearchState *)searchState {
    NSMutableArray *validationFailures = [NSMutableArray new];
    
    if (!searchState.selectedPickupLocation) {
        [validationFailures addObject:@(CTSearchFormTextFieldPickupLocation)];
    }
    
    if (searchState.dropoffLocationRequired && !searchState.selectedDropoffLocation) {
        [validationFailures addObject:@(CTSearchFormTextFieldDropoffLocation)];
    }
    
    if (!searchState.selectedPickupDate) {
        [validationFailures addObject:@(CTSearchFormTextFieldSelectDates)];
    }
    
    if (!searchState.selectedDropoffDate) {
        [validationFailures addObject:@(CTSearchFormTextFieldSelectDates)];
    }
    
    if (!searchState.selectedPickupTime) {
        [validationFailures addObject:@(CTSearchFormTextFieldPickupTime)];
    }
    
    if (!searchState.selectedDropoffTime) {
        [validationFailures addObject:@(CTSearchFormTextFieldDropoffTime)];
    }
    
    if (searchState.driverAgeRequired && !searchState.displayedDriverAge) {
        [validationFailures addObject:@(CTSearchFormTextFieldDriverAge)];
    }
    
    if (searchState.driverAgeRequired && searchState.displayedDriverAge.length < 2) {
        [validationFailures addObject:@(CTSearchFormTextFieldDriverAge)];
    }
    
    return validationFailures.copy;
}

@end
