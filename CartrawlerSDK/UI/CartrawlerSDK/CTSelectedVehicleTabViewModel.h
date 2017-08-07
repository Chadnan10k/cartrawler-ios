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

@interface CTSelectedVehicleTabViewModel : NSObject <CTViewModelProtocol>

@property (nonatomic, readonly) NSString *included;
@property (nonatomic, readonly) NSString *ratings;
@property (nonatomic, readonly) UIColor *includedColor;
@property (nonatomic, readonly) UIColor *ratingsColor;

@end
