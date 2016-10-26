//
//  CTToolTip.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTToolTip : UIView

+ (void)forceLinkerLoad_;
- (void)presentForView:(UIView *)anchorView text:(NSString *)text;

@end
