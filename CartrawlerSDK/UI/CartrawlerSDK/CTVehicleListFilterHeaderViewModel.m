//
//  CTVehicleListFilterHeaderViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleListFilterHeaderViewModel.h"

@implementation CTVehicleListFilterHeaderViewModel

- (instancetype)initWithFilterType:(CTVehicleListFilterType)filterType
                             title:(NSString *)title
                     rowViewModels:(NSArray <CTVehicleListFilterCellTableViewModel *> *)rowViewModels {
    self = [super init];
    if (self) {
        _filterType = filterType;
        _title = title;
        _detail = @"Select All";
        _rowViewModels = rowViewModels;
    }
    return self;
}

@end
