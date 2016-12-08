//
//  CTInPathVehicle.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 01/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTRentalSearch.h"

@interface CTInPathVehicle : NSObject

@property (nonatomic, strong, readonly) NSString *vehicleName;
@property (nonatomic, strong, readonly) NSString *vendorName;
@property (nonatomic, strong, readonly) NSURL *vehicleImageURL;
@property (nonatomic, strong, readonly) NSURL *vendorImageURL;
@property (nonatomic, strong, readonly) NSString *pickupLocationName;
@property (nonatomic, strong, readonly) NSString *dropoffLocationName;
@property (nonatomic, strong, readonly) NSDate *pickupDate;
@property (nonatomic, strong, readonly) NSDate *dropoffDate;
@property (nonatomic, strong, readonly) NSArray <CTExtraEquipment *> *extrasIncludedForFree;
@property (nonatomic, strong, readonly) NSArray <CTExtraEquipment *> *extrasPayableAtDesk;
@property (nonatomic, readonly) BOOL isBuyingInsurance;
@property (nonatomic, readonly) NSNumber *insuranceCost;
@property (nonatomic, readonly) NSNumber *totalCost;

- (instancetype)init:(CTRentalSearch *)search;

@end
