//
//  CTUserInterfaceController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/18/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTUserInterfaceController.h"

#import "CTViewControllerProtocol.h"
#import "CTSearchErrorViewController.h"
#import "CTSearchViewModel.h"
#import "CTVehicleListViewModel.h"
#import "CTSelectedVehicleViewModel.h"
#import <CoreText/CoreText.h>
#import "CTValidationSearch.h"
#import "CTAppController.h"

@interface CTUserInterfaceController ()
@property (nonatomic) UINavigationController *navigationController;
@property (nonatomic) NSMutableArray *modalViewControllers;
@property (nonatomic) NSData *customFont;
@end

@implementation CTUserInterfaceController

- (instancetype)init {
    self = [super init];
    self.navigationController = [UINavigationController new];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.modalViewControllers = [NSMutableArray new];
    
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
    
    __block UIViewController <CTViewControllerProtocol> *topViewController = (UIViewController <CTViewControllerProtocol> *)self.navigationController.topViewController;
    
    // Popping children view controllers
    if (self.navigationController.viewControllers.count > navigationState.currentNavigationStep) {
        if (navigationState.currentNavigationStep == CTNavigationStepNone) {
            [navigationState.parentViewController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popToViewController:self.navigationController.viewControllers[navigationState.currentNavigationStep - 1] animated:YES];
        }
    }
    
    // Pushing children view controllers
    if (self.navigationController.viewControllers.count < navigationState.currentNavigationStep) {
        topViewController = [CTUserInterfaceController viewControllerForStep:navigationState.currentNavigationStep];
        
        if (self.navigationController.viewControllers.count == 0) {
            self.navigationController.viewControllers = @[topViewController];
            [navigationState.parentViewController presentViewController:self.navigationController animated:YES completion:nil];
        } else {
            [self.navigationController pushViewController:topViewController animated:YES];
        }
    }
    
    // Popping modal view controllers
    for (NSUInteger i = self.modalViewControllers.count; i > navigationState.modalViewControllers.count; i--) {
        [self.modalViewControllers[i-1] dismissViewControllerAnimated:YES completion:nil];
        [self.modalViewControllers removeObjectAtIndex:i-1];
    }
    
    // Presenting modal view controllers
    [navigationState.modalViewControllers enumerateObjectsUsingBlock:^(NSNumber *modalNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        CTNavigationModal modal = modalNumber.integerValue;
        UIViewController <CTViewControllerProtocol> *modalVC;
        
        if (self.modalViewControllers.count <= idx) {
            modalVC = [CTUserInterfaceController viewControllerForModal:modal];
            [topViewController presentViewController:modalVC animated:YES completion:nil];
            [self.modalViewControllers addObject:modalVC];
        } else {
            modalVC = self.modalViewControllers[idx];
        }
        
        topViewController = modalVC;
    }];
    
    // Updating current view
    Class viewModelClass = [topViewController.class viewModelClass];
    id <CTViewModelProtocol> viewModel = [viewModelClass viewModelForState:appState];
    [topViewController updateWithViewModel:viewModel];
}

+ (UIViewController <CTViewControllerProtocol> *)viewControllerForStep:(CTNavigationStep)step {
    UIStoryboard *storyboard;
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    
    switch (step) {
        case CTNavigationStepSearch:
            storyboard = [UIStoryboard storyboardWithName:@"CTSearch" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTSearchViewController"];
        case CTNavigationStepVehicleList:
            storyboard = [UIStoryboard storyboardWithName:@"CTVehicleList" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTVehicleListViewController"];
        case CTNavigationStepSelectedVehicle:
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
        case CTNavigationModalSearchVehicleFetchError:
            return [[CTSearchErrorViewController alloc] initWithNibName:@"CTAlertViewController" bundle:bundle];
            break;
        case CTNavigationModalVehicleListFilter:
            storyboard = [UIStoryboard storyboardWithName:@"CTVehicleList" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTVehicleListFilterViewController"];
        default:
            return nil;
            break;
    }
}

@end
