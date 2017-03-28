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

- (void)showLoadingState;
- (void)showVehicleDetails:(CTAvailabilityItem *)vehicle;
- (void)showVehicleSelection:(CTVehicleAvailability *)availability
                  pickupDate:(NSDate *)pickupDate
                 dropoffDate:(NSDate *)dropoffDate;

@end
