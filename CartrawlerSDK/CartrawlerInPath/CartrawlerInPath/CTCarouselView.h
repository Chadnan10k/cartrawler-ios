//
//  CTInPathCarouselView.h
//  CartrawlerInPath
//
//  Created by Lee Maguire on 24/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTVehicleAvailability.h>

@protocol CTCarouselDelegate <NSObject>

@required
- (void)didSelectVehicle:(CTAvailabilityItem *)item atIndex:(NSUInteger)index;
- (void)didDisplayVehicle:(CTAvailabilityItem *)item atIndex:(NSUInteger)index;

@end

@interface CTCarouselView : UIView

@property (weak, nonatomic) id<CTCarouselDelegate> delegate;

- (void)reloadCollectionViewFromAvailability:(CTVehicleAvailability *)availability
                                  pickupDate:(NSDate *)pickupDate
                                     dropoff:(NSDate *)dropoffDate;
@end
