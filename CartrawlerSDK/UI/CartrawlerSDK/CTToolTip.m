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

+ (void)forceLinkerLoad_ { }

- (void)presentForView:(UIView *)anchorView text:(NSString *)text presentFrom:(CTToolTipPresentation)presentFrom
{
    self.frame = anchorView.superview.frame;
    _backgroundView = [[UIView alloc] initWithFrame:anchorView.superview.frame];
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

    [anchorView.superview bringSubviewToFront:anchorView];
    
    
    float maxTipTextWidth = 200;
    //create constraints
    CGSize stringBoundingBox = [text sizeWithAttributes: @{NSFontAttributeName: tipLabel.font}];
    
    float tipWidth = stringBoundingBox.width > 200 ? stringBoundingBox.width / (stringBoundingBox.width / maxTipTextWidth)+16 : stringBoundingBox.width+16;
    float tipHeight = (stringBoundingBox.width / maxTipTextWidth) * stringBoundingBox.height+50;
    
    [anchorView.superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(width)]" options:0 metrics:@{ @"width" : [NSNumber numberWithFloat:tipWidth] }  views:@{ @"view" : tipBox, @"anchor" : anchorView }]];

    switch (presentFrom) {
        case CTToolTipPresentationLeft:
            [anchorView.superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(height)]-8-[anchor]" options:0 metrics:@{ @"height" : [NSNumber numberWithFloat:tipHeight] } views:@{ @"view" : tipBox , @"anchor" : anchorView }]];
            [anchorView.superview addConstraint:[NSLayoutConstraint constraintWithItem:tipBox attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:anchorView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
            break;
        case CTToolTipPresentationRight:
            [anchorView.superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(height)]-8-[anchor]" options:0 metrics:@{ @"height" : [NSNumber numberWithFloat:tipHeight] } views:@{ @"view" : tipBox , @"anchor" : anchorView }]];
            [anchorView.superview addConstraint:[NSLayoutConstraint constraintWithItem:tipBox attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:anchorView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
            break;
        case CTToolTipPresentationTop:
            [anchorView.superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[anchor]-8-[view(height)]" options:0 metrics:@{ @"height" : [NSNumber numberWithFloat:tipHeight] } views:@{ @"view" : tipBox , @"anchor" : anchorView }]];
            [anchorView.superview addConstraint:[NSLayoutConstraint constraintWithItem:tipBox attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:anchorView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
            break;
        case CTToolTipPresentationBottom:
            [anchorView.superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(height)]-8-[anchor]" options:0 metrics:@{ @"height" : [NSNumber numberWithFloat:tipHeight] } views:@{ @"view" : tipBox , @"anchor" : anchorView }]];
            [anchorView.superview addConstraint:[NSLayoutConstraint constraintWithItem:tipBox attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:anchorView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
            break;
    }
    
    [anchorView.superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{ @"view" : self, @"super" : anchorView.superview }]];
    [anchorView.superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{ @"view" : self, @"super" : anchorView.superview }]];
    
    [tipBox addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[view]-8-|" options:0 metrics:nil views:@{ @"view" : tipLabel, @"super" : tipBox }]];
    [tipBox addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|" options:0 metrics:nil views:@{ @"view" : tipLabel, @"super" : tipBox }]];

    UITapGestureRecognizer *removeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [self addGestureRecognizer:removeTap];
}

- (void)removeView
{
    [self removeFromSuperview];
}

@end
