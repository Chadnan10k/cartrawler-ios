//
//  VehicleFeaturesDataSource.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 25/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CarRentalSearch.h"

@interface CTVehicleInclusionsDataSource : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

typedef void (^CTInclusionTableCellTapped)(UIView *cell, NSString *text);

@property (nonatomic) CTInclusionTableCellTapped cellTapped;

- (void)setData:(NSArray <CTPricedCoverage *> *)coverages extras:(NSArray <CTExtraEquipment *> *)extras;

@end
