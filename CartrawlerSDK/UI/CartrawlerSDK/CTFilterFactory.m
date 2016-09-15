//
//  CTFilterFactory.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 03/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTFilterFactory.h"

@interface CTFilterFactory()

@property (strong, nonatomic) NSMutableArray<CTAvailabilityItem *> *sizeData;
@property (strong, nonatomic) NSMutableArray<CTAvailabilityItem *> *locationData;
@property (strong, nonatomic) NSMutableArray<CTAvailabilityItem *> *vendorsData;
@property (strong, nonatomic) NSMutableArray<CTAvailabilityItem *> *transmissionData;
@property (strong, nonatomic) NSMutableArray<CTAvailabilityItem *> *carSpecsData;
@property (strong, nonatomic) NSMutableArray<CTAvailabilityItem *> *fuelPolicyData;

@property (strong, nonatomic) NSArray<CTAvailabilityItem *> *selectedSizeData;
@property (strong, nonatomic) NSArray<CTAvailabilityItem *> *selectedFuelPolicyData;
@property (strong, nonatomic) NSArray<CTAvailabilityItem *> *selectedTransmissionData;
@property (strong, nonatomic) NSArray<CTAvailabilityItem *> *selectedLocationData;
@property (strong, nonatomic) NSArray<CTAvailabilityItem *> *selectedVendorsData;

@property (copy, nonatomic) CTVehicleAvailability *data;

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
    
    //possible memory leak referencing self in block
    self.carSizeDataSource.filterCompletion = ^(NSArray<CTAvailabilityItem *> *filteredData){
        _selectedSizeData = filteredData;
    };
    
    self.locationDataSource.filterCompletion = ^(NSArray<CTAvailabilityItem *> *filteredData){
        _selectedLocationData = filteredData;
    };
    
    self.vendorsDataSource.filterCompletion = ^(NSArray<CTAvailabilityItem *> *filteredData){
        _selectedVendorsData = filteredData;
    };
    
    self.fuelPolicyDataSource.filterCompletion = ^(NSArray<CTAvailabilityItem *> *filteredData){
        _selectedFuelPolicyData = filteredData;
    };
    
    self.transmissionDataSource.filterCompletion = ^(NSArray<CTAvailabilityItem *> *filteredData){
        _selectedTransmissionData = filteredData;
    };
}

- (void)update:(CTVehicleAvailability *)data
{
    _data = data;

    self.filteredData = [[NSMutableArray alloc] init];
    
    _selectedVendorsData    = [[NSArray alloc] init];
    _selectedLocationData   = [[NSArray alloc] init];
    _selectedSizeData       = [[NSArray alloc] init];
    _selectedFuelPolicyData = [[NSArray alloc] init];
    _selectedTransmissionData = [[NSArray alloc] init];
    
    [self.sizeData removeAllObjects];
    [self.locationData removeAllObjects];
    [self.vendorsData removeAllObjects];
    [self.transmissionData removeAllObjects];
    [self.carSpecsData removeAllObjects];
    [self.fuelPolicyData removeAllObjects];
    
    [self setupData];
}

- (id)initWithFilterData:(CTVehicleAvailability *)data;
{
    self = [super init];
    _filteredData = [[NSMutableArray alloc] init];
    
    _data = data;
    _selectedVendorsData    = [[NSArray alloc] init];
    _selectedLocationData   = [[NSArray alloc] init];
    _selectedSizeData       = [[NSArray alloc] init];
    _selectedFuelPolicyData = [[NSArray alloc] init];
    _selectedTransmissionData = [[NSArray alloc] init];

    _sizeData       = [[NSMutableArray alloc] init];
    _locationData   = [[NSMutableArray alloc] init];
    _vendorsData    = [[NSMutableArray alloc] init];
    _transmissionData = [[NSMutableArray alloc] init];
    _carSpecsData   = [[NSMutableArray alloc] init];
    _fuelPolicyData = [[NSMutableArray alloc] init];
    
    [self setupData];
    return self;
}

- (void)setupData
{
    //vehicle size
    for (CTAvailabilityItem *item in self.data.items) {
        BOOL found = NO;
        for (CTAvailabilityItem *i in self.sizeData) {
            if ([item.vehicle.sizeCode isEqualToString: i.vehicle.sizeCode]) {
                found = YES;
            }
        }
        if (!found) {
            [self.sizeData addObject:item];
        }
    }
    
    //vendors
    for (int i = 0; i < self.data.items.count; ++i) {
        
        BOOL found = NO;
        for (int x = 0; x < self.vendorsData.count; ++x) {
            if ([self.data.items[i].vendor.name isEqualToString:self.vendorsData[x].vendor.name]) {
                found = YES;
                break;
            } else {
                found = NO;
            }
        }
        if (!found) {
            [self.vendorsData addObject:self.data.items[i]];
        }
    }
    
    //    //location
    for (CTAvailabilityItem *v in self.data.items) {
        BOOL found = NO;
        for (CTAvailabilityItem *s in self.locationData) {
            if (v.vendor.pickupLocation.pickupType == PickupTypeUnknown) {
                found = YES;
            } else if (v.vendor.pickupLocation.pickupType == s.vendor.pickupLocation.pickupType) {
                found = YES;
            }
        }
        if (!found) {
            [self.locationData addObject:v];
        }
    }
    
    //fuel policy
    for (CTAvailabilityItem *v in self.data.items) {
        BOOL found = NO;
        for (CTAvailabilityItem *s in self.fuelPolicyData) {
            if (v.vehicle.fuelPolicy == s.vehicle.fuelPolicy) {
                found = YES;
            }
        }
        if (!found) {
            [self.fuelPolicyData addObject:v];
        }
    }
    
    //transmission
    for (CTAvailabilityItem *v in self.data.items) {
        BOOL found = NO;
        for (CTAvailabilityItem *s in self.transmissionData) {
            if ([v.vehicle.transmissionType isEqualToString: s.vehicle.transmissionType]) {
                found = YES;
            }
        }
        if (!found) {
            [self.transmissionData addObject:v];
        }
    }
}


- (void)filter
{
    NSMutableArray<CTAvailabilityItem *> *filteredData = [[NSMutableArray alloc] init];
    
    filteredData =  [[NSMutableArray alloc] initWithArray:self.data.items];
    
    //pick away each car one by one
    NSMutableArray *vehsToAdd = [[NSMutableArray alloc] init];
    
    //car size
    for (CTAvailabilityItem *veh in filteredData) {
        for (CTAvailabilityItem *selectedVeh in self.selectedSizeData) {
            BOOL found = NO;
            
            if ([veh.vehicle.sizeCode isEqualToString:selectedVeh.vehicle.sizeCode]) {
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
        vehsToAddStep2 = [[NSMutableArray alloc] initWithArray:self.data.items];
    } else if (self.selectedSizeData.count == 0 && self.selectedVendorsData.count != 0) {
        vehsToAddStep2 = [[NSMutableArray alloc] init];
        for (CTAvailabilityItem *ven in self.selectedVendorsData) {
            for (CTAvailabilityItem *veh in self.data.items) {
                if ([ven.vendor.name isEqualToString:veh.vendor.name]) {
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
        for (CTAvailabilityItem *ven in self.selectedVendorsData) {
            for (CTAvailabilityItem *veh in vehsToAdd) {
                if ([ven.vendor.name isEqualToString:veh.vendor.name]) {
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
        for (CTAvailabilityItem *veh in vehsToAddStep2) {
            for (CTAvailabilityItem *selectedVeh in self.selectedFuelPolicyData) {
                BOOL found = NO;

                if (veh.vehicle.fuelPolicy == selectedVeh.vehicle.fuelPolicy) {
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
        for (CTAvailabilityItem *veh in vehsToAddStep3) {
            for (CTAvailabilityItem *selectedVeh in self.selectedTransmissionData) {
                BOOL found = NO;
                
                if ([veh.vehicle.transmissionType isEqualToString: selectedVeh.vehicle.transmissionType]) {
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
        for (CTAvailabilityItem *v in vehsToAddStep4) {
            for (CTAvailabilityItem *selectedVeh in self.selectedLocationData) {
                BOOL found = NO;
                
                if (v.vendor.pickupLocation.pickupType == selectedVeh.vendor.pickupLocation.pickupType) {
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
    //_filteredData = [[NSMutableArray alloc] initWithArray:[CTFilter sortPrice:YES cars:self.filteredData]];
    
}

@end
