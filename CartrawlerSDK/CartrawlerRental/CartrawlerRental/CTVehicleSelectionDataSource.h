//
//  CTVehicleSelectionViewModel.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartrawlerAPI/CTVehicleAvailability.h"
#import <UIKit/UIKit.h>

@protocol CTVehicleSelectionDelegate <NSObject>

- (void)didSelectCellAtIndex:(NSIndexPath *)indexPath data:(CTAvailabilityItem *)data;

@end

@interface CTVehicleSelectionDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<CTVehicleSelectionDelegate> delegate;

- (void)updateData:(NSArray <CTAvailabilityItem *> *)data sortByPrice:(BOOL)sortByPrice;


@end
