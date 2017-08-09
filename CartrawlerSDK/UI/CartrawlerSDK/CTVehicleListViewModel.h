//
//  CTVehicleListViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTVehicleListTableViewModel.h"
#import "CTVehicleListState.h"
#import "CTVehicleListFilterViewModel.h"

@interface CTVehicleListViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) NSString *leftLabelText;
@property (nonatomic, readonly) NSAttributedString *rightLabelText;
@property (nonatomic, readonly) NSArray <CTVehicleListTableViewModel *> *rowViewModels;

@property (nonatomic, readonly) CTVehicleListFilterViewModel *filterViewModel;

@property (nonatomic) CTVehicleListSelectedView selectedView;

@property (nonatomic, readonly) NSString *sortTitle;
@property (nonatomic, readonly) NSArray *sortOptions;
@property (nonatomic, readonly) NSString *cancelTitle;
@property (nonatomic, readonly) CTVehicleListSort selectedSort;
@property (nonatomic) BOOL scrollToTop;

@end
