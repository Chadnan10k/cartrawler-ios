//
//  CTOptionalExtrasView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTOptionalExtrasView.h"
#import "OptionalExtraTableViewCell.h"
#import <CartrawlerSDK/CTTextView.h>

@interface CTOptionalExtrasView() <UIScrollViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CTTextView *textView;

@end

@implementation CTOptionalExtrasView
{
    BOOL isOpen;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToDestination)];
    [self addGestureRecognizer:tap];
    
    return self;
}

- (void)pushToDestination
{
    if (self.delegate) {
        [self.delegate pushToExtrasView];
    }
}

- (void)hideView:(BOOL)hide
{
    NSLayoutConstraint *heightConstraint;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            heightConstraint = constraint;
            break;
        }
    }
    
    if (hide) {
        heightConstraint.constant = 0;
        self.alpha = 0;
    } else {
        heightConstraint.constant = 50;
        self.alpha = 1;
    }
}

@end
