//
//  CTAvailabilityItem.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 23/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTAvailabilityItem.h"

@implementation CTAvailabilityItem


- (instancetype)initWithVendor:(CTVendor *)vendor
                       vehicle:(CTVehicle *)vehicle
                    engineInfo:(CTEngineInfo *)engineInfo
{
    self = [super init];
    
    _vendor = vendor;
    _vehicle = vehicle;
    _engineInfo = engineInfo;
    
    return self;
}

@end
