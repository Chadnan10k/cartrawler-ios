//
//  CartrawlerSDK+UIView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerSDK+UIView.h"

@implementation UIView (CartrawlerSDK)

- (NSLayoutConstraint *)cartrawlerConstraintForAttribute:(NSLayoutAttribute)attribute
{
    for (NSLayoutConstraint *c in self.constraints) {
        if (c.firstAttribute == attribute) {
            return c;
        }
    }
    return nil;
}

- (void)setHeightConstraint:(NSNumber *)constant priority:(NSNumber *)priority
{
    NSString *formatString = [NSString stringWithFormat:@"V:[self(%@@%@)]", constant.stringValue, priority.stringValue];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:@{@"self" : self}]];
}

- (void)setWidthConstraint:(NSNumber *)constant priority:(NSNumber *)priority
{
    NSString *formatString = [NSString stringWithFormat:@"H:[self(%@@%@)]", constant.stringValue, priority.stringValue];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:@{@"self" : self}]];
}


@end
