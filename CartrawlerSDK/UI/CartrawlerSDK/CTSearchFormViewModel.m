//
//  CTSearchFormViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/20/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchFormViewModel.h"
#import "CTAppState.h"
#import <CartrawlerAPI/CTMatchedLocation.h>
#import "CartrawlerSDK+NSDateUtils.h"

@interface CTSearchFormViewModel ()
@property (nonatomic, readwrite) NSString *pickupLocationName;
@property (nonatomic, readwrite) NSString *dropoffLocationName;

@property (nonatomic, readwrite) NSString *rentalDates;

@property (nonatomic, readwrite) NSString *pickupTime;
@property (nonatomic, readwrite) NSString *dropoffTime;
@end

@implementation CTSearchFormViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSearchState *searchState = appState.searchState;
    CTSearchFormViewModel *viewModel = [CTSearchFormViewModel new];
    
    viewModel.pickupLocationName = searchState.selectedPickupLocation.name;
    viewModel.dropoffLocationName = searchState.selectedDropoffLocation.name;
    
    if (searchState.selectedPickupDate && searchState.selectedDropoffDate) {
        viewModel.rentalDates = [NSString stringWithFormat:@"%@ - %@", [searchState.selectedPickupDate shortDescriptionFromDate], [searchState.selectedDropoffDate shortDescriptionFromDate]];
    }
    
    viewModel.pickupTime = [searchState.selectedPickupTime simpleTimeString];
    viewModel.dropoffTime = [searchState.selectedDropoffTime simpleTimeString];
    
    return viewModel;
}

@end
