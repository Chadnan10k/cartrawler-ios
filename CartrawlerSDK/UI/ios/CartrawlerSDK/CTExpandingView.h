//
//  CTExpandingView.h
//  CartrawlerSDK
//
//  Created by Alan on 14/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 A view which displays a header view, a chevron, and which will expand to show a detail view
 */
@interface CTExpandingView : UIView

/**
 Describes whether the view is expanded or collapsed
 */
@property (nonatomic, readonly) BOOL expanded;

/**
 The duration of the animation
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 Custom initialiser

 @param headerView a header view
 @param animationContainerView a weak reference to the super view which needs to perform the layout refresh to correctly animate the behaviour
 @return an expanding view
 */
- (instancetype)initWithHeaderView:(UIView *)headerView animationContainerView:(UIView *)animationContainerView;

/**
 Call this to expand the view

 @param detailView a detail view to be displayed underneath the header view
 */
- (void)expandWithDetailView:(UIView *)detailView;

/**
 Call this to return the view to its initial state
 */
- (void)contract;

@end
