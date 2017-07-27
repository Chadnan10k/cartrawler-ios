//
//  CTVehicleListState.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/26/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleListState.h"

@implementation CTVehicleListState

- (instancetype)init {
    self = [super init];
    if (self) {
        _selectedFilters = [NSMutableArray new];
    }
    return self;
}

@end
