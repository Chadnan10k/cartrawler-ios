//
//  CTSearchInterstitialViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchInterstitialViewModel.h"
#import "CartrawlerSDK+NSDateUtils.h"

@interface CTSearchInterstitialViewModel ()
@property (nonatomic, readwrite) UIColor *navigationBarColor;
@property (nonatomic, readwrite) NSString *navigationBarTitle;
@property (nonatomic, readwrite) NSString *navigationBarDetail;
@end

@implementation CTSearchInterstitialViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSearchState *searchState = appState.searchState;
    
    CTSearchInterstitialViewModel *viewModel = [CTSearchInterstitialViewModel new];
    CTUserSettingsState *userSettingsState = appState.userSettingsState;
    viewModel.navigationBarColor = userSettingsState.primaryColor;
    viewModel.navigationBarTitle = searchState.selectedPickupLocation.name;
    viewModel.navigationBarDetail = [NSString stringWithFormat:@"%@ - %@", [searchState.selectedPickupDate shortDescriptionFromDate], [searchState.selectedDropoffDate shortDescriptionFromDate]];
    return viewModel;
}

@end
