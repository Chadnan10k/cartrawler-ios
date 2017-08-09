//
//  CTSearchViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchViewModel.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CTValidationSearch.h"

@interface CTSearchViewModel ()
@property (nonatomic, readwrite) CTSearchContentView contentView;
@property (nonatomic, readwrite) CTSearchSplashViewModel *searchSplashViewModel;
@property (nonatomic, readwrite) CTSearchFormViewModel *searchFormViewModel;
@property (nonatomic, readwrite) CTSearchLocationsViewModel *searchLocationsViewModel;
@property (nonatomic, readwrite) CTSearchCalendarViewModel *searchCalendarViewModel;
@property (nonatomic, readwrite) CTSearchSettingsViewModel *searchSettingsViewModel;
@property (nonatomic, readwrite) CTSearchUSPViewModel *searchUSPViewModel;
@property (nonatomic, readwrite) UIColor *navigationBarColor;
@property (nonatomic, readwrite) BOOL scrollAboveKeyboard;
@property (nonatomic, readwrite) CGFloat scrollAboveUserInput;
@end

@implementation CTSearchViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTUserSettingsState *userSettingsState = appState.userSettingsState;
    CTSearchState *searchState = appState.searchState;
    CTSearchViewModel *viewModel = [CTSearchViewModel new];
    
    viewModel.navigationBarColor = userSettingsState.primaryColor;
    viewModel.contentView = searchState.selectedPickupLocation ? CTSearchContentViewForm : CTSearchContentViewSplash;
    viewModel.searchSplashViewModel = [CTSearchSplashViewModel viewModelForState:appState];
    viewModel.searchFormViewModel = [CTSearchFormViewModel viewModelForState:appState];
    viewModel.searchUSPViewModel = [CTSearchUSPViewModel viewModelForState:appState];
    viewModel.scrollAboveUserInput =  searchState.scrollAboveUserInput ? appState.userSettingsState.keyboardHeight.floatValue : 0;
    
    return viewModel;
}

@end
