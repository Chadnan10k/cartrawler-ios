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
@property (nonatomic, readwrite) UIColor *iconColor;
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
    viewModel.iconColor = userSettingsState.primaryColor;
    
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
    
    
    NSMutableArray *sections = [NSMutableArray new];
    NSMutableArray *rows = [NSMutableArray new];
    
    if (airportLocations.count > 0) {
        [sections addObject:CTLocalizedString(CTRentalSearchLocationsAirport)];
        [rows addObject:airportLocations.copy];
    }
    if (otherLocations.count > 0) {
        [sections addObject:CTLocalizedString(CTRentalSearchLocationsOther)];
        [rows addObject:otherLocations.copy];
    }
    
    viewModel.sectionTitles = sections.copy;
    viewModel.rows = rows.copy;
    
    return viewModel;
}

@end
