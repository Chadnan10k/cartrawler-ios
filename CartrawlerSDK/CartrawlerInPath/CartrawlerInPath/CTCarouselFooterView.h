//
//  CTCarouselFooterView.h
//  CartrawlerInPath
//
//  Created by Lee Maguire on 27/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTVehicle.h>

@interface CTCarouselFooterView : UIView

- (void)setVehicle:(CTVehicle *)vehicle
        pickupDate:(NSDate *)pickupDate
       dropoffDate:(NSDate *)dropoffDate;

@end
