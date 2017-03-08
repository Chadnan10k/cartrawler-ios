//
//  CTVehicleDetailsView.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 07/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTVehicle.h>

@protocol CTVehicleDetailsDelegate <NSObject>

/**
 Fires when a user taps on a info collection view cell
 */
- (void)didTapMoreDetailsView;

@end

@interface CTVehicleDetailsView : UIView

@property (weak, nonatomic) id<CTVehicleDetailsDelegate> delegate;

/**
 Updates the view with a selected vehicle

 @param vehicle The selected vehicle
 @param pickupDate The pickup date
 @param dropoffDate The dropoff date
 */
- (void)setVehicle:(CTVehicle *)vehicle pickupDate:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate;

@end