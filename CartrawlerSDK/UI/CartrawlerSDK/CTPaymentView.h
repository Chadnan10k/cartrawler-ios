//
//  CTPaymentView.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTRentalSearch.h"
#import <CartrawlerAPI/CTGroundBooking.h>

@protocol CTPaymentViewDelegate <NSObject>

- (void)didLoadPaymentView;
- (void)didFailLoadingPaymentView;
- (void)willMakeBooking;
- (void)paymentFailed;
- (void)didMakeBooking;

@end

@interface CTPaymentView : UIView

@property (nonatomic, weak) id<CTPaymentViewDelegate> delegate;

- (void)presentInView:(UIView *)parentView;
- (void)reload;
- (void)setForCarRentalPayment:(CTRentalSearch *)search;

//Controls

- (void)confirmPayment;

@end
