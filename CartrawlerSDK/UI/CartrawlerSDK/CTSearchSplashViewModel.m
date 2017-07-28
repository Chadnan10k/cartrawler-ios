//
//  CTSearchSplashViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchSplashViewModel.h"
#import "CTAppState.h"

@interface CTSearchSplashViewModel ()
@property (nonatomic, readwrite) UIColor *splashColor;
@property (nonatomic, readwrite) UIColor *illustrationColor;
@property (nonatomic, readwrite) NSString *splashText;
@property (nonatomic, readwrite) NSString *searchBoxText;
@end

@implementation CTSearchSplashViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSearchSplashViewModel *viewModel = [CTSearchSplashViewModel new];
    viewModel.splashColor = appState.userSettingsState.primaryColor;
    viewModel.illustrationColor = appState.userSettingsState.illustrationColor;
    viewModel.splashText = @"Compare and find the best value car hire deals";
    viewModel.searchBoxText = @"What's your pick up location?";
    return viewModel;
}

@end
