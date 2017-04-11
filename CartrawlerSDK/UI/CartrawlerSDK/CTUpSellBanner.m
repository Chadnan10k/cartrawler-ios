//
//  CTInPathBanner.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 20/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTUpSellBanner.h"
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CartrawlerSDK+UIImageView.h>

@interface CTUpSellBanner ()

@property (nonatomic, strong) UIImageView *bannerImageView;
@property (nonatomic, strong) UIImageView *starImageView;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIView *bannerBackground;
@property (nonatomic, strong) NSString *bannerString;
@end

@implementation CTUpSellBanner

- (void)addToSuperViewWithString:(NSString *)bannerString superview:(UIView *)superview
{
    _bannerString = bannerString;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addSubview:self];
    
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(30)]" options:0 metrics:nil views:@{@"view" : self}]];
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]" options:0 metrics:nil views:@{@"view" : self}]];
    
    [superview addConstraint:
     [NSLayoutConstraint constraintWithItem:self
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superview
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                   constant:0]];
    [self addBannerImageView];
    [self addInfoLabel];
    [self applyColorsToBackground:[CTAppearance instance].buttonColor];
}

- (void)addBannerImageView
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];

    _bannerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bannerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bannerImageView.image = [UIImage imageNamed:@"banner" inBundle:bundle compatibleWithTraitCollection:nil];
    [self addSubview:self.bannerImageView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.bannerImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(15)]-0-|" options:0 metrics:nil views:@{@"view" : self.bannerImageView}]];

    _bannerBackground = [[UIView alloc] initWithFrame:CGRectZero];
    self.bannerBackground.backgroundColor = [UIColor yellowColor];
    self.bannerBackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.bannerBackground];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.bannerBackground}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-[bannerImage]" options:0 metrics:nil views:@{@"view" : self.bannerBackground, @"bannerImage" : self.bannerImageView}]];
}

- (void)addInfoLabel
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    _starImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.starImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.starImageView.image = [UIImage imageNamed:@"star" inBundle:bundle compatibleWithTraitCollection:nil];
    self.starImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.bannerBackground addSubview:self.starImageView];
    
    [self.bannerBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[star(15)]" options:0 metrics:nil views:@{@"star" : self.starImageView, @"background" : self.bannerBackground}]];
    [self.bannerBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[star(15)]" options:0 metrics:nil views:@{@"star" : self.starImageView}]];

    [self.bannerBackground addConstraint:
     [NSLayoutConstraint constraintWithItem:self.starImageView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.bannerBackground
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                   constant:0]];
    
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.infoLabel.text = self.bannerString;
    self.infoLabel.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:17];
    [self.bannerBackground addSubview:self.infoLabel];
    
    [self.bannerBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:0 metrics:nil views:@{@"label" : self.infoLabel, @"background" : self.bannerBackground}]];
    [self.bannerBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[star]-8-[label]-4-|" options:0 metrics:nil views:@{@"label" : self.infoLabel, @"star" : self.starImageView}]];
    
    [self.bannerBackground addConstraint:
     [NSLayoutConstraint constraintWithItem:self.infoLabel
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.bannerBackground
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:0
                                     toItem:nil
                                  attribute:0
                                 multiplier:1
                                   constant:50]];// initial width
    
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeWidth) {
            constraint.constant = [self widthOfString:self.bannerString withFont:self.infoLabel.font] + 60;
        }
    }
}

- (void)applyColorsToBackground:(UIColor *)color
{
    [self.bannerImageView applyTintWithColor:color];
    self.bannerBackground.backgroundColor = color;
}

- (void)setIcon:(UIImage *)image backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor
{
    self.starImageView.image = image;
    [self.starImageView applyTintWithColor:textColor];

    [self applyColorsToBackground:backgroundColor];
    self.infoLabel.textColor = textColor;
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

@end
