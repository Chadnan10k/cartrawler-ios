//
//  CTPaymentView.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroundTransportSearch.h"
#import "CarRentalSearch.h"
#import <CartrawlerAPI/CTGroundBooking.h>

@protocol CTPaymentViewDelegate <NSObject>

- (void)didLoadPaymentView;
- (void)didFailLoadingPaymentView;
- (void)didMakeBooking;

@end

@interface CTPaymentView : UIView

typedef void (^PaymentCompletion)(BOOL success);

@property (nonatomic, strong) PaymentCompletion completion;
@property (nonatomic, weak) id<CTPaymentViewDelegate> delegate;

- (void)presentInView:(UIView *)parentView;

- (void)setForGTPayment:(GroundTransportSearch *)search;
- (void)setForCarRentalPayment:(CarRentalSearch *)search;

//Controls

- (void)confirmPayment;
- (void)termsAndConditionsChecked:(BOOL)check;

@end
