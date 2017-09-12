//
//  CTSearchCalendarViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/22/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchCalendarViewModel.h"
#import "CTAppState.h"
#import "CartrawlerSDK+NSDateUtils.h"

@interface CTSearchCalendarViewModel ()
@property (nonatomic, readwrite) UIColor *primaryColor;
@property (nonatomic, readwrite) UIColor *secondaryColor;
@property (nonatomic, readwrite) NSString *language;
@property (nonatomic, readwrite) NSString *displayedPickupDate;
@property (nonatomic, readwrite) NSString *displayedDropoffDate;
@property (nonatomic, readwrite) BOOL enableNextButton;
@property (nonatomic, readwrite) NSString *nextButtonTitle;
@end

@implementation CTSearchCalendarViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSearchCalendarViewModel *viewModel = [CTSearchCalendarViewModel new];
    CTUserSettingsState *userSettingsState = appState.userSettingsState;
    CTSearchState *searchState = appState.searchState;
    
    viewModel.primaryColor = userSettingsState.primaryColor;
    viewModel.secondaryColor = userSettingsState.secondaryColor;
    viewModel.language = userSettingsState.languageCode;
    
    viewModel.displayedPickupDate = searchState.displayedPickupDate ? [searchState.displayedPickupDate shortDescriptionFromDateInLanguage:userSettingsState.languageCode] : CTLocalizedString(CTSDKCalendarSelectDate);
    if (searchState.displayedPickupDate) {
        viewModel.displayedDropoffDate = searchState.displayedDropoffDate ? [searchState.displayedDropoffDate shortDescriptionFromDateInLanguage:userSettingsState.languageCode] : CTLocalizedString(CTSDKCalendarSelectDate);
    }
    
    viewModel.enableNextButton = (searchState.displayedPickupDate && searchState.displayedDropoffDate);
    
    viewModel.nextButtonTitle = CTLocalizedString(CTRentalCTAContinue);
    return viewModel;
}

@end
