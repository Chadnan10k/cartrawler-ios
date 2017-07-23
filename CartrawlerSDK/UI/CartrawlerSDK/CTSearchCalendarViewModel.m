//
//  CTSearchCalendarViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/22/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchCalendarViewModel.h"
#import "CTSearchState.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CTSDKLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTSearchCalendarViewModel ()
@property (nonatomic, readwrite) NSString *displayedPickupDate;
@property (nonatomic, readwrite) NSString *displayedDropoffDate;
@property (nonatomic, readwrite) BOOL enableNextButton;
@end

@implementation CTSearchCalendarViewModel

+ (instancetype)viewModelForState:(CTSearchState *)searchState {
    CTSearchCalendarViewModel *viewModel = [CTSearchCalendarViewModel new];
    viewModel.displayedPickupDate = searchState.displayedPickupDate ? [searchState.displayedPickupDate shortDescriptionFromDate] : CTLocalizedString(CTSDKCalendarSelectDate);
    if (searchState.displayedPickupDate) {
        viewModel.displayedDropoffDate = searchState.displayedDropoffDate ? [searchState.displayedDropoffDate shortDescriptionFromDate] : CTLocalizedString(CTSDKCalendarSelectDate);
    }
    
    viewModel.enableNextButton = (searchState.displayedPickupDate && searchState.displayedDropoffDate);
    return viewModel;
}

@end
