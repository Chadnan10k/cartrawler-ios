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
#import "CartrawlerAPI/CTVehicle.h"
#import "CartrawlerSDK/CTSDKLocalizationConstants.h"
#import "CartrawlerSDK/CTLocalisedStrings.h"

@interface CTUpSellBanner ()

@property (nonatomic, strong) UIImageView *bannerImageView;
@property (nonatomic, strong) UIImageView *starImageView;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIView *bannerBackground;
@property (nonatomic, strong) NSString *bannerString;
@end

@implementation CTUpSellBanner

- (void)addToSuperview:(UIView *)superview;
{    
    _bannerString = @"";
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addSubview:self];
    
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(30)]" options:0 metrics:nil views:@{@"view" : self}]];
    if (self.alignment == CTUpSellBannerAlignmentLeft) {
        [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]" options:0 metrics:nil views:@{@"view" : self}]];
    } else {
        [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view]-0-|" options:0 metrics:nil views:@{@"view" : self}]];
    }
    
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
    
    if (self.alignment == CTUpSellBannerAlignmentRight) {
        self.bannerImageView.image = [UIImage imageWithCGImage: self.bannerImageView.image.CGImage scale: 1.0f orientation: UIImageOrientationUpMirrored];
    }
    
    [self addSubview:self.bannerImageView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.bannerImageView}]];
    if (self.alignment == CTUpSellBannerAlignmentLeft) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(15)]-0-|" options:0 metrics:nil views:@{@"view" : self.bannerImageView}]];
    } else {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view(15)]" options:0 metrics:nil views:@{@"view" : self.bannerImageView}]];
    }

    _bannerBackground = [[UIView alloc] initWithFrame:CGRectZero];
    self.bannerBackground.backgroundColor = [UIColor yellowColor];
    self.bannerBackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.bannerBackground];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.bannerBackground}]];
    if (self.alignment == CTUpSellBannerAlignmentLeft) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-[bannerImage]" options:0 metrics:nil views:@{@"view" : self.bannerBackground, @"bannerImage" : self.bannerImageView}]];
    } else {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[bannerImage]-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.bannerBackground, @"bannerImage" : self.bannerImageView}]];
    }
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
    if (self.alignment == CTUpSellBannerAlignmentLeft) {
        [self.bannerBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[star(15)]" options:0 metrics:nil views:@{@"star" : self.starImageView}]];
    } else {
        [self.bannerBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[star(15)]-8-|" options:0 metrics:nil views:@{@"star" : self.starImageView}]];
    }

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
    self.infoLabel.textAlignment = self.alignment == CTUpSellBannerAlignmentLeft ? NSTextAlignmentLeft : NSTextAlignmentRight;
    [self.bannerBackground addSubview:self.infoLabel];
    
    [self.bannerBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:0 metrics:nil views:@{@"label" : self.infoLabel, @"background" : self.bannerBackground}]];
    if (self.alignment == CTUpSellBannerAlignmentLeft) {
        [self.bannerBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[star]-8-[label]-4-|" options:0 metrics:nil views:@{@"label" : self.infoLabel, @"star" : self.starImageView}]];
    } else {
        [self.bannerBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[label]-8-[star]" options:0 metrics:nil views:@{@"label" : self.infoLabel, @"star" : self.starImageView}]];
    }
    
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

- (void)setIcon:(UIImage *)image backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor text:(NSString *)text
{
    [self setIcon:image backgroundColor:backgroundColor textColor:textColor];
    self.bannerString = text;
    self.infoLabel.text = text;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeWidth) {
            constraint.constant = [self widthOfString:self.bannerString withFont:self.infoLabel.font] + 60;
        }
    }
}

- (void)setFromMerchandisingTag:(CTMerchandisingTag)merchandisingTag
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIImage *image = [UIImage imageNamed:@"white_checkmark" inBundle:bundle compatibleWithTraitCollection:nil];
    
    [self setIcon:image backgroundColor:[self merchandisingColor:merchandisingTag] textColor:[UIColor whiteColor]];
    self.infoLabel.text = [self merchandisingText:merchandisingTag];
    self.bannerString = self.infoLabel.text;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeWidth) {
            constraint.constant = [self widthOfString:self.bannerString withFont:self.infoLabel.font] + 60;
        }
    }
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

- (NSString *)merchandisingText:(CTMerchandisingTag)merchandisingTag
{
    switch (merchandisingTag) {
        case CTMerchandisingTagBusiness:
            return CTLocalizedString(CTSDKVehicleMerchandisingBusiness);
            
        case CTMerchandisingTagCityBreak:
            return CTLocalizedString(CTSDKVehicleMerchandisingCityBreak);
            
        case CTMerchandisingTagFamilySize:
            return CTLocalizedString(CTSDKVehicleMerchandisingFamilySize);
            
        case CTMerchandisingTagBestSeller:
            return CTLocalizedString(CTSDKVehicleMerchandisingBestSeller);
            
        case CTMerchandisingTagGreatValue:
            return CTLocalizedString(CTSDKVehicleMerchandisingGreatValue);
            break;
            
        case CTMerchandisingTagQuickestQueue:
            return CTLocalizedString(CTSDKVehicleMerchandisingQuickestQueue);
            break;
            
        case CTMerchandisingTagRecommended:
            return CTLocalizedString(CTSDKVehicleMerchandisingRecommended);
            break;
            
        case CTMerchandisingTagUpgradeTo:
            return CTLocalizedString(CTSDKVehicleMerchandisingUpgradeTo);
            break;
            
        case CTMerchandisingTagOnBudget:
            return CTLocalizedString(CTSDKVehicleMerchandisingOnBudget);
            break;
            
        case CTMerchandisingTagBestReviewed:
            return CTLocalizedString(CTSDKVehicleMerchandisingBestReviewed);
            break;
            
        case CTMerchandisingTagUnknown:
            //return CTLocalizedString(CTSDKVehicleMerchandisingBestSeller);
            return @"Great Value";
            break;
    }
}

- (UIColor *)merchandisingColor:(CTMerchandisingTag)merchandisingTag
{
    switch (merchandisingTag) {
        case CTMerchandisingTagBusiness:
            return [UIColor colorWithRed:75.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:1];
            
        case CTMerchandisingTagCityBreak:
            return [UIColor colorWithRed:4.0/255.0 green:119.0/255.0 blue:188.0/255.0 alpha:1];
            
        case CTMerchandisingTagFamilySize:
            return [UIColor colorWithRed:189.0/255.0 green:15.0/255.0 blue:134.0/255.0 alpha:1];
            
        case CTMerchandisingTagBestSeller:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            
        case CTMerchandisingTagGreatValue:
            return [UIColor colorWithRed:41.0/255.0 green:173.0/255.0 blue:79.0/255.0 alpha:1];
            
        case CTMerchandisingTagQuickestQueue:
            return [UIColor colorWithRed:255.0/255.0 green:90.0/255.0 blue:0.0/255.0 alpha:1];
            
        case CTMerchandisingTagRecommended:
            return [UIColor colorWithRed:254.0/255.0 green:67.0/255.0 blue:101.0/255.0 alpha:1];
            
        case CTMerchandisingTagUpgradeTo:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            
        case CTMerchandisingTagOnBudget:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            
        case CTMerchandisingTagBestReviewed:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            
        case CTMerchandisingTagUnknown:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
    }
}

@end
