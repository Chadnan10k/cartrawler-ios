//
//  CTVehicleListState.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/26/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTVehicleListFilterModel.h"

typedef NS_ENUM(NSUInteger, CTVehicleListSelectedView) {
    CTVehicleListSelectedViewNone,
    CTVehicleListSelectedViewSort,
    CTVehicleListSelectedViewFilter,
};

typedef NS_ENUM(NSUInteger, CTVehicleListSort) {
    CTVehicleListSortRecommended,
    CTVehicleListSortPrice,
};

@interface CTVehicleListState : NSObject

@property (nonatomic) CTVehicleListSelectedView selectedView;
@property (nonatomic) CTVehicleListSort selectedSort;
@property (nonatomic) NSMutableArray <CTVehicleListFilterModel *> *displayedFilters;
@property (nonatomic) NSArray <CTVehicleListFilterModel *> *selectedFilters;
@property (nonatomic) BOOL scrollToTop;

@end
