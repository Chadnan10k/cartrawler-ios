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
- (void)didTapVehicle:(CTAvailabilityItem *)item atIndex:(NSUInteger)index;
- (void)didDisplayVehicle:(CTAvailabilityItem *)item atIndex:(NSUInteger)index;

@end

@interface CTInPathView : UIView

@property (nonatomic, weak) id<CTInPathViewDelegate> delegate;

- (void)showLoadingState;
- (void)showErrorState;
- (void)showVehicleDetails:(CTAvailabilityItem *)vehicle;
- (void)showVehicleSelection:(CTVehicleAvailability *)availability
                  pickupDate:(NSDate *)pickupDate
                 dropoffDate:(NSDate *)dropoffDate;

@end
