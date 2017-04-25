//
//  CTPaymentSummaryContainerView.m
//  CartrawlerRental
//
//  Created by Alan on 19/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTPaymentSummaryContainerView.h"
#import "CTPaymentSummaryCompactView.h"
#import "CTPaymentSummaryExpandedView.h"
#import <CartrawlerSDK/CTLayoutManager.h>

@interface CTPaymentSummaryContainerView ()
@property (nonatomic, assign) BOOL expanded;
@property (nonatomic, strong) CTPaymentSummaryCompactView *compactView;
@property (nonatomic, strong) CTPaymentSummaryExpandedView *expandedView;
@property (nonatomic, strong) NSLayoutConstraint *expandedViewHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *expandedViewTopConstraint;
@end

static CGFloat const kCollapsedHeight = 50.0f;

@implementation CTPaymentSummaryContainerView

// MARK: Create View

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.clipsToBounds = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.compactView = [CTPaymentSummaryCompactView new];
        self.compactView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.compactView];
        
        self.expandedView = [CTPaymentSummaryExpandedView new];
        self.expandedView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.expandedView];
        
        NSDictionary *views = @{@"compactView": self.compactView, @"expandedView": self.expandedView};
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[compactView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[compactView(50)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[expandedView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        self.expandedViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.expandedView
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1.0
                                                                       constant:0];
        [self addConstraint:self.expandedViewTopConstraint];
        
        self.expandedViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.expandedView
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:0];
        [self addConstraint:self.expandedViewHeightConstraint];
        
        [self addTapGestureRecognizerToView:self.compactView];
        [self addTapGestureRecognizerToView:self.expandedView];
        [self addSwipeGestureRecognizerToView:self.expandedView];
    }
    return self;
}

// MARK: Update View

- (void)updateWithVehicle:(CTVehicle *)vehicle animated:(BOOL)animated {
    [self.compactView updateWithVehicle:vehicle];
    [self.expandedView updateWithVehicle:vehicle];
    
    self.expandedViewHeightConstraint.constant = self.expandedView.desiredHeight;
    self.expandedViewTopConstraint.constant = self.expanded ? 0 : -self.expandedView.desiredHeight;
    
    [self.delegate paymentView:self needsUpdatedHeight:[self desiredHeight] animated:animated];
}

// MARK: View Manipulation

- (void)collapseView {
    [self setViewExpanded:NO];
}

- (void)setViewExpanded:(BOOL)expanded {
    self.expanded = expanded;
    self.expandedViewTopConstraint.constant = expanded ? 0 : -self.expandedView.desiredHeight;
    [self.delegate paymentView:self needsUpdatedHeight:[self desiredHeight] animated:YES];
}

- (CGFloat)desiredHeight {
    return self.expanded ? self.expandedView.desiredHeight : kCollapsedHeight;
}

- (void)addTapGestureRecognizerToView:(UIView *)view {
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    [view addGestureRecognizer:tapGestureRecognizer];
}

- (void)addSwipeGestureRecognizerToView:(UIView *)view {
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [view addGestureRecognizer:swipeGestureRecognizer];
}

- (void)didTapView:(UIGestureRecognizer *)gestureRecognizer {
    [self setViewExpanded:!self.expanded];
}

@end
