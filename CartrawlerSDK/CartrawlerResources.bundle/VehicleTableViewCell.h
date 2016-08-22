//
//  VehicleTableViewCell.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartrawlerAPI/CTVehicle.h"

@interface VehicleTableViewCell : UITableViewCell

/**
 *  Populates vehicle table cell
 *
 *  @param vehicle CTVehicle object
 *
 */
- (void)initWithVehicle:(CTVehicle *)vehicle;


+ (void)forceLinkerLoad_;

@end
