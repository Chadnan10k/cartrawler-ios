//
//  CTSelectedVehicleExtrasViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleExtrasViewModel.h"
#import "CTAppState.h"

@interface CTSelectedVehicleExtrasViewModel ()
@property (nonatomic, readwrite) NSArray <CTSelectedVehicleExtrasCellModel *> *cellModels;
@property (nonatomic, readwrite) NSArray <NSNumber *> *flippedExtras;
@end

@implementation CTSelectedVehicleExtrasViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSelectedVehicleExtrasViewModel *viewModel = [CTSelectedVehicleExtrasViewModel new];
    
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    CTVehicle *vehicle = selectedVehicleState.selectedAvailabilityItem.vehicle;
    
    NSMutableArray *cellModels = [NSMutableArray new];
    for (CTExtraEquipment *extra in vehicle.extraEquipment) {
        CTSelectedVehicleExtrasCellModel *cellModel = [CTSelectedVehicleExtrasCellModel viewModelForState:appState extra:extra];
        [cellModels addObject:cellModel];
    }
    
    viewModel.cellModels = cellModels.copy;
    
    viewModel.flippedExtras = selectedVehicleState.flippedExtras;
    
    return viewModel;
}

@end
