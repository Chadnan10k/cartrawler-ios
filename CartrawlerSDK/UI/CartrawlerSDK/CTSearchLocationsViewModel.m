//
//  CTSearchLocationsViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchLocationsViewModel.h"
#import "CTAppState.h"

@interface CTSearchLocationsViewModel ()
@property (nonatomic, readwrite) UIColor *navigationBarColor;
@property (nonatomic, readwrite) UIColor *cursorColor;
@property (nonatomic, readwrite) NSString *searchBarPlaceholder;
@property (nonatomic, readwrite) NSArray <NSString *> *sectionTitles;
@property (nonatomic, readwrite) NSArray <NSArray <CTMatchedLocation *> *> *rows;
@end

@implementation CTSearchLocationsViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSearchLocationsViewModel *viewModel = [CTSearchLocationsViewModel new];
    CTUserSettingsState *userSettingsState = appState.userSettingsState;
    CTAPIState *APIState = appState.APIState;
    CTSearchState *searchState = appState.searchState;
    
    viewModel.navigationBarColor = userSettingsState.primaryColor;
    viewModel.cursorColor = userSettingsState.primaryColor;
    
    NSString *location;
    switch (searchState.selectedTextField) {
        case CTSearchFormTextFieldPickupLocation:
            location = @"pick-up";
            break;
        case CTSearchFormTextFieldDropoffLocation:
            location = @"drop-off";
            break;
        default:
            break;
    }
    viewModel.searchBarPlaceholder = [NSString stringWithFormat:@"What's your %@ location?", location];
    
    NSArray *matchedLocations = APIState.matchedLocations[searchState.searchBarText];
    
    NSMutableArray *airportLocations = [NSMutableArray new];
    NSMutableArray *otherLocations = [NSMutableArray new];
    
    for (CTMatchedLocation *matchedLocation in matchedLocations) {
        if (matchedLocation.isAtAirport) {
            [airportLocations addObject:matchedLocation];
        } else {
            [otherLocations addObject:matchedLocation];
        }
    }
    
    NSMutableArray *rowTitles = [NSMutableArray new];
    NSMutableArray *sectionTitles = [NSMutableArray new];
    if (airportLocations.count > 0) {
        [sectionTitles addObject:@"Airport"];
        [rowTitles addObject:airportLocations];
    }
    if (otherLocations.count > 0) {
        [sectionTitles addObject:@"City Locations"];
        [rowTitles addObject:otherLocations];
    }
    
    viewModel.rows = @[airportLocations.copy, otherLocations.copy];
    viewModel.sectionTitles = sectionTitles.copy;
    
    
    return viewModel;
}

@end
