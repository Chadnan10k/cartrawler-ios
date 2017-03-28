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
#import "CTInPathLoadingView.h"
#import "CTSelectedVehicleView.h"
#import "CTCarouselView.h"
#import <CartrawlerSDK/CTLayoutManager.h>
@interface CTInPathView() <CTCarouselDelegate>

@property (nonatomic, strong) CTInPathLoadingView *loadingView;
@property (nonatomic, strong) CTCarouselView *carouselView;
@property (nonatomic, strong) CTSelectedVehicleView *selectedVehicleView;
@property (nonatomic, strong) UIView *bannerContainer;
@property (nonatomic, strong) UIView *contentContainer;

@end

@implementation CTInPathView

#pragma mark Render Placeholder

- (instancetype)init
{
    self = [super init];

    _bannerContainer = [self renderBanner];
    _contentContainer = [UIView new];
    self.contentContainer.translatesAutoresizingMaskIntoConstraints = NO;

    _loadingView = [CTInPathLoadingView new];
    _carouselView = [CTCarouselView new];
    _selectedVehicleView = [CTSelectedVehicleView new];
    
    self.carouselView.delegate = self;
    
    [self layout];
    
    return self;
}

- (void)layout
{
    NSDictionary *viewDictionary = @{
                                     @"bannerContainer" : self.bannerContainer,
                                     @"contentContainer" : self.contentContainer
                                     };
    
    [self addSubview:self.bannerContainer];
    [self addSubview:self.contentContainer];

    //Banner Container
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bannerContainer]-0-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[bannerContainer(50)]" options:0 metrics:nil views:viewDictionary]];
    //Content Container
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[contentContainer]-0-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bannerContainer]-0-[contentContainer]-0-|" options:0 metrics:nil views:viewDictionary]];
}

- (void)renderViewInContainer:(UIView *)view superview:(UIView *)superview padding:(UIEdgeInsets)padding
{
    [self removeSubviewsFromContentView];
    [superview addSubview:view];
    
    [CTLayoutManager pinView:view toSuperView:superview padding:padding];
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

- (void)removeSubviewsFromContentView
{
    NSArray *viewsToRemove = [self.contentContainer subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
}

- (void)showLoadingState
{
    [self renderViewInContainer:self.loadingView superview:self.contentContainer padding:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)showVehicleDetails:(CTAvailabilityItem *)vehicle
{
    [self renderViewInContainer:self.selectedVehicleView superview:self.contentContainer padding:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.selectedVehicleView setVehicle:vehicle];
}

- (void)showVehicleSelection:(CTVehicleAvailability *)availability
                  pickupDate:(NSDate *)pickupDate
                 dropoffDate:(NSDate *)dropoffDate
{
    [self renderViewInContainer:self.carouselView superview:self.contentContainer padding:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.carouselView reloadCollectionViewFromAvailability:availability
                                                 pickupDate:pickupDate
                                                    dropoff:dropoffDate];
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
