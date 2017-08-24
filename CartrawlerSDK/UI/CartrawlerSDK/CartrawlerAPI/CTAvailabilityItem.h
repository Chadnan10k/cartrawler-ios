//
//  CTAvailabilityItem.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 23/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTVendor.h"
#import "CTVehicle.h"
#import "CTEngineInfo.h"

@interface CTAvailabilityItem : NSObject

@property (nonatomic, readonly) CTVendor *vendor;
@property (nonatomic, readonly) CTVehicle *vehicle;
@property (nonatomic, readonly) CTEngineInfo *engineInfo;

- (instancetype)initWithVendor:(CTVendor *)vendor
                       vehicle:(CTVehicle *)vehicle
                    engineInfo:(CTEngineInfo *)engineInfo;

@end
