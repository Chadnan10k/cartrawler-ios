//
//  CTSelectedVehicleView.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 21/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//


#import "CTSelectedVehicleView.h"
#import "CartrawlerSDK/CTLabel.h"
#import "CartrawlerSDK/CTLocalisedStrings.h"
#import "CartrawlerSDK/CTAppearance.h"
#import "CartrawlerSDK/CartrawlerSDK+UIImageView.h"
#import "CTInPathLocalizationConstants.h"

@interface CTSelectedVehicleView()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation CTSelectedVehicleView

- (instancetype)init
{
    self = [super init];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    _containerView = [self renderContainer];
    
    [self layout];
    
    return self;
}

- (void)layout
{
    [self addSubview:self.containerView];
    NSDictionary *viewDictionary = @{@"containerView" : self.containerView};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[containerView]-0-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[containerView]-8-|" options:0 metrics:nil views:viewDictionary]];
}

- (UIView *)renderContainer
{
    UIView *container = [UIView new];
    container.backgroundColor = [UIColor whiteColor];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    
    CTLabel *loadingLabel = [self loadingLabel];
    [container addSubview:loadingLabel];
    
    UIImageView *tickImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    tickImageView.translatesAutoresizingMaskIntoConstraints = NO;
    tickImageView.image = [UIImage imageNamed:@"checkmark" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    [tickImageView applyTintWithColor:[CTAppearance instance].buttonColor];
    [container addSubview:tickImageView];
    
    NSDictionary *viewDictionary = @{
                                     @"label" : loadingLabel,
                                     @"tick" : tickImageView
                                     };
    
    //Label
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[tick(10)]-4-[label]-0-|" options:0 metrics:nil views:viewDictionary]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[tick(10)]" options:0 metrics:nil views:viewDictionary]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:0 metrics:nil views:viewDictionary]];
    
    [container addConstraint:[NSLayoutConstraint constraintWithItem:tickImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:container
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
    
    [container addConstraint:[NSLayoutConstraint constraintWithItem:loadingLabel
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:tickImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
    
    return container;
}

- (CTLabel *)loadingLabel
{
    CTLabel *label = [[CTLabel alloc] init:15 textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft boldFont:NO];
    label.numberOfLines = 0;
    label.text = CTLocalizedString(CTInPathWidgetTitleAdded);
    return label;
}

@end

