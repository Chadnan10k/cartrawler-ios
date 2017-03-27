//
//  CTInPathView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInPathView.h"
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTLayoutManager.h>
#import "CTInPathLoadingView.h"
#import "CTSelectedVehicleView.h"
#import "CTCarouselView.h"

@interface CTInPathView() <CTCarouselDelegate>

@property (nonatomic, strong) CTLayoutManager *layoutManager;
@property (nonatomic, strong) CTInPathLoadingView *loadingView;
@property (nonatomic, strong) CTSelectedVehicleView *selectedVehicleView;
@property (nonatomic, strong) CTCarouselView *carouselView;

@end

@implementation CTInPathView

#pragma mark Render Placeholder

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self setup];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (void)setup
{
    _layoutManager = [CTLayoutManager layoutManagerWithContainer:self];
    [self renderLoadingView];
    UIView *banner = [self renderBanner];
    [self addSubview:banner];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : banner}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view(40)]" options:0 metrics:nil views:@{@"view" : banner}]];
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

#pragma mark Render Vehicle
- (void)renderVehicleDetails:(CTInPathVehicle *)vehicle animated:(BOOL)animated
{
    
    [self removeSubviews];
    
    _selectedVehicleView = [[CTSelectedVehicleView alloc] initWithFrame:CGRectZero];

    self.selectedVehicleView.backgroundColor = [UIColor whiteColor];
    self.selectedVehicleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.selectedVehicleView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.selectedVehicleView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[view]-50-|" options:0 metrics:nil views:@{@"view" : self.selectedVehicleView}]];
    
    [self.selectedVehicleView setVehicle:vehicle];
    if (animated) {
        [self.selectedVehicleView animateVehicle];
    }
}

- (void)renderLoadingView
{
    [self removeSubviews];
    
    _loadingView = [CTInPathLoadingView new];
    
    self.loadingView.backgroundColor = [UIColor whiteColor];
    self.loadingView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.loadingView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.loadingView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.loadingView}]];

}

- (void)renderCarouselWithAvailability:(CTVehicleAvailability *)availability
{
    [self removeSubviews];
    
    _carouselView = [CTCarouselView carouselFromAvail:availability];
    self.carouselView.delegate = self;
    self.carouselView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.carouselView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.carouselView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.carouselView}]];
    
}

- (UIView *)renderBanner
{
    UIView *bannerView = [UIView new];
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    bannerView.backgroundColor = [CTAppearance instance].headerTitleColor;
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    UIImageView *bannerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    bannerImageView.image = [UIImage imageNamed:@"vendor_logos" inBundle:bundle compatibleWithTraitCollection:nil];
    bannerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [bannerView addSubview: bannerImageView];
    
    [bannerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : bannerImageView}]];
    [bannerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : bannerImageView}]];
    
    return bannerView;
}

- (void)removeSubviews
{
//    NSArray *viewsToRemove = [self subviews];
//    for (UIView *v in viewsToRemove) {
//        
//        [v removeFromSuperview];
//    }
}

//MARK : Carousel Delegate

- (void)didSelectVehicle:(CTAvailabilityItem *)item
{
    if (self.delegate) {
        [self.delegate didTapVehicle:item];
    }
}

- (void)didSelectViewAll
{
    if (self.delegate) {
        [self.delegate didTapShowAll];
    }
}

@end
