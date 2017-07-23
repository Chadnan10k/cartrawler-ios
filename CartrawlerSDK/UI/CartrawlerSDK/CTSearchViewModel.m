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
@property (nonatomic, readwrite) CTSearchFormViewModel *searchFormViewModel;
@property (nonatomic, readwrite) CTSearchLocationsViewModel *searchLocationsViewModel;
@property (nonatomic, readwrite) CTSearchCalendarViewModel *searchCalendarViewModel;
@property (nonatomic, readwrite) NSDate *defaultPickerTime;
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
        case CTSearchFormTextFieldPickupLocation:
            viewModel.supplementaryView = CTSearchSupplementaryViewSearchLocations;
            break;
        case CTSearchFormTextFieldDropoffLocation:
            viewModel.supplementaryView = CTSearchSupplementaryViewSearchLocations;
            break;
        case CTSearchFormTextFieldSelectDates:
            viewModel.supplementaryView = CTSearchSupplementaryViewCalendar;
            break;
        case CTSearchFormTextFieldPickupTime:
            viewModel.supplementaryView = CTSearchSupplementaryViewTimePicker;
            break;
        case CTSearchFormTextFieldDropoffTime:
            viewModel.supplementaryView = CTSearchSupplementaryViewTimePicker;
            break;
        case CTSearchFormTextFieldAge:
            viewModel.supplementaryView = CTSearchSupplementaryViewNone;
            break;
        default:
            break;
    }

    viewModel.searchFormViewModel = [CTSearchFormViewModel viewModelForState:appState];
    viewModel.searchLocationsViewModel = [CTSearchLocationsViewModel viewModelForState:appState];
    viewModel.searchCalendarViewModel = [CTSearchCalendarViewModel viewModelForState:searchState];
    
    if (searchState.selectedTextField == CTSearchFormTextFieldPickupTime) {
        viewModel.defaultPickerTime = searchState.selectedPickupTime ?: [NSDate dateWithHour:10 minute:0];
    }
    
    if (searchState.selectedTextField == CTSearchFormTextFieldDropoffTime) {
        viewModel.defaultPickerTime = searchState.selectedDropoffTime ?: [NSDate dateWithHour:10 minute:0];
    }
    
    return viewModel;
}

@end
