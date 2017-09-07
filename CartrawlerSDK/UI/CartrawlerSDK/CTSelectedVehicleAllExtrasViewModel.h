//
//  CTSelectedVehicleAllExtrasViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/09/2017.
//  Copyright (c) 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTSelectedVehicleExtrasCellModel.h"

@interface CTSelectedVehicleAllExtrasViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) UIColor *primaryColor;
@property (nonatomic, readonly) NSArray <CTSelectedVehicleExtrasCellModel *> *cellModels;

@end
