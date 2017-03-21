//
//  CTAlertViewController.m
//  CartrawlerSDK
//
//  Created by Alan on 08/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAlertViewController.h"
#import "CTAlertView.h"
#import "CTAlertViewPresentationController.h"
#import "CTAlertViewPresentationAnimationController.h"
#import "CTAlertViewDismissalAnimationController.h"


@interface CTAlertViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) CTAlertView *view;
@property (nonatomic, readonly) NSArray *actions;
@end

@implementation CTAlertViewController

@dynamic view;

// MARK: Initialiser

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message {
    CTAlertViewController *alertController = [CTAlertViewController new];
    [alertController commonInit];
    alertController.view.titleLabel.text = title;
    alertController.view.messageTextView.text = message;
    return alertController;
}

- (void)commonInit {
    _actions = [NSArray array];
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
}

// MARK: View Lifecyle

- (void)loadView {
    self.view = [[CTAlertView alloc] initWithFrame:CGRectZero];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createActionButtons];
}

- (void)viewDidDisappear:(BOOL)animated {
    self.transitioningDelegate = nil;
    [super viewDidDisappear:animated];
}

// MARK: Custom View

- (UIView *)customView {
    return self.view.contentView;
}

- (void)setCustomView:(UIView *)contentView {
    self.view.contentView = contentView;
}

// MARK: Icon

- (UIImage *)icon {
    return self.view.iconView.image;
}

- (void)setIcon:(UIImage *)icon {
    self.view.iconView.image = icon;
}

// MARK: Actions

- (void)addAction:(CTAlertAction *)action {
    _actions = [self.actions arrayByAddingObject:action];
}

- (void)createActionButtons {
    NSMutableArray *buttons = [NSMutableArray array];
    
    for (int i = 0; i < [self.actions count]; i++) {
        CTAlertAction *action = self.actions[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        button.tag = i;
        [button addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
        [button setTitle:action.title forState:UIControlStateNormal];
        [buttons addObject:button];
    }
    
    self.view.actionButtons = buttons;
}

- (void)actionButtonPressed:(UIButton *)button {
    CTAlertAction *action = self.actions[button.tag];
    if (action.handler) {
        action.handler(action);
    }
}

// MARK: UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source {
    CTAlertViewPresentationController *presentationController = [[CTAlertViewPresentationController alloc] initWithPresentedViewController:presented
                                                                                                                  presentingViewController:presenting];
    presentationController.backgroundTapDismissalGestureEnabled = self.backgroundTapDismissalGestureEnabled;
    return presentationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    CTAlertViewPresentationAnimationController *presentationAnimationController = [[CTAlertViewPresentationAnimationController alloc] init];
    return presentationAnimationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    CTAlertViewDismissalAnimationController *dismissalAnimationController = [[CTAlertViewDismissalAnimationController alloc] init];
    return dismissalAnimationController;
}


@end
