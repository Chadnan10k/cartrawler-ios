//
//  CTPaymentController.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 15/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CTAppState.h"

@interface CTPaymentController : NSObject

- (instancetype)initWithContainerView:(UIView *)containerView;
- (void)makePaymentWithState:(CTAppState *)state;

@end
