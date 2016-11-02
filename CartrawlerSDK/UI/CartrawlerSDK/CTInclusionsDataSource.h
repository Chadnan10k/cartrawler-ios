//
//  CTInclusionsDataSource.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 27/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "CarRentalSearch.h"
#import <UIKit/UIKit.h>

@interface CTInclusionsDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

typedef void (^CTInclusionTableCellTapped)(UIView *cell, NSString *text);

@property (nonatomic) CTInclusionTableCellTapped cellTapped;

- (void)setData:(NSArray <CTPricedCoverage *> *)coverages extras:(NSArray <CTExtraEquipment *> *)extras;

@end
