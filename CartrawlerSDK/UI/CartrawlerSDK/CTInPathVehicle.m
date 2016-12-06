//
//  CTInPathVehicle.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 01/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInPathVehicle.h"

@implementation CTInPathVehicle

- (instancetype)init:(CarRentalSearch *)search
{
    self = [super init];
    
    _vehicleName = [NSString stringWithFormat:@"%@ %@", search.selectedVehicle.vehicle.makeModelName, search.selectedVehicle.vehicle.orSimilar];
    _vendorName = search.selectedVehicle.vendor.name;
    _vehicleImageURL = search.selectedVehicle.vehicle.pictureURL;
    _vendorImageURL = search.selectedVehicle.vendor.logoURL;
    _pickupLocationName = search.pickupLocation.name;
    _dropoffLocationName = search.dropoffLocation.name;
    _pickupDate = search.pickupDate;
    _dropoffDate = search.dropoffDate;
    
    NSMutableArray *tempFreeExtras = [NSMutableArray new];
    NSMutableArray *tempPayableExtras = [NSMutableArray new];
    for (CTExtraEquipment *e in search.selectedVehicle.vehicle.extraEquipment) {
        if (e.isIncludedInRate) {
            [tempFreeExtras addObject:e];
        } else if (e.qty > 0) {
            [tempPayableExtras addObject:e];
        }
    }
    
    _isBuyingInsurance = search.isBuyingInsurance;
    if (search.isBuyingInsurance) {
        _insuranceCost = search.insurance.costAmount;
    } else {
        _insuranceCost = @0;
    }
    
    _totalCost = @(self.insuranceCost.doubleValue + search.selectedVehicle.vehicle.totalPriceForThisVehicle.doubleValue);
    
    return self;
}

@end
