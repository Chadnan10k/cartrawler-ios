//
//  CTVehicleDetailTableViewCell.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 06/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartrawlerAPI/CTAvailabilityItem.h"

@interface CTVehicleDetailTableViewCell : UITableViewCell

- (void)setItem:(CTAvailabilityItem *)item pickupDate:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate;

@end
