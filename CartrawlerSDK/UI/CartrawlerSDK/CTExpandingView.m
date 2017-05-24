//
//  CTExpandingView.m
//  CartrawlerSDK
//
//  Created by Alan on 14/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTExpandingView.h"
#import "CartrawlerSDK/CartrawlerSDK+UIImageView.h"
#import "CartrawlerSDK/CTAppearance.h"

@interface CTExpandingView ()
@property (nonatomic, weak) UIView *animationContainerView;

@property (nonatomic, strong) UIView *headerViewContainer;
@property (nonatomic, strong) UIImageView *chevron;
@property (nonatomic, strong) UIView *detailViewContainer;

@property (nonatomic, strong) NSLayoutConstraint *detailHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *detailBottomConstraint;
@property (nonatomic, assign) BOOL expanded;
@end

@implementation CTExpandingView

- (instancetype)initWithHeaderView:(UIView *)headerView animationContainerView:(UIView *)animationContainerView  {
    self = [super init];
    if (self) {
        self.animationDuration = 0.3;
        
        self.animationContainerView = animationContainerView;
        
        self.headerViewContainer = [UIView new];
        self.headerViewContainer.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.headerViewContainer];
        
        headerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.headerViewContainer addSubview:headerView];
        
        self.detailViewContainer = [UIView new];
        self.detailViewContainer.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.detailViewContainer];
        
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        UIImage *chevronImage = [[UIImage imageNamed:@"down_arrow" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.chevron = [[UIImageView alloc] initWithImage:chevronImage];
        [self.chevron  applyTintWithColor:[UIColor colorWithRed:42.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0]];
        self.chevron.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.chevron];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(headerView)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(headerView)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[headerViewContainer]-8-[chevron(20)]-16-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"headerViewContainer" : self.headerViewContainer, @"chevron" : self.chevron}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[detailViewContainer]-40-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"detailViewContainer" : self.detailViewContainer}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[headerViewContainer(40)]-10-[detailViewContainer]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"headerViewContainer" : self.headerViewContainer, @"detailViewContainer" : self.detailViewContainer}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[chevron(20)]-20-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"chevron" : self.chevron}]];
        
        self.detailHeightConstraint = [NSLayoutConstraint constraintWithItem:self.detailViewContainer
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0
                                                                    constant:0];
        [self addConstraint:self.detailHeightConstraint];
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)expandWithDetailView:(UIView *)detailView {
    self.expanded = YES;
    [self.detailViewContainer.subviews.firstObject removeFromSuperview];
    [self addDetailView:detailView];
    [self animateExpansionWithDetailView:detailView];
}

- (void)addDetailView:(UIView *)detailView {
    detailView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.detailViewContainer addSubview:detailView];
    [self.detailViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[detailView]-0-|"
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:NSDictionaryOfVariableBindings(detailView)]];
    
    [self.detailViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[detailView]"
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:NSDictionaryOfVariableBindings(detailView)]];
    [detailView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.detailViewContainer layoutIfNeeded];
}

- (void)animateExpansionWithDetailView:(UIView *)detailView {
    CGFloat padding = 10;
    detailView.alpha = 0;
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        detailView.alpha = 1.0;
        self.detailHeightConstraint.constant = detailView.frame.size.height + padding;
        self.chevron.layer.affineTransform = CGAffineTransformMakeScale(1, -1);
        [self.animationContainerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.detailBottomConstraint = [NSLayoutConstraint constraintWithItem:detailView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.detailViewContainer
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0
                                                                    constant:-padding];
        [self.detailViewContainer addConstraint:self.detailBottomConstraint];
        self.detailHeightConstraint.active = NO;
        [self.animationContainerView layoutIfNeeded];
    }];
}

- (void)contract {
    self.expanded = NO;
    
    UIView *detailView = self.detailViewContainer.subviews.firstObject;
    self.detailBottomConstraint.active = NO;
    self.detailHeightConstraint.active = YES;
    
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         detailView.alpha = 0;
                         self.detailHeightConstraint.constant = 0;
                         self.chevron.layer.affineTransform = CGAffineTransformMakeScale(1, 1);
                         [self.animationContainerView layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         [detailView removeFromSuperview];
                     }];
}

@end
