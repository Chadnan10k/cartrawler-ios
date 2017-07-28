//
//  CTSearchSettingsViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchSettingsViewModel.h"

@interface CTSearchSettingsViewModel ()

@property (nonatomic, readwrite) UIColor *navigationBarColor;

@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *closeButtonTitle;

@property (nonatomic, readwrite) NSString *currencyLabelText;
@property (nonatomic, readwrite) NSString *languageLabelText;
@property (nonatomic, readwrite) NSString *countryLabelText;

@property (nonatomic, readwrite) NSString *currency;
@property (nonatomic, readwrite) NSString *language;
@property (nonatomic, readwrite) NSString *country;

@property (nonatomic, readwrite) CTSearchSearchSettings selectedSettings;

@property (nonatomic, readwrite) CTSearchSettingsSelectionViewModel *selectedSettingsViewModel;

@end

@implementation CTSearchSettingsViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTUserSettingsState *userSettingsState = appState.userSettingsState;
    CTSearchState *searchState = appState.searchState;
    CTSearchSettingsViewModel *viewModel = [CTSearchSettingsViewModel new];
    
    viewModel.navigationBarColor = userSettingsState.primaryColor;
    
    viewModel.title = CTLocalizedString(CTRentalTitleSettings);
    viewModel.closeButtonTitle = CTLocalizedString(CTRentalCTAClose);
    viewModel.countryLabelText = CTLocalizedString(CTRentalSettingsCountryTitle);
    viewModel.currencyLabelText = CTLocalizedString(CTRentalSettingsCurrencyTitle);
    viewModel.languageLabelText = CTLocalizedString(CTRentalSettingsSelectLanguage);
    
    NSLocale *locale = [NSLocale currentLocale];
    viewModel.country = [locale displayNameForKey:NSLocaleCountryCode value:userSettingsState.countryCode];
    viewModel.currency = userSettingsState.currencyCode;
    viewModel.language = [locale displayNameForKey:NSLocaleIdentifier value:userSettingsState.languageCode];
    
    viewModel.selectedSettings = searchState.selectedSettings;
    
    if (viewModel.selectedSettings != CTSearchSearchSettingsNone) {
        viewModel.selectedSettingsViewModel = [CTSearchSettingsSelectionViewModel viewModelForState:appState];
    }
    
    return viewModel;
}

@end
