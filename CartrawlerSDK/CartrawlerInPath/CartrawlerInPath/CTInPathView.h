//
//  CTInPathView.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTInPathVehicle.h"
#import <CartrawlerAPI/CTVehicleAvailability.h>

@protocol CTInPathViewDelegate <NSObject>

@required
- (void)didTapVehicle:(CTAvailabilityItem *)item;
- (void)didTapShowAll;

@end

@interface CTInPathView : UIView

@property (nonatomic, weak) id<CTInPathViewDelegate> delegate;

- (void)renderVehicleDetails:(CTInPathVehicle *)vehicle animated:(BOOL)animated;
- (void)renderDefault:(BOOL)animated;

- (void)renderCarouselWithAvailability:(CTVehicleAvailability *)availability;

@end
