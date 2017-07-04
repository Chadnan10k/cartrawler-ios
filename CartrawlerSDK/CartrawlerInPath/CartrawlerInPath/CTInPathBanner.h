//
//  CTInPathBanner.h
//  CartrawlerInPath
//
//  Created by Lee Maguire on 20/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTInPathBanner : UIView

- (void)addToSuperViewWithString:(NSString *)bannerString superview:(UIView *)superview;
- (void)setIcon:(UIImage *)image backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor;

@end
