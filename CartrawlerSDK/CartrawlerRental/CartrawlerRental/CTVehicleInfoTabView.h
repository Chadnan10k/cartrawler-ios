//
//  CTVehicleInfoTabView.h
//  CartrawlerRental
//
//  Created by Alan on 04/05/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTAvailabilityItem;

@interface CTVehicleInfoTabView : UIView

- (instancetype)initWithAvailabilityItem:(CTAvailabilityItem *)availabilityItem containerView:(UIView *)containerView;

@end
