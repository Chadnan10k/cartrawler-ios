//
//  CartrawlerSDK+UIView.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CartrawlerSDK)

- (NSLayoutConstraint *)cartrawlerConstraintForAttribute:(NSLayoutAttribute)attribute;

- (void)setHeightConstraint:(NSNumber *)constant priority:(NSNumber *)priority;
- (void)setWidthConstraint:(NSNumber *)constant priority:(NSNumber *)priority;

@end
