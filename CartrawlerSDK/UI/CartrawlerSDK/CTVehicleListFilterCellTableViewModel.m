//
//  CTVehicleListFilterCellTableViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleListFilterCellTableViewModel.h"

@implementation CTVehicleListFilterCellTableViewModel

- (instancetype)initWithFilterModel:(CTVehicleListFilterModel *)filterModel title:(NSString *)title selected:(BOOL)selected {
    self = [super init];
    if (self) {
        _filterModel = filterModel;
        
        // Remove all caps from vendors
        _title = (filterModel.filterType == CTVehicleListFilterTypeVendor) ? [title capitalizedString] : title;
        
        _selected = selected;
    }
    return self;
}

@end
