//
//  CTVehicleListFilterHeaderViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTVehicleListFilterCellTableViewModel.h"

@interface CTVehicleListFilterHeaderViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) CTVehicleListFilterType filterType;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *detail;
@property (nonatomic, readonly) UIColor *primaryColor;
@property (nonatomic, readonly) NSArray <CTVehicleListFilterCellTableViewModel *> *rowViewModels;
@property (nonatomic, readonly) NSArray <CTVehicleListFilterModel *> *filterModels;

- (instancetype)initWithFilterType:(CTVehicleListFilterType)filterType
                             title:(NSString *)title
                     rowViewModels:(NSArray <CTVehicleListFilterCellTableViewModel *> *)rowViewModels
                      primaryColor:(UIColor *)primaryColor;

@end