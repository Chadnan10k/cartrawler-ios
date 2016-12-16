//
//  GroundServicesViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 14/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTGroundAvailability.h>
#import "CTViewController.h"

@interface GroundServicesViewController : CTViewController



- (void)setAvailability:(CTGroundAvailability *)availabilty;

@end
