//
//  BookingSummaryViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTAvailabilityItem.h>

@interface BookingSummaryViewController : UIViewController

+ (void)forceLinkerLoad_;

- (void)setDataWithVehicle:(CTAvailabilityItem *)vehicle
                pickupDate:(NSDate *)pickupDate
               dropoffDate:(NSDate *)dropoffDate
         isBuyingInsurance:(BOOL)isBuyingInsurance;

@end
