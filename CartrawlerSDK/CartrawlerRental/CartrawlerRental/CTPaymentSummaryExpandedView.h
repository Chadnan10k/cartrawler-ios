//
//  CTPaymentSummaryExpandedView.h
//  CartrawlerSDK
//
//  Created by Alan on 27/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerAPI/CTVehicle.h>

/**
 A view showing all extras and total rental cost
 */
@interface CTPaymentSummaryExpandedView : UIView

/**
 Updates the extra equipment list and cost labels

 @param vehicle a vehicle
 */
- (void)updateWithVehicle:(CTVehicle *)vehicle;

/**
 Use this instead of intrinsic content size property

 @return the desired height
 */
- (CGFloat)desiredHeight;

@end
