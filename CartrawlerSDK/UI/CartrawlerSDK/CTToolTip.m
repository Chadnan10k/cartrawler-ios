//
//  CTToolTip.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTToolTip.h"
#import "CTLabel.h"

@interface CTToolTip()

@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation CTToolTip

+ (instancetype)instance
{
    static CTToolTip *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CTToolTip alloc] initWithFrame:CGRectZero];
    });
    return sharedInstance;
}

+ (void)forceLinkerLoad_ { }

- (void)presentForView:(UIView *)anchorView text:(NSString *)text superview:(UIView *)superview
{
    [self removeView];
    self.frame = superview.frame;
    _backgroundView = [[UIView alloc] initWithFrame:superview.frame];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.7];
    [self addSubview:self.backgroundView];
    [anchorView.superview addSubview:self];
    
    //create the tool tip box
    UIView *tipBox = [[UIView alloc] initWithFrame:CGRectZero];
    tipBox.layer.cornerRadius = 5;
    tipBox.backgroundColor = [UIColor whiteColor];
    
    CTLabel *tipLabel = [[CTLabel alloc] initWithFrame:CGRectZero];
    tipLabel.text = text;
    [tipLabel adjustsFontSizeToFitWidth];
    tipLabel.numberOfLines = 0;
    
    tipBox.translatesAutoresizingMaskIntoConstraints = NO;
    tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:tipBox];
    [tipBox addSubview:tipLabel];
    
    float maxTipTextWidth = 200;
    //create constraints
    CGSize stringBoundingBox = [text sizeWithAttributes: @{NSFontAttributeName: tipLabel.font}];
    
    float tipWidth = stringBoundingBox.width > 200 ? stringBoundingBox.width / (stringBoundingBox.width / maxTipTextWidth)+16 : stringBoundingBox.width+16;
    float tipHeight = (stringBoundingBox.width / maxTipTextWidth) * stringBoundingBox.height+50;
    
    [superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(width)]" options:0 metrics:@{ @"width" : [NSNumber numberWithFloat:tipWidth] }  views:@{ @"view" : tipBox, @"anchor" : anchorView }]];
    
    CGPoint windowPoint = [anchorView convertPoint:anchorView.bounds.origin toView:superview.window];
    
    if ((windowPoint.y + 100) < superview.frame.size.height && (windowPoint.y- tipHeight+16) > tipHeight-8) {
        [superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(height)]-8-[anchor]" options:0 metrics:@{ @"height" : [NSNumber numberWithFloat:tipHeight] } views:@{ @"view" : tipBox , @"anchor" : anchorView }]];
    } else {
        [superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[anchor]-8-[view(height)]" options:0 metrics:@{ @"height" : [NSNumber numberWithFloat:tipHeight] } views:@{ @"view" : tipBox , @"anchor" : anchorView }]];
    }
    
    if ((anchorView.frame.origin.x + tipWidth) > superview.frame.size.width) {
        [superview addConstraint:[NSLayoutConstraint constraintWithItem:tipBox attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:anchorView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    } else {
        [superview addConstraint:[NSLayoutConstraint constraintWithItem:tipBox attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:anchorView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    }
    
    [superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{ @"view" : self, @"super" : superview }]];
    [superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{ @"view" : self, @"super" : superview }]];
    
    [tipBox addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[view]-8-|" options:0 metrics:nil views:@{ @"view" : tipLabel, @"super" : tipBox }]];
    [tipBox addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|" options:0 metrics:nil views:@{ @"view" : tipLabel, @"super" : tipBox }]];

    UITapGestureRecognizer *removeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [self addGestureRecognizer:removeTap];
    
    [anchorView.superview bringSubviewToFront:anchorView];

}

- (void)removeView
{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        [self removeGestureRecognizer:gesture];
    }
    
    [self removeFromSuperview];
}

@end
