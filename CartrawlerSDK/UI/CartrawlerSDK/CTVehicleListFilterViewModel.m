//
//  CTVehicleListFilterViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleListFilterViewModel.h"
#import "CTAppState.h"

@interface CTVehicleListFilterViewModel ()
@property (nonatomic, readwrite) UIColor *navigationBarColor;
@property (nonatomic, readwrite) NSArray <CTVehicleListFilterHeaderViewModel *> *headerViewModels;
@end

@implementation CTVehicleListFilterViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTVehicleListFilterViewModel *viewModel = [CTVehicleListFilterViewModel new];
    viewModel.navigationBarColor = appState.userSettingsState.primaryColor;
    viewModel.headerViewModels =  [CTVehicleListFilterViewModel headerViewModelsForState:appState];
    return viewModel;
}

+ (NSArray *)headerViewModelsForState:(CTAppState *)appState {
    NSArray *items = [appState.APIState.matchedAvailabilityItems objectForKey:appState.APIState.availabilityRequestTimestamp];
    CTVehicleListState *vehicleListState = appState.vehicleListState;
    UIColor *primaryColor = appState.userSettingsState.primaryColor;
    
    NSArray *selectedFilters = vehicleListState.displayedFilters;
    
    NSMutableArray *headerViewModels = [NSMutableArray new];
    
    NSMutableArray *sizes = [NSMutableArray new];
    NSMutableArray *vendors = [NSMutableArray new];
    NSMutableArray *locations = [NSMutableArray new];
    NSMutableArray *fuelPolicies = [NSMutableArray new];
    NSMutableArray *transmissions = [NSMutableArray new];
    
    NSMutableArray *sizeViewModels = [NSMutableArray new];
    NSMutableArray *vendorViewModels = [NSMutableArray new];
    NSMutableArray *locationViewModels = [NSMutableArray new];
    NSMutableArray *fuelPolicyViewModels = [NSMutableArray new];
    NSMutableArray *transmissionViewModels = [NSMutableArray new];
    
    // TODO: There must be a better way
    
    for (CTAvailabilityItem *item in items) {
        NSNumber *sizeCode = @(item.vehicle.size);
        if (![sizes containsObject:sizeCode]) {
            [sizes addObject:sizeCode];
            
            CTVehicleListFilterCellTableViewModel *viewModel = [self viewModelsForFilterType:CTVehicleListFilterTypeSize
                                                                                        code:sizeCode
                                                                                       title:[CTLocalisedStrings vehicleSize:item.vehicle.size]
                                                                             selectedFilters:selectedFilters
                                                                                primaryColor:primaryColor];
            [sizeViewModels addObject:viewModel];
        }
        
        NSString *vendorCode = item.vendor.name;
        if (![vendors containsObject:vendorCode]) {
            [vendors addObject:vendorCode];
            
            CTVehicleListFilterCellTableViewModel *viewModel = [self viewModelsForFilterType:CTVehicleListFilterTypeVendor
                                                                                        code:vendorCode
                                                                                       title:item.vendor.name
                                                                             selectedFilters:selectedFilters
                                                                                primaryColor:primaryColor];
            [vendorViewModels addObject:viewModel];
        }
        
        NSNumber *locationCode = @(item.vendor.pickupLocation.pickupType);
        if (![locations containsObject:locationCode]) {
            [locations addObject:locationCode];
            
            NSString *title = [CTLocalisedStrings pickupType:item] ?: CTLocalizedString(CTRentalVehiclePickupLocationUnknown);
            
            CTVehicleListFilterCellTableViewModel *viewModel = [self viewModelsForFilterType:CTVehicleListFilterTypeLocation
                                                                                        code:locationCode
                                                                                       title:title
                                                                             selectedFilters:selectedFilters
                                                                                primaryColor:primaryColor];
            [locationViewModels addObject:viewModel];
        }
        
        NSNumber *fuelPolicyCode = @(item.vehicle.fuelPolicy);
        if (![fuelPolicies containsObject:fuelPolicyCode]) {
            [fuelPolicies addObject:fuelPolicyCode];
            
            CTVehicleListFilterCellTableViewModel *viewModel = [self viewModelsForFilterType:CTVehicleListFilterTypeFuelPolicy
                                                                                        code:fuelPolicyCode
                                                                                       title:item.vehicle.fuelPolicyDescription
                                                                             selectedFilters:selectedFilters
                                                                                primaryColor:primaryColor];
            [fuelPolicyViewModels addObject:viewModel];
        }
        
        NSString *transmissionCode = item.vehicle.transmissionType;
        if (![transmissions containsObject:transmissionCode]) {
            [transmissions addObject:transmissionCode];
            
            CTVehicleListFilterCellTableViewModel *viewModel = [self viewModelsForFilterType:CTVehicleListFilterTypeTransmission
                                                                                        code:transmissionCode
                                                                                       title:[CTLocalisedStrings transmission:item.vehicle.transmissionType]
                                                                             selectedFilters:selectedFilters
                                                                                primaryColor:primaryColor];
            [transmissionViewModels addObject:viewModel];
        }
    }
    
    if (sizeViewModels.count > 0) {
        CTVehicleListFilterHeaderViewModel *viewModel = [[CTVehicleListFilterHeaderViewModel alloc] initWithFilterType:CTVehicleListFilterTypeSize title:CTLocalizedString(CTRentalFilterCarsize) rowViewModels:sizeViewModels primaryColor:primaryColor];
        [headerViewModels addObject:viewModel];
    }
    
    if (vendorViewModels.count > 0) {
        CTVehicleListFilterHeaderViewModel *viewModel = [[CTVehicleListFilterHeaderViewModel alloc] initWithFilterType:CTVehicleListFilterTypeVendor title:CTLocalizedString(CTRentalFilterSupplier) rowViewModels:vendorViewModels primaryColor:primaryColor];
        [headerViewModels addObject:viewModel];
    }
    
    if (locationViewModels.count > 0) {
        CTVehicleListFilterHeaderViewModel *viewModel = [[CTVehicleListFilterHeaderViewModel alloc] initWithFilterType:CTVehicleListFilterTypeLocation title:CTLocalizedString(CTRentalFilterPickup) rowViewModels:locationViewModels primaryColor:primaryColor];
        [headerViewModels addObject:viewModel];
    }
    
    if (fuelPolicyViewModels.count > 0) {
        CTVehicleListFilterHeaderViewModel *viewModel = [[CTVehicleListFilterHeaderViewModel alloc] initWithFilterType:CTVehicleListFilterTypeLocation title:CTLocalizedString(CTRentalFilterFuel) rowViewModels:fuelPolicyViewModels primaryColor:primaryColor];
        [headerViewModels addObject:viewModel];
    }
    
    if (transmissionViewModels.count > 0) {
        CTVehicleListFilterHeaderViewModel *viewModel = [[CTVehicleListFilterHeaderViewModel alloc] initWithFilterType:CTVehicleListFilterTypeLocation title:CTLocalizedString(CTRentalFilterTransmission) rowViewModels:transmissionViewModels primaryColor:primaryColor];
        [headerViewModels addObject:viewModel];
    }
    
    return headerViewModels;
}

+ (CTVehicleListFilterCellTableViewModel *)viewModelsForFilterType:(CTVehicleListFilterType)filterType
                                                              code:(id)code
                                                             title:(NSString *)title
                                                   selectedFilters:(NSArray *)selectedFilters
                                                      primaryColor:(UIColor *)primaryColor {
    CTVehicleListFilterModel *model = [[CTVehicleListFilterModel alloc] initWithFilterType:filterType code:code];
    return [[CTVehicleListFilterCellTableViewModel alloc] initWithFilterModel:model
                                                                        title:title
                                                                     selected:[selectedFilters containsObject:model]
                                                                 primaryColor:primaryColor];
}

@end
