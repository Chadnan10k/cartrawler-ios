//
//  CTDesignableView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTDesignableView.h"
#import "CTAppearance.h"

@implementation CTDesignableView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    _borderColor = [UIColor groupTableViewBackgroundColor];
    _cornerRadius = 5;
    _borderWidth = 1;
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    return self;
}

- (void)awakeFromNib
{
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    self.layer.cornerRadius = [CTAppearance instance].containerViewCornerRadius;
    
    if (self.enableShadow || [CTAppearance instance].enableShadows) {
        self.layer.masksToBounds = NO;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.05;
        self.layer.shadowRadius = 10;
    }
    
    if (self.enableGradient) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
        CAGradientLayer *gradientMask = [CAGradientLayer layer];
        gradientMask.frame = self.bounds;
        gradientMask.colors = @[(id)[UIColor groupTableViewBackgroundColor].CGColor,
                                (id)[UIColor clearColor].CGColor];
        self.layer.mask = gradientMask;
    }
    
    [super awakeFromNib];
}

@end
