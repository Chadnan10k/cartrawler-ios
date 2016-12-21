//
//  CTInPathView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInPathView.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTImageCache.h>
#import "CTNewBookingView.h"
#import "CTSelectedVehicleView.h"

@interface CTInPathView()

@property (nonatomic, strong) CTNewBookingView *noSelectionView;
@property (nonatomic, strong) CTSelectedVehicleView *selectedVehicleView;

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
    _noSelectionView = [[CTNewBookingView alloc] initWithFrame:CGRectZero];
    self.noSelectionView.backgroundColor = [UIColor whiteColor];
    self.noSelectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.noSelectionView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.noSelectionView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.noSelectionView}]];
    
    _selectedVehicleView = [[CTSelectedVehicleView alloc] initWithFrame:CGRectZero];
    self.selectedVehicleView.backgroundColor = [UIColor whiteColor];
    self.selectedVehicleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.selectedVehicleView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.selectedVehicleView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.selectedVehicleView}]];
    
    self.noSelectionView.alpha = 0;
    self.selectedVehicleView.alpha = 1;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)renderStaticPlaceholder
{

}

- (void)renderVehicleDetailsPlaceholders
{

}

#pragma mark Render Vehicle
- (void)renderVehicleDetails:(CTInPathVehicle *)vehicle
{
    [self.selectedVehicleView setVehicle:vehicle];
    self.noSelectionView.alpha = 0;
    self.selectedVehicleView.alpha = 1;
}

- (void)renderDefault
{
    self.noSelectionView.alpha = 1;
    self.selectedVehicleView.alpha = 0;
}

@end
