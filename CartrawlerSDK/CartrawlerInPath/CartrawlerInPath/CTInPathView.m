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

@interface CTInPathView()

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
    CTNewBookingView *newBookingView = [[CTNewBookingView alloc] initWithFrame:CGRectZero];
    newBookingView.backgroundColor = [UIColor whiteColor];
    newBookingView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:newBookingView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : newBookingView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : newBookingView}]];
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

}

- (void)renderDefault
{

}

@end
