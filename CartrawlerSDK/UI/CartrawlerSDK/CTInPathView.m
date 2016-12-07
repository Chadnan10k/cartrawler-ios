//
//  CTInPathView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInPathView.h"
#import "CTLabel.h"
#import <CartrawlerSDK/CTImageCache.h>

@interface CTInPathView()

//didSelectVehicle
@property (nonatomic, strong) UIView *selectedVehicleView;
@property (nonatomic, strong) CTLabel *vehicleNameLabel;
@property (nonatomic, strong) UIImageView *vehicleImageView;

//static placeholder
@property (nonatomic, strong) UIView *staticPlaceholderView;
@property (nonatomic, strong) UIImageView *placeholderImageView;

@end

@implementation CTInPathView

#pragma mark Render Placeholder
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self renderStaticPlaceholder];
}

- (void)renderStaticPlaceholder
{
    _staticPlaceholderView = [UIView new];
    self.staticPlaceholderView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.staticPlaceholderView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.staticPlaceholderView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.staticPlaceholderView}]];
    _placeholderImageView = [UIImageView new];
    self.placeholderImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.staticPlaceholderView addSubview:self.placeholderImageView];
    
    [self.staticPlaceholderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.placeholderImageView}]];
    [self.staticPlaceholderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.placeholderImageView}]];
    self.placeholderImageView.image = [UIImage imageNamed:@"success_car"
                                                 inBundle:[NSBundle bundleForClass:[self class]]
                            compatibleWithTraitCollection:nil];
}

#pragma mark Render Vehicle
- (void)renderVehicleDetails:(CTInPathVehicle *)vehicle
{
    [self renderView:vehicle];
}

- (void)renderView:(CTInPathVehicle *)vehicle
{
    [self.staticPlaceholderView setHidden:YES];
    
    _selectedVehicleView = [UIView new];
    self.selectedVehicleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.selectedVehicleView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.selectedVehicleView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.selectedVehicleView}]];
    
    _vehicleImageView = [UIImageView new];
    self.vehicleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.vehicleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.selectedVehicleView addSubview:self.vehicleImageView];
    [self.selectedVehicleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-32-[view]-32-|"
                                                                                       options:0
                                                                                       metrics:nil
                                                                                         views:@{@"view" : self.vehicleImageView}]];
    [self.selectedVehicleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-32-[view]-32-|"
                                                                                       options:0
                                                                                       metrics:nil
                                                                                         views:@{@"view" : self.vehicleImageView}]];
    
    __weak typeof(self) weakself = self;
    [[CTImageCache sharedInstance] cachedImage:vehicle.vehicleImageURL completion:^(UIImage *image) {
        weakself.vehicleImageView.image = image;
    }];
    
}

@end
