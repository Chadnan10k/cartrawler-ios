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
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.backgroundView];
    [superview addSubview:self];
    
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
    
    //see if touchpoint is at top or bottom
    
    //let take our superviews frame height and divide it by 2
    float superviewHeight = superview.frame.size.height;
    //lets take our touch point
    float touchY = windowPoint.y;
    float yPosition = touchY / superviewHeight;
    
    if (yPosition > 0.5) {
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

    [superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{ @"view" : self.backgroundView }]];
    [superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{ @"view" : self.backgroundView }]];
    
    UITapGestureRecognizer *removeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [self addGestureRecognizer:removeTap];
    
    [superview bringSubviewToFront:self];
    [superview bringSubviewToFront:anchorView];

}

- (void)presentPartialOverlayInView:(UIView *)view text:(NSString *)text
{
    [self removeView];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    [view addSubview:self];
    [view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{ @"view" : self, @"superview" : view }]];
    [view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{ @"view" : self, @"superview" : view  }]];
    [view bringSubviewToFront:self];
    //create uiview with initial height
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectZero];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:containerView];
    
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(300)]-0-|" options:0 metrics:nil views:@{ @"view" : containerView }]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{ @"view" : containerView }]];
    containerView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.9];
    
    UITapGestureRecognizer *removeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [self addGestureRecognizer:removeTap];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectZero];
    closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *b = [NSBundle bundleWithPath:bundlePath];
    
    [closeButton setImage:[UIImage imageNamed:@"tooltip_close" inBundle:b compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:closeButton];
    
    [containerView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(25)]-8-|" options:0 metrics:nil views:@{ @"view" : closeButton }]];
    [containerView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[view(25)]" options:0 metrics:nil views:@{ @"view" : closeButton }]];
    
    CTLabel *textLabel = [[CTLabel alloc] initWithFrame:CGRectZero];
    textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    textLabel.text = text;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.numberOfLines = 0;
    
    [containerView addSubview:textLabel];

    [containerView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|" options:0 metrics:nil views:@{ @"view" : textLabel }]];
    [containerView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[button]-8-[view]" options:0 metrics:nil views:@{ @"view" : textLabel, @"button" : closeButton}]];
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
