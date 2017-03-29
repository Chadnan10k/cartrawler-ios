//
//  CTSelectedVehicleView.h
//  CartrawlerInPath
//
//  Created by Lee Maguire on 21/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTAvailabilityItem.h>

@protocol CTSelectedVehicleDelegate <NSObject>

- (void)didTapRemoveVehicle;

@end

@interface CTSelectedVehicleView : UIView

@property (weak, nonatomic) id<CTSelectedVehicleDelegate> delegate;

- (void)setVehicle:(CTAvailabilityItem *)vehicle;
- (void)animateVehicle;

@end
