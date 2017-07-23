//
//  CTUserInterfaceController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/18/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTUserInterfaceController.h"

#import "CTViewControllerProtocol.h"
#import "CTSearchViewModel.h"

@interface CTUserInterfaceController ()
@property (nonatomic) UINavigationController *navigationController;
@end

@implementation CTUserInterfaceController

- (instancetype)init {
    self = [super init];
    self.navigationController = [UINavigationController new];
    return self;
}

- (void)updateWithAppState:(CTAppState *)appState {
    CTNavigationState *navigationState = appState.navigationState;
    
    if (self.navigationController.viewControllers.count > navigationState.desiredStep) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[navigationState.desiredStep] animated:YES];
    }
    
    UIViewController <CTViewControllerProtocol> *vc;
    
    if (self.navigationController.viewControllers.count < navigationState.desiredStep) {
        // TODO: Check current view controller valid, if not break
        
        vc = [CTUserInterfaceController viewControllerForDesiredStep:navigationState.desiredStep];
        
        if (![navigationState.parentViewController isEqual:self.navigationController.parentViewController]) {
            self.navigationController.viewControllers = @[vc];
            [navigationState.parentViewController presentViewController:self.navigationController animated:YES completion:nil];
        } else {
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        vc = (UIViewController <CTViewControllerProtocol> *)self.navigationController.topViewController;
    }
    
    // Get view model for current view controller
    // Update view controller
    id viewModel = [CTUserInterfaceController viewModelForViewControllerState:appState];
    [vc updateWithViewModel:viewModel];
}

+ (UIViewController <CTViewControllerProtocol> *)viewControllerForDesiredStep:(NSUInteger)desiredStep {
    UIStoryboard *storyboard;
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    
    switch (desiredStep) {
        case 1:
            storyboard = [UIStoryboard storyboardWithName:@"CTSearch" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTSearchViewController"];
        default:
            return nil;
            break;
    }
}

+ (id)viewModelForViewControllerState:(id)state {
    return [CTSearchViewModel viewModelForState:state];
}

@end
