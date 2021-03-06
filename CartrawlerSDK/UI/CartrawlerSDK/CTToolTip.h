//
//  CTToolTip.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTToolTipViewController.h"

@interface CTToolTip : UIView

+ (instancetype)instance;

- (void)presentForView:(UIView *)anchorView text:(NSString *)text superview:(UIView *)superview;
- (void)presentPartialOverlayInView:(UIView *)view text:(NSString *)text;
+ (CTToolTipViewController *)fullScreenTooltip:(NSString *)titleText detailText:(NSAttributedString *)detailText;

@end
