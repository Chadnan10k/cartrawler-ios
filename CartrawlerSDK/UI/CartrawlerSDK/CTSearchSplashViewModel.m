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
@property (nonatomic, readwrite) UIColor *primaryColor;
@property (nonatomic, readwrite) NSString *splashText;
@property (nonatomic, readwrite) NSString *searchBoxText;
@end

@implementation CTSearchSplashViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSearchSplashViewModel *viewModel = [CTSearchSplashViewModel new];
    viewModel.primaryColor = [UIColor redColor];
    viewModel.splashText = @"Compare and find the best value car hire deals";
    viewModel.searchBoxText = @"What's your pick up location?";
    return viewModel;
}

@end
