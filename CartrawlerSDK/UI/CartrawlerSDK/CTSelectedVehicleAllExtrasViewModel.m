//
//  CTSelectedVehicleAllExtrasViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/09/2017.
//  Copyright (c) 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleAllExtrasViewModel.h"
#import "CTSelectedVehicleExtrasCellModel.h"

@interface CTSelectedVehicleAllExtrasViewModel ()
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) UIColor *primaryColor;
@property (nonatomic, readwrite) NSArray <CTSelectedVehicleExtrasCellModel *> *cellModels;
@end

@implementation CTSelectedVehicleAllExtrasViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSelectedVehicleAllExtrasViewModel *viewModel = [CTSelectedVehicleAllExtrasViewModel new];
    
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    CTVehicle *vehicle = selectedVehicleState.selectedAvailabilityItem.vehicle;
    
    viewModel.title = CTLocalizedString(CTRentalTitleExtras);
    viewModel.primaryColor = appState.userSettingsState.primaryColor;
    
    NSMutableArray *cellModels = [NSMutableArray new];
    for (CTExtraEquipment *extra in vehicle.extraEquipment) {
        CTSelectedVehicleExtrasCellModel *cellModel = [CTSelectedVehicleExtrasCellModel viewModelForState:appState extra:extra type:CTExtrasCellTypeList];
        [cellModels addObject:cellModel];
        
        NSInteger index = [vehicle.extraEquipment indexOfObject:extra];
        BOOL expandedCell = selectedVehicleState.expandedExtras[index].boolValue; 
        if (expandedCell) {
            CTSelectedVehicleExtrasCellModel *detailModel = [CTSelectedVehicleExtrasCellModel viewModelForState:appState extra:extra type:CTExtrasCellTypeDetail];
            [cellModels addObject:detailModel];
        }
    }
    
    viewModel.cellModels = cellModels.copy;
    
    return viewModel;
}

@end
