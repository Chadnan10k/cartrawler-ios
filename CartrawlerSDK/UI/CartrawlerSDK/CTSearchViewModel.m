//
//  CTSearchViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchViewModel.h"
#import "CartrawlerSDK+NSDateUtils.h"

@interface CTSearchViewModel ()
@property (nonatomic, readwrite) CTSearchContentView contentView;
@property (nonatomic, readwrite) CTSearchSupplementaryView supplementaryView;
@property (nonatomic, readwrite)CTSearchSplashViewModel *searchSplashViewModel;
@property (nonatomic, readwrite) CTSearchFormViewModel *searchFormViewModel;
@property (nonatomic, readwrite) CTSearchLocationsViewModel *searchLocationsViewModel;
@property (nonatomic, readwrite) CTSearchCalendarViewModel *searchCalendarViewModel;
@property (nonatomic, readwrite) CTSearchSettingsViewModel *searchSettingsViewModel;
@end

@implementation CTSearchViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSearchState *searchState = appState.searchState;
    CTSearchViewModel *viewModel = [CTSearchViewModel new];
    
    viewModel.contentView = searchState.selectedPickupLocation ? CTSearchContentViewForm : CTSearchContentViewSplash;
    
    switch (searchState.selectedTextField) {
        case CTSearchFormTextFieldNone:
            viewModel.supplementaryView = CTSearchSupplementaryViewNone;
            break;
        case CTSearchFormSettingsButton:
            viewModel.supplementaryView = CTSearchSupplementaryViewSettings;
            break;
        case CTSearchFormTextFieldPickupLocation:
            viewModel.supplementaryView = CTSearchSupplementaryViewSearchLocations;
            break;
        case CTSearchFormTextFieldDropoffLocation:
            viewModel.supplementaryView = CTSearchSupplementaryViewSearchLocations;
            break;
        case CTSearchFormTextFieldSelectDates:
            viewModel.supplementaryView = CTSearchSupplementaryViewCalendar;
            break;
        case CTSearchFormTextFieldDriverAge:
            viewModel.supplementaryView = CTSearchSupplementaryViewNone;
            break;
        default:
            break;
    }
    
    // TODO: Rationalise when view models are created, only when necessary
    viewModel.searchSplashViewModel = [CTSearchSplashViewModel viewModelForState:appState];
    viewModel.searchFormViewModel = [CTSearchFormViewModel viewModelForState:appState];
    viewModel.searchLocationsViewModel = [CTSearchLocationsViewModel viewModelForState:appState];
    viewModel.searchCalendarViewModel = [CTSearchCalendarViewModel viewModelForState:searchState];
    viewModel.searchSettingsViewModel = [CTSearchSettingsViewModel viewModelForState:appState];
    
    return viewModel;
}

@end
