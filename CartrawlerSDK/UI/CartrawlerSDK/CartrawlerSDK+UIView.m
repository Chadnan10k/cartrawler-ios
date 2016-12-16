//
//  CartrawlerSDK+UIView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerSDK+UIView.h"

@implementation UIView (CartrawlerSDK)

- (NSLayoutConstraint *)heightConstraint
{
    for (NSLayoutConstraint *c in self.constraints) {
        if (c.firstAttribute == NSLayoutAttributeHeight) {
            return c;
        }
    }
    return nil;
}

- (NSLayoutConstraint *)bottomConstraint
{
    for (NSLayoutConstraint *c in self.constraints) {
        if (c.firstAttribute == NSLayoutAttributeBottom) {
            return c;
        }
    }
    return nil;
}

@end
