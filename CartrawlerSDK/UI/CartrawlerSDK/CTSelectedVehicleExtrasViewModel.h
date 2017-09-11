//
//  CTSelectedVehicleExtrasViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTSelectedVehicleExtrasCellModel.h"

@interface CTSelectedVehicleExtrasViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) UIColor *primaryColor;
@property (nonatomic, readonly) NSArray <CTSelectedVehicleExtrasCellModel *> *cellModels;

@end
