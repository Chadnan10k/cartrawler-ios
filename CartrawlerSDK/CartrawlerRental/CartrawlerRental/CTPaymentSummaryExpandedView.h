//
//  CTPaymentSummaryExpandedView.h
//  CartrawlerSDK
//
//  Created by Alan on 27/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTRentalSearch.h>

/**
 A view showing all extras and total rental cost
 */
@interface CTPaymentSummaryExpandedView : UIView

/**
 Updates the payment information

 @param search a search
 */
- (void)updateWithSearch:(CTRentalSearch *)search;

/**
 Use this instead of intrinsic content size property

 @return the desired height
 */
- (CGFloat)desiredHeight;

@end
