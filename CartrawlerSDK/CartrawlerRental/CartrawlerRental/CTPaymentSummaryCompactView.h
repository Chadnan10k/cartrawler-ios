//
//  CTPaymentSummaryCompactView.h
//  CartrawlerRental
//
//  Created by Alan on 19/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTVehicle.h>

/**
 View with a button to view other cars, a label to display total cost and a chevron
 */
@interface CTPaymentSummaryCompactView : UIView

/**
 Updates the total cost label

 @param vehicle a vehicle
 */
- (void)updateWithVehicle:(CTVehicle *)vehicle;

@end
