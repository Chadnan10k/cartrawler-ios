//
//  VehicleTableViewCell.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartrawlerAPI/CTAvailabilityItem.h"

@interface VehicleTableViewCell : UITableViewCell

/**
 *  Populates vehicle table cell
 *
 *  @param vehicle CTVehicle object
 *
 */
- (void)initWithVehicle:(CTAvailabilityItem *)item;


+ (void)forceLinkerLoad_;

@end
