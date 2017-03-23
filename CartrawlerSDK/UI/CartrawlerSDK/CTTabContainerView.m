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
    
    [UIView animateWithDuration:0.15 animations:^{
        self.visibleContentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.visibleContentView removeFromSuperview];
        self.visibleContentView = self.contentViews[index];
        
        [self.contentContainerView addSubview:self.visibleContentView];
        [CTLayoutManager pinView:self.visibleContentView toSuperView:self.contentContainerView];
        [self.superview layoutIfNeeded];
        
        self.visibleContentView.alpha = 0;
        [UIView animateWithDuration:0.15
                         animations:^{
                             self.visibleContentView.alpha = 1;
                         }];
        
    }];
}

@end
