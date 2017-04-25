//
//  CTPaymentSummaryContainerView.h
//  CartrawlerRental
//
//  Created by Alan on 19/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTVehicle.h>

@class CTPaymentSummaryContainerView;

/**
 Container view should implement this delegate to be informed of the desired height of the payment view
 */
@protocol CTPaymentSummaryContainerViewDelegate <NSObject>
- (void)paymentView:(CTPaymentSummaryContainerView *)paymentView needsUpdatedHeight:(CGFloat)height animated:(BOOL)animated;
@end


/**
 A view which contains a compact payment view and can animate in a larger summary view
 */
@interface CTPaymentSummaryContainerView : UIView

/**
 A delegate
 */
@property (nonatomic, weak) id <CTPaymentSummaryContainerViewDelegate> delegate;

/**
 Call this to update vehicle information. The delegate method will be triggered requesting a new height.

 @param vehicle a vehicle
 @param animated whether the update should be animated or not
 */
- (void)updateWithVehicle:(CTVehicle *)vehicle animated:(BOOL)animated;

/**
 Call this to collapse the view with animation
 */
- (void)collapseView;

@end
