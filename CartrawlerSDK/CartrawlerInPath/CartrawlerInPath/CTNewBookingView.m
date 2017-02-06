//
//  CTNewBookingView.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 20/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTNewBookingView.h"
#import <CartrawlerSDK/CTTextView.h>
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTAppearance.h>
#import "CTInPathBanner.h"
#import <CartrawlerSDK/CartrawlerSDK+UIImageView.h>
#import "CTInPathLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTNewBookingView ()

@property (strong, nonatomic) UIImageView *vehicleImageView;
@property (strong, nonatomic) UITextView *infoLabel;
@property (strong, nonatomic) CTLabel *headerLabel;


@property (strong, nonatomic) UIView *scrollingBannerContainer;
@property (strong, nonatomic) UIImageView *bannerImageView;
@property (strong, nonatomic) UIImageView *tickImageView;

@end

@implementation CTNewBookingView

- (void)awakeFromNib
{
    [super awakeFromNib];
    //NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    //self.vehicleImageView.image = [UIImage imageNamed:@"static_cars" inBundle:bundle compatibleWithTraitCollection:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self addScrollingBannerContainer];
    [self addVehicleImage];
    [self addHeaderLabel];
    [self addStarAndTextView];
    [self addMerchandisingBanner];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self addScrollingBannerContainer];
    [self addVehicleImage];
    [self addHeaderLabel];
    [self addStarAndTextView];
    [self addMerchandisingBanner];
    return self;
}

- (void)addScrollingBannerContainer
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];

    _scrollingBannerContainer = [[UIView alloc] initWithFrame:CGRectZero];
    self.scrollingBannerContainer.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollingBannerContainer.backgroundColor = [CTAppearance instance].insurancePrimaryColor;
    [self addSubview:self.scrollingBannerContainer];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.scrollingBannerContainer}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view(40)]" options:0 metrics:nil views:@{@"view" : self.scrollingBannerContainer}]];
    
    _bannerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bannerImageView.image = [UIImage imageNamed:@"vendor_logos" inBundle:bundle compatibleWithTraitCollection:nil];
    self.bannerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollingBannerContainer addSubview:self.bannerImageView];
    
    [self.scrollingBannerContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.bannerImageView}]];
    [self.scrollingBannerContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.bannerImageView}]];
}

- (void)addVehicleImage
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    _vehicleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.vehicleImageView.contentMode = UIViewContentModeScaleToFill;
    self.vehicleImageView.image = [UIImage imageNamed:@"static_cars" inBundle:bundle compatibleWithTraitCollection:nil];
    self.vehicleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.vehicleImageView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(160)]-8-|" options:0 metrics:nil views:@{@"view" : self.vehicleImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-24-[view(80)]" options:0 metrics:nil views:@{@"view" : self.vehicleImageView}]];

}

- (void)addHeaderLabel
{
    _headerLabel = [[CTLabel alloc] initWithFrame:CGRectZero];
    self.headerLabel.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:15];
    self.headerLabel.text = CTLocalizedString(CTInPathWidgetTitle);
    self.headerLabel.numberOfLines = 1;
    self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.headerLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[label]-8-[cars]" options:0 metrics:nil views:@{@"label" : self.headerLabel, @"cars" : self.vehicleImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[banner]-8-[label(20)]" options:0 metrics:nil views:@{@"label" : self.headerLabel, @"banner" : self.scrollingBannerContainer}]];
}

- (void)addStarAndTextView
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    _tickImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.tickImageView.image = [UIImage imageNamed:@"checkmark" inBundle:bundle compatibleWithTraitCollection:nil];
    self.tickImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tickImageView applyTintWithColor:[CTAppearance instance].buttonColor];

    [self addSubview:self.tickImageView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view(10)]" options:0 metrics:nil views:@{@"view" : self.tickImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headerLabel]-8-[view(10)]" options:0 metrics:nil views:@{@"headerLabel" : self.headerLabel, @"view" : self.tickImageView}]];
    
    _infoLabel = [[UITextView alloc] initWithFrame:CGRectZero];
    self.infoLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:12];
    self.infoLabel.textColor = [UIColor lightGrayColor];
    self.infoLabel.text = CTLocalizedString(CTInPathWidgetText);
    self.infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.infoLabel.backgroundColor = [UIColor clearColor];
    self.infoLabel.userInteractionEnabled = NO;
    [self addSubview:self.infoLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[star]-4-[textView]-4-[cars]" options:0 metrics:nil views:@{@"textView" : self.infoLabel, @"star" : self.tickImageView, @"cars" : self.vehicleImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headerLabel]-4-[textView]-16-|" options:0 metrics:nil views:@{@"textView" : self.infoLabel, @"headerLabel" : self.headerLabel}]];
    [self.infoLabel sizeToFit];
    self.infoLabel.scrollEnabled = NO;
    [self.infoLabel setTextContainerInset:UIEdgeInsetsZero];
}

- (void)addMerchandisingBanner
{
    CTInPathBanner *banner = [[CTInPathBanner alloc] init];
    [banner addToSuperViewWithString:CTLocalizedString(CTInPathWidgetLabel) superview:self.scrollingBannerContainer];
}

- (void)animateVehicle
{
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0.1 options:0 animations:^{
        self.vehicleImageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.vehicleImageView.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }];
}

@end
