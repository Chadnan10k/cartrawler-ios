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
@property (nonatomic, readonly) NSString *total;
@property (nonatomic, readonly) NSString *totalAmount;
@property (nonatomic, readonly) BOOL showToastView;
@property (nonatomic, readonly) NSString *toast;
@property (nonatomic, readonly) NSString *toastOK;
@property (nonatomic, readonly) CTSelectedVehicleInfoViewModel *selectedVehicleInfoViewModel;
@property (nonatomic, readonly) CTSelectedVehicleTabViewModel *selectedVehicleTabViewModel;
@property (nonatomic, readonly) CTSelectedVehicleInsuranceViewModel *selectedVehicleInsuranceViewModel;
@property (nonatomic, readonly) CTSelectedVehicleExtrasViewModel *selectedVehicleExtrasViewModel;
@property (nonatomic, readonly) UIColor *buttonColor;
@end
