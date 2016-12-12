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
@property (nonatomic, strong) CTLabel *placeholderInfoLabel;

@end

@implementation CTInPathView

#pragma mark Render Placeholder
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self renderStaticPlaceholder];
    [self renderVehicleDetailsPlaceholders];
    self.staticPlaceholderView.alpha = 1;
    self.selectedVehicleView.alpha = 0;
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
    self.placeholderImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.placeholderImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.staticPlaceholderView addSubview:self.placeholderImageView];
    
    [self.staticPlaceholderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[view]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.placeholderImageView}]];
    [self.staticPlaceholderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-32-[view]-32-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.placeholderImageView}]];
    self.placeholderImageView.image = [UIImage imageNamed:@"success_car"
                                                 inBundle:[NSBundle bundleForClass:[self class]]
                            compatibleWithTraitCollection:nil];
    
    _placeholderInfoLabel = [CTLabel new];
    self.placeholderInfoLabel.text = @"Book now and get 10% off!";
    self.placeholderInfoLabel.textAlignment = NSTextAlignmentCenter;
    self.placeholderInfoLabel.numberOfLines = 0;
    self.placeholderInfoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.staticPlaceholderView addSubview:self.placeholderInfoLabel];
    
    [self.staticPlaceholderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[image]-16-[text(20)]-8-|"
                                                                                       options:0
                                                                                       metrics:nil
                                                                                         views:@{@"text" : self.placeholderInfoLabel,
                                                                                                 @"image" : self.placeholderImageView}]];
    
    [self.staticPlaceholderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[text]-8-|"
                                                                                       options:0
                                                                                       metrics:nil
                                                                                         views:@{@"text" : self.placeholderInfoLabel}]];
    
    
}

- (void)renderVehicleDetailsPlaceholders
{
    
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
    [self.selectedVehicleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view(120)]"
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:@{@"view" : self.vehicleImageView}]];
    [self.selectedVehicleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(120)]-16-|"
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:@{@"view" : self.vehicleImageView}]];
    
    _vehicleNameLabel = [CTLabel new];
    self.vehicleNameLabel.textAlignment = NSTextAlignmentLeft;
    self.vehicleNameLabel.numberOfLines = 0;
    self.vehicleNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.selectedVehicleView addSubview:self.vehicleNameLabel];
    
    [self.selectedVehicleView addConstraint:[NSLayoutConstraint constraintWithItem:self.vehicleNameLabel
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.selectedVehicleView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1 constant:0]];
    
    [self.selectedVehicleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[text]-8-[image]"
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:@{@"text" : self.vehicleNameLabel,
                                                                                               @"image" : self.vehicleImageView}]];
}

#pragma mark Render Vehicle
- (void)renderVehicleDetails:(CTInPathVehicle *)vehicle
{
    self.staticPlaceholderView.alpha = 0;
    self.selectedVehicleView.alpha = 1;
    self.vehicleNameLabel.text = vehicle.vehicleName;
    __weak typeof(self) weakself = self;
    [[CTImageCache sharedInstance] cachedImage:vehicle.vehicleImageURL completion:^(UIImage *image) {
        weakself.vehicleImageView.image = image;
    }];
}

- (void)renderDefault
{
    [UIView animateWithDuration:0.3 animations:^{
        self.staticPlaceholderView.alpha = 1;
        self.selectedVehicleView.alpha = 0;
    }];
}

@end
