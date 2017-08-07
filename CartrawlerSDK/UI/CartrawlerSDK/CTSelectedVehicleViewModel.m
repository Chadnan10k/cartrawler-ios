//
//  CTSelectedVehicleViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleViewModel.h"

@interface CTSelectedVehicleViewModel ()
@property (nonatomic, readwrite) CTSelectedVehicleInfoViewModel *selectedVehicleInfoViewModel;
@property (nonatomic, readwrite) CTSelectedVehicleTabViewModel *selectedVehicleTabViewModel;
@property (nonatomic, readwrite) CTSelectedVehicleInsuranceViewModel *selectedVehicleInsuranceViewModel;
@property (nonatomic, readwrite) CTSelectedVehicleExtrasViewModel *selectedVehicleExtrasViewModel;
@end
@implementation CTSelectedVehicleViewModel

+ (instancetype)viewModelForState:(id)state {
    CTSelectedVehicleViewModel *viewModel = [CTSelectedVehicleViewModel new];
    viewModel.selectedVehicleInfoViewModel = [CTSelectedVehicleInfoViewModel viewModelForState:state];
    viewModel.selectedVehicleTabViewModel = [CTSelectedVehicleTabViewModel viewModelForState:state];
    viewModel.selectedVehicleInsuranceViewModel = [CTSelectedVehicleInsuranceViewModel viewModelForState:state];
    viewModel.selectedVehicleExtrasViewModel = [CTSelectedVehicleExtrasViewModel viewModelForState:state];
    return viewModel;
}

@end
