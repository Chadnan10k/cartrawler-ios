//
//  CTVehicleListFilterCellTableViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTVehicleListFilterModel.h"

@interface CTVehicleListFilterCellTableViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) CTVehicleListFilterModel *filterModel;
@property (nonatomic, readonly) UIColor *primaryColor;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) BOOL selected;

- (instancetype)initWithFilterModel:(CTVehicleListFilterModel *)filterModel
                              title:(NSString *)title
                           selected:(BOOL)selected
                       primaryColor:(UIColor *)primaryColor;

@end
