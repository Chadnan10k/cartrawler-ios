//
//  CTNewBookingView.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 20/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInPathLoadingView.h"
#import <CartrawlerSDK/CTTextView.h>
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTUpSellBanner.h>
#import <CartrawlerSDK/CartrawlerSDK+UIImageView.h>
#import "CTInPathLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTInPathLoadingView ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation CTInPathLoadingView

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
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[containerView]-8-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[containerView]-8-|" options:0 metrics:nil views:viewDictionary]];
}

- (UIView *)renderContainer
{
    UIView *container = [UIView new];
    container.backgroundColor = [UIColor whiteColor];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    
    CTLabel *loadingLabel = [self loadingLabel];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    UIActivityIndicatorView *activityIndicator = [self activityIndicator];
    
    [container addSubview:loadingLabel];
    [container addSubview:activityIndicator];

    NSDictionary *viewDictionary = @{
                                     @"label" : loadingLabel,
                                     @"indicator" : activityIndicator
                                     };
    //Indicator
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[indicator]-8-|" options:0 metrics:nil views:viewDictionary]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[indicator(50)]" options:0 metrics:nil views:viewDictionary]];
    
    //Label
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[label]-8-|" options:0 metrics:nil views:viewDictionary]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[indicator]-8-[label]-8-|" options:0 metrics:nil views:viewDictionary]];

    return container;
}

- (CTLabel *)loadingLabel
{
    CTLabel *label = [[CTLabel alloc] init:17 textColor:[CTAppearance instance].buttonTextColor textAlignment:NSTextAlignmentCenter boldFont:YES];
    label.text = CTLocalizedString(CTInPathWidgetLoading);
    return label;
}

- (UIActivityIndicatorView *)activityIndicator
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    indicator.translatesAutoresizingMaskIntoConstraints = NO;
    indicator.color = [CTAppearance instance].buttonTextColor;
    return indicator;
}

@end
