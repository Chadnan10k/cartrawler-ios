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

    if (self.navigationController.viewControllers.count > navigationState.currentNavigationStep) {
        if (navigationState.currentNavigationStep == CTNavigationStepNone) {
            [navigationState.parentViewController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popToViewController:self.navigationController.viewControllers[navigationState.currentNavigationStep - 1] animated:YES];
        }
    }
    
    UIViewController <CTViewControllerProtocol> *vc;
    
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

+ (id <CTViewModelProtocol>)viewModelForStep:(NSUInteger)step state:(CTAppState *)state {
    switch (step) {
        case 1:
            return [CTSearchViewModel viewModelForState:state];
        case 2:
            return [CTVehicleListViewModel viewModelForState:state];
        default:
            return nil;
            break;
    }
    return [CTSearchViewModel viewModelForState:state];
}

@end
