//
//  CTExpandingView.m
//  CartrawlerSDK
//
//  Created by Alan on 14/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTExpandingView.h"

@interface CTExpandingView ()
@property (nonatomic, weak) UIView *animationContainerView;

@property (nonatomic, strong) UIView *headerViewContainer;
@property (nonatomic, strong) UIImageView *chevron;
@property (nonatomic, strong) UIView *detailViewContainer;

@property (nonatomic, strong) NSLayoutConstraint *detailHeightConstraint;
@property (nonatomic, assign) BOOL expanded;
@end

@implementation CTExpandingView

- (instancetype)initWithHeaderView:(UIView *)headerView animationContainerView:(UIView *)animationContainerView  {
    self = [super init];
    if (self) {
        _animationDuration = 0.3;
        
        _animationContainerView = animationContainerView;
        
        _headerViewContainer = [UIView new];
        _headerViewContainer.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_headerViewContainer];
        
        headerView.translatesAutoresizingMaskIntoConstraints = NO;
        [_headerViewContainer addSubview:headerView];
        
        _detailViewContainer = [UIView new];
        _detailViewContainer.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_detailViewContainer];
        
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        UIImage *chevronImage = [[UIImage imageNamed:@"down_arrow" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _chevron = [[UIImageView alloc] initWithImage:chevronImage];
        _chevron.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_chevron];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(headerView)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(headerView)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[_headerViewContainer]-16-[_chevron(20)]-20-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_headerViewContainer, _chevron)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[_detailViewContainer]-61-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_detailViewContainer)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_headerViewContainer(40)]-10-[_detailViewContainer]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_headerViewContainer, _detailViewContainer)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_chevron(20)]-20-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_chevron)]];
        
        _detailHeightConstraint = [NSLayoutConstraint constraintWithItem:_detailViewContainer
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:0];
        [self addConstraint:_detailHeightConstraint];
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)expandWithDetailView:(UIView *)detailView {
    self.expanded = YES;
    
    detailView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.detailViewContainer addSubview:detailView];
    [self.detailViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[detailView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(detailView)]];
    
    [self.detailViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[detailView]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(detailView)]];
    [detailView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.animationContainerView layoutIfNeeded];
    
    CGFloat padding = 10;
    detailView.alpha = 0;
    [UIView animateWithDuration:self.animationDuration animations:^{
        detailView.alpha = 1.0;
        self.detailHeightConstraint.constant = detailView.intrinsicContentSize.height + padding;
        self.chevron.layer.affineTransform = CGAffineTransformMakeScale(1, -1);
        [self.animationContainerView layoutIfNeeded];
    }];
}

- (void)contract {
    self.expanded = NO;
    
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         self.detailViewContainer.subviews.firstObject.alpha = 0;
                         self.detailHeightConstraint.constant = 0;
                         self.chevron.layer.affineTransform = CGAffineTransformMakeScale(1, 1);
                         [self.animationContainerView layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         [self.detailViewContainer.subviews.firstObject removeFromSuperview];
                     }];
}

@end
