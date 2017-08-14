//
//  CTSelectedVehicleViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleViewModel.h"

@interface CTSelectedVehicleViewModel ()
@property (nonatomic, readwrite) UIColor *navigationBarColor;
@property (nonatomic, readwrite) CTSelectedVehicleInfoViewModel *selectedVehicleInfoViewModel;
@property (nonatomic, readwrite) CTSelectedVehicleTabViewModel *selectedVehicleTabViewModel;
@property (nonatomic, readwrite) CTSelectedVehicleInsuranceViewModel *selectedVehicleInsuranceViewModel;
@property (nonatomic, readwrite) CTSelectedVehicleExtrasViewModel *selectedVehicleExtrasViewModel;
@end
@implementation CTSelectedVehicleViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSelectedVehicleViewModel *viewModel = [CTSelectedVehicleViewModel new];
    viewModel.navigationBarColor = appState.userSettingsState.primaryColor;
    viewModel.selectedVehicleInfoViewModel = [CTSelectedVehicleInfoViewModel viewModelForState:appState];
    viewModel.selectedVehicleTabViewModel = [CTSelectedVehicleTabViewModel viewModelForState:appState];
    viewModel.selectedVehicleInsuranceViewModel = [CTSelectedVehicleInsuranceViewModel viewModelForState:appState];
    viewModel.selectedVehicleExtrasViewModel = [CTSelectedVehicleExtrasViewModel viewModelForState:appState];
    return viewModel;
}

@end
