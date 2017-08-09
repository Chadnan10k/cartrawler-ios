//
//  CTVehicleListFilterModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CTVehicleListFilterType) {
    CTVehicleListFilterTypeSize,
    CTVehicleListFilterTypeVendor,
    CTVehicleListFilterTypeLocation,
    CTVehicleListFilterTypeFuelPolicy,
    CTVehicleListFilterTypeTransmission,
};

@interface CTVehicleListFilterModel : NSObject

@property (nonatomic, readonly) CTVehicleListFilterType filterType;
@property (nonatomic, readonly) NSString *code;

- (instancetype)initWithFilterType:(CTVehicleListFilterType)filterType code:(id)code;

@end
