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

/**
 Sets the vertical offset of the content view to avoid any overlaying toolbars at the top
 */
@property (nonatomic, assign) CGFloat verticalOffset;

- (void)updateSelection:(NSArray <CTAvailabilityItem *> *)data pickupDate:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate sortByPrice:(BOOL)sortByPrice;
- (void)sortByPrice:(BOOL)sortByPrice;
- (void)scrollToTop;

@end
