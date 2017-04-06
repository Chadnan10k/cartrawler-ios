//
//  CTVehicleSelectionView.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartrawlerAPI/CTVehicleAvailability.h"
#import "CartrawlerAPI/CartrawlerAPI.h"

@protocol CTVehicleSelectionViewDelegate <NSObject>

- (void)didSelectVehicle:(CTAvailabilityItem *)item;

@end

@interface CTVehicleSelectionView : UIView

@property (nonatomic, weak) id<CTVehicleSelectionViewDelegate> delegate;

- (void)updateSelection:(NSArray <CTAvailabilityItem *> *)data sortByPrice:(BOOL)sortByPrice;
- (void)showLoading;
- (void)hideLoading;

@end
