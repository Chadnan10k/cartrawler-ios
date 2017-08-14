//
//  CTSelectedVehicleViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTSelectedVehicleInfoViewModel.h"
#import "CTSelectedVehicleTabViewModel.h"
#import "CTSelectedVehicleInsuranceViewModel.h"
#import "CTSelectedVehicleExtrasViewModel.h"

@interface CTSelectedVehicleViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) UIColor *navigationBarColor;
@property (nonatomic, readonly) CTSelectedVehicleInfoViewModel *selectedVehicleInfoViewModel;
@property (nonatomic, readonly) CTSelectedVehicleTabViewModel *selectedVehicleTabViewModel;
@property (nonatomic, readonly) CTSelectedVehicleInsuranceViewModel *selectedVehicleInsuranceViewModel;
@property (nonatomic, readonly) CTSelectedVehicleExtrasViewModel *selectedVehicleExtrasViewModel;
@end
