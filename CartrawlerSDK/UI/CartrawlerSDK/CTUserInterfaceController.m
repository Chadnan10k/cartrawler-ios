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
#import "CTVehicleListViewModel.h"
#import "CTSelectedVehicleViewModel.h"
#import <CoreText/CoreText.h>
#import "CTValidationSearch.h"

@interface CTUserInterfaceController ()
@property (nonatomic) UINavigationController *navigationController;
@property (nonatomic) NSData *customFont;
@end

@implementation CTUserInterfaceController

- (instancetype)init {
    self = [super init];
    self.navigationController = [UINavigationController new];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    // Set all navigation bar default tint colors
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // Initialise custom font
    NSString *fontPath = [[NSBundle bundleForClass:self.class] pathForResource:@"V5-Mobile" ofType:@"ttf"];
    NSData *fontData = [NSData dataWithContentsOfFile:fontPath];
    CFErrorRef error;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
    CGFontRef font = CGFontCreateWithDataProvider(provider);
    if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
        CFStringRef errorDescription = CFErrorCopyDescription(error);
        NSLog(@"Failed to load font: %@", errorDescription);
    }
    return self;
}

- (void)updateWithAppState:(CTAppState *)appState {
    CTNavigationState *navigationState = appState.navigationState;
    
    if (!navigationState.parentViewController) {
        return;
    }
    
    // Popping children view controllers from the navigation stack
    if (self.navigationController.viewControllers.count > navigationState.currentNavigationStep) {
        if (navigationState.currentNavigationStep == CTNavigationStepNone) {
            [navigationState.parentViewController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popToViewController:self.navigationController.viewControllers[navigationState.currentNavigationStep - 1] animated:YES];
        }
    }
    
    // Pushing children view controllers to the navigation stack
    __block UIViewController <CTViewControllerProtocol> *vc;
    if (self.navigationController.viewControllers.count < navigationState.currentNavigationStep) {
        vc = [CTUserInterfaceController viewControllerForStep:navigationState.currentNavigationStep];
        
        if (self.navigationController.viewControllers.count == 0) {
            self.navigationController.viewControllers = @[vc];
            [navigationState.parentViewController presentViewController:self.navigationController animated:YES completion:nil];
        } else {
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        vc = (UIViewController <CTViewControllerProtocol> *)self.navigationController.topViewController;
    }
    
    // Dismissing modal view controllers if none on stack
    if (vc.presentedViewController && navigationState.modalViewControllers.count == 0) {
        [vc.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    [navigationState.modalViewControllers enumerateObjectsUsingBlock:^(NSNumber *modalNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // Dismissing no longer needed modal view controllers on stack
        BOOL isLastIteration = (idx == navigationState.modalViewControllers.count - 1);
        if (isLastIteration) {
            [vc.presentedViewController.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        }
        
        // Presenting
        CTNavigationModal modal = modalNumber.integerValue;
        UIViewController <CTViewControllerProtocol> *modalVC = (UIViewController <CTViewControllerProtocol> *)vc.presentedViewController;
        if (!modalVC) {
            modalVC = [CTUserInterfaceController viewControllerForModal:modal];
            [vc presentViewController:modalVC animated:YES completion:nil];
        }
        vc = modalVC;
    }];
//    for (NSNumber *modalNumber in navigationState.modalViewControllers) {
//        CTNavigationModal modal = modalNumber.integerValue;
//        UIViewController <CTViewControllerProtocol> *modalVC = (UIViewController <CTViewControllerProtocol> *)vc.presentedViewController;
//        if (!modalVC) {
//            modalVC = [CTUserInterfaceController viewControllerForModal:modal];
//            [vc presentViewController:modalVC animated:YES completion:nil];
//        }
//        vc = modalVC;
//    }
    
    // Updating current view
    Class viewModelClass = [vc.class viewModelClass];
    id <CTViewModelProtocol> viewModel = [viewModelClass viewModelForState:appState];
    [vc updateWithViewModel:viewModel];
}

+ (UIViewController <CTViewControllerProtocol> *)viewControllerForStep:(CTNavigationStep)step {
    UIStoryboard *storyboard;
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    
    switch (step) {
        case 1:
            storyboard = [UIStoryboard storyboardWithName:@"CTSearch" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTSearchViewController"];
        case 2:
            storyboard = [UIStoryboard storyboardWithName:@"CTVehicleList" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTVehicleListViewController"];
        case 3:
            storyboard = [UIStoryboard storyboardWithName:@"CTSelectedVehicle" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTSelectedVehicleViewController"];
        default:
            return nil;
            break;
    }
}

+ (UIViewController <CTViewControllerProtocol> *)viewControllerForModal:(CTNavigationModal)modal {
    UIStoryboard *storyboard;
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    
    switch (modal) {
        case CTNavigationModalAlert:
            return nil;
        case CTNavigationModalSearchLocations:
            storyboard = [UIStoryboard storyboardWithName:@"CTSearch" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTSearchLocationsViewController"];
        case CTNavigationModalSearchSettings:
            storyboard = [UIStoryboard storyboardWithName:@"CTSearch" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTSearchSettingsViewController"];
        case CTNavigationModalSearchSettingsSelection:
            storyboard = [UIStoryboard storyboardWithName:@"CTSearch" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTSearchSettingsSelectionViewController"];
        case CTNavigationModalSearchCalendar:
            storyboard = [UIStoryboard storyboardWithName:@"CTSearch" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTSearchCalendarViewController"];
        case CTNavigationModalSearchInterstitial:
            storyboard = [UIStoryboard storyboardWithName:@"CTSearch" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTSearchInterstitialViewController"];
        case CTNavigationModalVehicleListFilter:
            storyboard = [UIStoryboard storyboardWithName:@"CTVehicleList" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTVehicleListFilterViewController"];
        default:
            return nil;
            break;
    }
}

@end
