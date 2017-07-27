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

@interface CTUserInterfaceController ()
@property (nonatomic) UINavigationController *navigationController;
@property (nonatomic) NSData *customFont;
@end

@implementation CTUserInterfaceController

- (instancetype)init {
    self = [super init];
    self.navigationController = [UINavigationController new];
    
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
    
    if (self.navigationController.viewControllers.count > navigationState.desiredStep) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[navigationState.desiredStep] animated:YES];
    }
    
    UIViewController <CTViewControllerProtocol> *vc;
    
    if (self.navigationController.viewControllers.count < navigationState.desiredStep) {
        // TODO: Check current view controller valid, if not break
        
        vc = [CTUserInterfaceController viewControllerForStep:navigationState.desiredStep];
        
        if (self.navigationController.viewControllers.count == 0) {
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
    id viewModel = [CTUserInterfaceController viewModelForStep:navigationState.desiredStep state:appState];
    [vc updateWithViewModel:viewModel];
}

+ (UIViewController <CTViewControllerProtocol> *)viewControllerForStep:(NSUInteger)step {
    UIStoryboard *storyboard;
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    
    switch (step) {
        case 1:
            storyboard = [UIStoryboard storyboardWithName:@"CTSearch" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTSearchViewController"];
        case 2:
            storyboard = [UIStoryboard storyboardWithName:@"CTVehicleList" bundle:bundle];
            return [storyboard instantiateViewControllerWithIdentifier:@"CTVehicleListViewController"];
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
