//
//  CTSelectedVehicleTabViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleTabViewModel.h"

@interface CTSelectedVehicleTabViewModel ()
@property (nonatomic, readwrite) NSString *included;
@property (nonatomic, readwrite) NSString *ratings;
@property (nonatomic, readwrite) UIColor *includedColor;
@property (nonatomic, readwrite) UIColor *ratingsColor;

@end

@implementation CTSelectedVehicleTabViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSelectedVehicleTabViewModel *viewModel = [CTSelectedVehicleTabViewModel new];
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    
    viewModel.included = @"Included";
    viewModel.ratings = @"Ratings";
    UIColor *primaryColor = appState.userSettingsState.primaryColor;
    viewModel.includedColor = selectedVehicleState.selectedTab == CTSelectedVehicleTabIncluded ? primaryColor : [UIColor lightGrayColor];
    viewModel.ratingsColor = selectedVehicleState.selectedTab == CTSelectedVehicleTabRatings ? primaryColor : [UIColor lightGrayColor];
    return viewModel;
}

@end
