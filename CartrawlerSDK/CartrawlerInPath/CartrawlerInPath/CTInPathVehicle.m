//
//  CTInPathVehicle.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 01/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInPathVehicle.h"

@implementation CTInPathVehicle

- (instancetype)init:(CTRentalSearch *)search
{
    self = [super init];
    
    _vehicleName = search.selectedVehicle.vehicle.makeModelName;
    _vehicleOrSimilar = search.selectedVehicle.vehicle.orSimilar;
    _vendorName = search.selectedVehicle.vendor.name;
    _vehicleImageURL = search.selectedVehicle.vehicle.pictureURL;
    _vendorImageURL = search.selectedVehicle.vendor.logoURL;
    _pickupLocationName = search.pickupLocation.name;
    _dropoffLocationName = search.dropoffLocation.name;
    _pickupDate = search.pickupDate;
    _dropoffDate = search.dropoffDate;
    _firstName = search.firstName;
    _lastName = search.surname;
    
    _payNowPrice = @0;
    _payAtDeskPrice = @0;
    _payLaterPrice = @0;
    _bookingFeePrice = @0;
    
    NSMutableArray *tempFreeExtras = [NSMutableArray new];
    NSMutableArray *tempPayableExtras = [NSMutableArray new];
    for (CTExtraEquipment *e in search.selectedVehicle.vehicle.extraEquipment) {
        if (e.isIncludedInRate) {
            [tempFreeExtras addObject:e];
        } else if (e.qty > 0) {
            [tempPayableExtras addObject:e];
        }
    }
    
    for (CTFee *fee in search.selectedVehicle.vehicle.fees) {
        if ([fee.feePurpose isEqualToString:@"22"]) {
            _payNowPrice = fee.feeAmount;
        } else if ([fee.feePurpose isEqualToString:@"23"]) {
            _payAtDeskPrice = fee.feeAmount;
        } else if ([fee.feePurpose isEqualToString:@"6"]) {
            _bookingFeePrice = fee.feeAmount;
        }
    }
        
    _payNowPrice = [NSNumber numberWithDouble: self.payNowPrice.doubleValue + search.insurance.premiumAmount.doubleValue + self.bookingFeePrice.doubleValue];
    
    _isBuyingInsurance = search.isBuyingInsurance;
    if (search.isBuyingInsurance) {
        _insuranceCost = search.insurance.premiumAmount;
    } else {
        _insuranceCost = @0;
    }
    
    _totalCost = @(self.insuranceCost.doubleValue + search.selectedVehicle.vehicle.totalPriceForThisVehicle.doubleValue);
    
    return self;
}

@end
