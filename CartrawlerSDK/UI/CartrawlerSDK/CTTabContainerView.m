//
//  CTTabContainerView.m
//  CartrawlerSDK
//
//  Created by Alan on 22/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTTabContainerView.h"
#import "CTLayoutManager.h"
#import "CTTabHeaderView.h"

@interface CTTabContainerView () <CTTabHeaderViewDelegate>
@property (nonatomic, strong) CTLayoutManager *layoutManager;
@property (nonatomic, strong) CTTabHeaderView *headerView;
@property (nonatomic, strong) UIView *contentContainerView;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;

@property (nonatomic, strong) NSArray *contentViews;
@property (nonatomic, strong) UIView *visibleContentView;
@end

@implementation CTTabContainerView

- (instancetype)initWithTabTitles:(NSArray *)titles views:(NSArray *)views selectedIndex:(NSInteger)selectedIndex {
    self = [super init];
    if (self) {
        self.contentViews = views;
        
        self.headerView = [[CTTabHeaderView alloc] initWithTitles:titles selectedIndex:selectedIndex];
        self.headerView.delegate = self;
        self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.headerView];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"headerView" : self.headerView}]];

        self.contentContainerView = [UIView new];
        self.contentContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.contentContainerView];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentContainerView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"contentContainerView" : self.contentContainerView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerView(50)][contentContainerView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"headerView" : self.headerView, @"contentContainerView" : self.contentContainerView}]];
        
        self.heightConstraint = [NSLayoutConstraint constraintWithItem:self.contentContainerView
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1.0
                                                                                  constant:0];
        [self addConstraint:self.heightConstraint];
        
        [self updateContentViewWithViewAtIndex:selectedIndex];
    }
    return self;
}

- (void)tabHeaderView:(CTTabHeaderView *)tabHeaderView didSelectTabAtIndex:(NSInteger)index {
    [self updateContentViewWithViewAtIndex:index];
}

- (void)updateContentViewWithViewAtIndex:(NSInteger)index {
    if (index > self.contentViews.count || self.visibleContentView == self.contentViews[index]) {
        return;
    }
    
    self.heightConstraint.constant = self.visibleContentView.frame.size.height;
    
    [UIView animateWithDuration:0.15 animations:^{
        self.visibleContentView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self.visibleContentView removeFromSuperview];
        
        [self addContentViewAtIndex:index];
        
        [self animateViewTransition];
    }];
}

- (void)addContentViewAtIndex:(NSInteger)index {
    self.visibleContentView = self.contentViews[index];
    [self.contentContainerView addSubview:self.visibleContentView];
    self.visibleContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[visibleContentView]|"
                                                                                      options:0
                                                                                      metrics:nil
                                                                                        views:@{@"visibleContentView" : self.visibleContentView}]];
    
    [self.contentContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[visibleContentView]"
                                                                                      options:0
                                                                                      metrics:nil
                                                                                        views:@{@"visibleContentView" : self.visibleContentView}]];
    [self.visibleContentView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

- (void)animateViewTransition {
    UIView *animateInView = self.animationContainerView ?: self.superview;
    self.visibleContentView.alpha = 0;
    self.heightConstraint.active = YES;
    [animateInView layoutIfNeeded];
    
    [UIView animateWithDuration:0.15
                     animations:^{
                         self.heightConstraint.constant = self.visibleContentView.frame.size.height;
                         self.visibleContentView.alpha = 1;
                         [animateInView layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         self.heightConstraint.active = NO;
                         NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.visibleContentView
                                                                                             attribute:NSLayoutAttributeBottom
                                                                                             relatedBy:NSLayoutRelationEqual
                                                                                                toItem:self.contentContainerView
                                                                                             attribute:NSLayoutAttributeBottom
                                                                                            multiplier:1.0
                                                                                              constant:0];
                         [self addConstraint:bottomConstraint];
                         [animateInView layoutIfNeeded];
                     }];
}

@end
