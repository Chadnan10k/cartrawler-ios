//
//  CTVehicleListFilterViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTVehicleListFilterHeaderViewModel.h"

@interface CTVehicleListFilterViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) UIColor *navigationBarColor;
@property (nonatomic, readonly) NSString *navigationTitle;
@property (nonatomic, readonly) NSArray <CTVehicleListFilterHeaderViewModel *> *headerViewModels;
@end
