//
//  CTFilterFactory.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 03/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTFilterFactory.h"
#import <CartrawlerAPI/CTFilter.h>

@interface CTFilterFactory()

@property (strong, nonatomic) NSMutableArray<CTVehicle *> *sizeData;
@property (strong, nonatomic) NSMutableArray<CTVehicle *> *locationData;
@property (strong, nonatomic) NSMutableArray<CTVendor *> *vendorsData;
@property (strong, nonatomic) NSMutableArray<CTVehicle *> *transmissionData;
@property (strong, nonatomic) NSMutableArray<CTVehicle *> *carSpecsData;
@property (strong, nonatomic) NSMutableArray<CTVehicle *> *fuelPolicyData;

@property (strong, nonatomic) NSArray<CTVehicle *> *selectedSizeData;
@property (strong, nonatomic) NSArray<CTVehicle *> *selectedFuelPolicyData;
@property (strong, nonatomic) NSArray<CTVehicle *> *selectedTransmissionData;
@property (strong, nonatomic) NSArray<CTVehicle *> *selectedCarSpecsData;
@property (strong, nonatomic) NSArray *selectedLocationData;
@property (strong, nonatomic) NSArray<CTVendor *> *selectedVendorsData;

@property (strong, nonatomic) CTVehicleAvailability *data;

@end

@implementation CTFilterFactory

- (void)setDataSources
{
    _carSizeDataSource = [[CTFilterDataSource alloc] initWithData:self.sizeData
                                                     selectedData:self.selectedSizeData
                                                       filterType:FilterDataTypeVehicleSize];
    
    _locationDataSource = [[CTFilterDataSource alloc] initWithData:self.locationData
                                                      selectedData:self.selectedLocationData
                                                        filterType:FilterDataTypeLocation];
    
    _vendorsDataSource = [[CTFilterDataSource alloc] initWithData:self.vendorsData
                                                     selectedData:self.selectedVendorsData
                                                       filterType:FilterDataTypeVendor];
    
    _fuelPolicyDataSource = [[CTFilterDataSource alloc] initWithData:self.fuelPolicyData
                                                        selectedData:self.selectedFuelPolicyData
                                                          filterType:FilterDataTypeFuelPolicy];
    
    _transmissionDataSource = [[CTFilterDataSource alloc] initWithData:self.transmissionData
                                                          selectedData:self.selectedTransmissionData
                                                            filterType:FilterDataTypeTransmission];
    
    self.carSizeDataSource.filterCompletion = ^(NSArray<CTVehicle *> *filteredData){
        _selectedSizeData = filteredData;
    };
    
    self.locationDataSource.filterCompletion = ^(NSArray *filteredData){
        _selectedLocationData = filteredData;
    };
    
    self.vendorsDataSource.filterCompletion = ^(NSArray<CTVendor *> *filteredData){
        _selectedVendorsData = filteredData;
    };
    
    self.fuelPolicyDataSource.filterCompletion = ^(NSArray<CTVehicle *> *filteredData){
        _selectedFuelPolicyData = filteredData;
    };
    
    self.transmissionDataSource.filterCompletion = ^(NSArray<CTVehicle *> *filteredData){
        _selectedTransmissionData = filteredData;
    };
}

- (id)initWithFilterData:(CTVehicleAvailability *)data;
{
    self = [super init];
    _filteredData = [[NSMutableArray alloc] init];
    
    _data = data;
    _selectedVendorsData    = [[NSMutableArray alloc] init];
    _selectedLocationData   = [[NSMutableArray alloc] init];
    _selectedSizeData       = [[NSMutableArray alloc] init];
    _selectedFuelPolicyData = [[NSMutableArray alloc] init];
    
    _sizeData       = [[NSMutableArray alloc] init];
    _locationData   = [[NSMutableArray alloc] init];
    _vendorsData    = [[NSMutableArray alloc] init];
    _transmissionData = [[NSMutableArray alloc] init];
    _carSpecsData   = [[NSMutableArray alloc] init];
    _fuelPolicyData = [[NSMutableArray alloc] init];
    
    //vehicle size
    for (CTVehicle *v in data.allVehicles) {
        BOOL found = NO;
        for (CTVehicle *s in self.sizeData) {
            if ([v.categoryDescriptionCode isEqualToString: s.categoryDescriptionCode]) {
                found = YES;
            }
        }
        if (!found) {
            [self.sizeData addObject:v];
        }
    }
    //vendors
    for (int i = 0; i < data.availableVendors.count; ++i) {
        
        BOOL found = NO;
        for (int x = 0; x < self.vendorsData.count; ++x) {
            if ([data.availableVendors[i].name isEqualToString:self.vendorsData[x].name]) {
                found = YES;
            } else {
                found = NO;
            }
        }
        if (!found) {
            [self.vendorsData addObject:data.availableVendors[i]];
        }
    }
    
    //location
    for (CTVehicle *v in data.allVehicles) {
        BOOL found = NO;
        for (CTVehicle *s in self.locationData) {
            if (v.vendor.pickupType == PickupTypeUnknown) {
                found = YES;
            } else if (v.vendor.pickupType == s.vendor.pickupType) {
                found = YES;
            }
        }
        if (!found) {
            [self.locationData addObject:v];
        }
    }
    
    //vehicle size
    for (CTVehicle *v in data.allVehicles) {
        BOOL found = NO;
        for (CTVehicle *s in self.transmissionData) {
            if ([v.transmissionType isEqualToString: s.transmissionType]) {
                found = YES;
            }
        }
        if (!found) {
            [self.transmissionData addObject:v];
        }
    }
    
    //fuel policy
    for (CTVehicle *v in data.allVehicles) {
        BOOL found = NO;
        for (CTVehicle *s in self.fuelPolicyData) {
            if (v.fuelPolicy == s.fuelPolicy) {
                found = YES;
            }
        }
        if (!found) {
            [self.fuelPolicyData addObject:v];
        }
    }
    
    //transmission
    for (CTVehicle *v in data.allVehicles) {
        BOOL found = NO;
        for (CTVehicle *s in self.transmissionData) {
            if ([v.transmissionType isEqualToString: s.transmissionType]) {
                found = YES;
            }
        }
        if (!found) {
            [self.transmissionData addObject:v];
        }
    }
    return self;
}

- (void)filter
{
    NSMutableArray<CTVehicle *> *filteredData = [[NSMutableArray alloc] init];
    
    filteredData =  [[NSMutableArray alloc] initWithArray:self.data.allVehicles];
    
    //pick away each car one by one
    NSMutableArray *vehsToAdd = [[NSMutableArray alloc] init];
    
    //car size
    for (CTVehicle *veh in filteredData) {
        for (CTVehicle *selectedVeh in self.selectedSizeData) {
            BOOL found = NO;
            
            if ([veh.categoryDescriptionCode isEqualToString:selectedVeh.categoryDescriptionCode]) {
                found = YES;
            }
            
            if (found) {
                if (![vehsToAdd containsObject:veh]) {
                    [vehsToAdd addObject:veh];
                }
            }
        }
    }
    
    NSMutableArray *vehsToAddStep2;
    
    //car vendor
    if (self.selectedSizeData.count == 0 && self.selectedVendorsData.count == 0) {
        vehsToAddStep2 = [[NSMutableArray alloc] initWithArray:self.data.allVehicles];
    } else if (self.selectedSizeData.count == 0 && self.selectedVendorsData.count != 0) {
        vehsToAddStep2 = [[NSMutableArray alloc] init];
        for (CTVendor *ven in self.selectedVendorsData) {
            for (CTVehicle *veh in self.data.allVehicles) {
                if ([ven.name isEqualToString:veh.vendor.name]) {
                    if (![vehsToAddStep2 containsObject:veh]) {
                        [vehsToAddStep2 addObject:veh];
                    }
                }
            }
        }
    } else if (self.selectedSizeData.count != 0 && self.selectedVendorsData.count == 0) {
        vehsToAddStep2 = [[NSMutableArray alloc] initWithArray:vehsToAdd];
    } else {
        vehsToAddStep2 = [[NSMutableArray alloc] init];
        for (CTVendor *ven in self.selectedVendorsData) {
            for (CTVehicle *veh in vehsToAdd) {
                if ([ven.name isEqualToString:veh.vendor.name]) {
                    if (![vehsToAddStep2 containsObject:veh]) {
                        [vehsToAddStep2 addObject:veh];
                    }
                }
            }
        }
    }
    
    //fuel policy
    NSMutableArray *vehsToAddStep3 = [[NSMutableArray alloc] init];
    if (self.selectedFuelPolicyData.count == 0) {
        vehsToAddStep3 = vehsToAddStep2;
    } else {
        for (CTVehicle *veh in vehsToAddStep2) {
            for (CTVehicle *selectedVeh in self.selectedFuelPolicyData) {
                BOOL found = NO;
                
                if (veh.fuelPolicy == selectedVeh.fuelPolicy) {
                    found = YES;
                }
                
                if (found) {
                    if (![vehsToAddStep3 containsObject:veh]) {
                        [vehsToAddStep3 addObject:veh];
                    }
                }
            }
        }
    }
    
    //transmission
    NSMutableArray *vehsToAddStep4 = [[NSMutableArray alloc] init];
    if (self.selectedTransmissionData.count == 0) {
        vehsToAddStep4 = vehsToAddStep3;
    } else {
        for (CTVehicle *veh in vehsToAddStep3) {
            for (CTVehicle *selectedVeh in self.selectedTransmissionData) {
                BOOL found = NO;
                
                if ([veh.transmissionType isEqualToString: selectedVeh.transmissionType]) {
                    found = YES;
                }
                
                if (found) {
                    if (![vehsToAddStep4 containsObject:veh]) {
                        [vehsToAddStep4 addObject:veh];
                    }
                }
            }
        }
    }
    
    //pickup type
    NSMutableArray *vehsToAddStep5 = [[NSMutableArray alloc] init];
    if (self.selectedLocationData.count == 0) {
        vehsToAddStep5 = vehsToAddStep4;
    } else {
        for (CTVehicle *v in vehsToAddStep4) {
            for (CTVehicle *selectedVeh in self.selectedLocationData) {
                BOOL found = NO;
                
                if (v.vendor.pickupType == selectedVeh.vendor.pickupType) {
                    found = YES;
                }
                
                if (found) {
                    if (![vehsToAddStep5 containsObject:v]) {
                        [vehsToAddStep5 addObject:v];
                    }
                }
            }
        }
    }
    
    _filteredData = [[NSMutableArray alloc] initWithArray:vehsToAddStep5];
    _filteredData = [[NSMutableArray alloc] initWithArray:[CTFilter sortPrice:YES cars:self.filteredData]];
}

@end
