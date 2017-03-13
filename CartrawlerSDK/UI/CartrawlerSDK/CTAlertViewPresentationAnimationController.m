//
//  CTAlertViewPresentationAnimationController.m
//  CartrawlerSDK
//
//  Created by Alan on 09/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAlertViewPresentationAnimationController.h"

@implementation CTAlertViewPresentationAnimationController

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [[transitionContext containerView] addSubview:toViewController.view];
    
    toViewController.view.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.2f);
    toViewController.view.layer.opacity = 0.0f;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         toViewController.view.layer.transform = CATransform3DIdentity;
                         toViewController.view.layer.opacity = 1.0f;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

@end
