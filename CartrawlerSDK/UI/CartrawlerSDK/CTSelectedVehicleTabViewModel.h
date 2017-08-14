//
//  CTSelectedVehicleTabViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTAppState.h"
#import <CartrawlerAPI/CTExtraEquipment.h>
#import "CTSelectedVehicleIncludedViewModel.h"
#import "CTSelectedVehicleRatingsViewModel.h"

@interface CTSelectedVehicleTabViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) CTSelectedVehicleTab selectedTab;
@property (nonatomic, readonly) NSString *included;
@property (nonatomic, readonly) NSString *ratings;
@property (nonatomic, readonly) UIColor *includedColor;
@property (nonatomic, readonly) UIColor *ratingsColor;
@property (nonatomic, readonly) CTSelectedVehicleIncludedViewModel *selectedVehicleIncludedViewModel;
@property (nonatomic, readonly) CTSelectedVehicleRatingsViewModel *selectedVehicleRatingsViewModel;

@end
