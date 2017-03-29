//
//  CTInPathErrorView.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 28/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTInPathErrorView.h"

@interface CTInPathErrorView()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation CTInPathErrorView

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
    container.layer.cornerRadius = 5;
    container.layer.borderWidth = 0.5;
    container.layer.borderColor = [UIColor grayColor].CGColor;
    
    UILabel *loadingLabel = [self loadingLabel];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    
    [container addSubview:loadingLabel];
    
    NSDictionary *viewDictionary = @{
                                     @"label" : loadingLabel
                                     };

    //Label
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[label]-8-|" options:0 metrics:nil views:viewDictionary]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[label]-8-|" options:0 metrics:nil views:viewDictionary]];
    
    return container;
}

- (UILabel *)loadingLabel
{
    UILabel *label = [UILabel new];
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = @"Error loading cars... 💀";
    
    return label;
}

@end
