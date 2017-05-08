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
#import <CartrawlerSDK/CartrawlerSDK+UIView.h>
#import "CTInPathLoadingView.h"
#import "CTSelectedVehicleView.h"
#import "CTCarouselView.h"
#import "CTInPathErrorView.h"
#import <CartrawlerSDK/CTLayoutManager.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CartrawlerSDK+UIImageView.h>
#import "CTInPathLocalizationConstants.h"

@interface CTInPathView() <CTCarouselDelegate, CTSelectedVehicleDelegate>

@property (nonatomic, strong) CTInPathLoadingView *loadingView;
@property (nonatomic, strong) CTCarouselView *carouselView;
@property (nonatomic, strong) CTSelectedVehicleView *selectedVehicleView;
@property (nonatomic, strong) CTInPathErrorView *errorView;

@property (nonatomic, strong) UIView *bannerContainer;
@property (nonatomic, strong) UIView *detailsContainer;
@property (nonatomic, strong) UIView *contentContainer;

@end

@implementation CTInPathView

#pragma mark Render Placeholder

- (instancetype)init
{
    self = [super init];
    
    self.backgroundColor = [UIColor whiteColor];
    
    _bannerContainer = [self renderBanner];
    _detailsContainer = [self renderDetails];
    _contentContainer = [UIView new];
    self.contentContainer.translatesAutoresizingMaskIntoConstraints = NO;

    _loadingView = [CTInPathLoadingView new];
    _carouselView = [CTCarouselView new];
    _selectedVehicleView = [CTSelectedVehicleView new];
    _errorView = [CTInPathErrorView new];

    self.carouselView.delegate = self;
    self.selectedVehicleView.delegate = self;

    [self layout];
    
    return self;
}

- (void)layout
{
    NSDictionary *viewDictionary = @{
                                     @"bannerContainer" : self.bannerContainer,
                                     @"contentContainer" : self.contentContainer,
                                     @"detailsContainer" : self.detailsContainer
                                     };
    
    [self addSubview:self.bannerContainer];
    [self addSubview:self.contentContainer];
    [self addSubview:self.detailsContainer];

    //Banner Container
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bannerContainer]-0-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[bannerContainer(40)]" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[detailsContainer]-0-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bannerContainer]-0-[detailsContainer]" options:0 metrics:nil views:viewDictionary]];
    //Content Container
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[contentContainer]-0-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[detailsContainer]-0-[contentContainer]-0-|" options:0 metrics:nil views:viewDictionary]];
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

- (UIView *)renderDetails
{
    UIView *containerView = [UIView new];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImageView *vehicleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    vehicleImageView.image = [UIImage imageNamed:@"static_cars" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    vehicleImageView.contentMode = UIViewContentModeScaleAspectFit;
    vehicleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:vehicleImageView];

    CTLabel *titleLabel = [[CTLabel alloc] init:17 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft boldFont:YES];
    titleLabel.text = CTLocalizedString(CTInPathWidgetTitle);
    titleLabel.numberOfLines = 1;
    [containerView addSubview:titleLabel];
    
    UIImageView *subtitleTickImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    subtitleTickImageView.translatesAutoresizingMaskIntoConstraints = NO;
    subtitleTickImageView.image = [UIImage imageNamed:@"checkmark" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    [subtitleTickImageView applyTintWithColor:[CTAppearance instance].buttonColor];
    [containerView addSubview:subtitleTickImageView];
    
    CTLabel *subtitleLabel = [[CTLabel alloc] init:15 textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft boldFont:NO];
    subtitleLabel.text = CTLocalizedString(CTInPathWidgetText);
    subtitleLabel.numberOfLines = 0;
    [containerView addSubview:subtitleLabel];
    
    NSDictionary *viewDictionary = @{@"vehicleImageView" : vehicleImageView,
                                     @"titleLabel" : titleLabel,
                                     @"subtitleTickImageView" : subtitleTickImageView,
                                     @"subtitleLabel" : subtitleLabel};
    
    //vehicle illustration
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-65)-[vehicleImageView(125)]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewDictionary]];
    
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[vehicleImageView(125)]-0-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewDictionary]];
    
    //title label
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[titleLabel]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewDictionary]];
    
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[titleLabel]-4-[vehicleImageView]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewDictionary]];
    
    //check image
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subtitleTickImageView(10)]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewDictionary]];
    
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[subtitleTickImageView(10)]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewDictionary]];
    
    //subtitle label
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subtitleTickImageView]-4-[subtitleLabel]-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewDictionary]];
    
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel]-8-[subtitleLabel]-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewDictionary]];
    
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:subtitleTickImageView
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:subtitleLabel
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1
                                                               constant:1]];
    
    [containerView setHeightConstraint:@1 priority:@100];

    return containerView;
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

- (void)showErrorState
{
    [self renderViewInContainer:self.errorView superview:self.contentContainer padding:UIEdgeInsetsMake(8, 8, 8, 8)];
}

//MARK : Carousel Delegate

- (void)didSelectVehicle:(CTAvailabilityItem *)item atIndex:(NSUInteger)index
{
    if (self.delegate) {
        [self.delegate didTapVehicle:item atIndex:index];
    }
}

- (void)didDisplayVehicle:(CTAvailabilityItem *)item atIndex:(NSUInteger)index
{
    if (self.delegate) {
        [self.delegate didDisplayVehicle:item atIndex:index];
    }
}


@end
