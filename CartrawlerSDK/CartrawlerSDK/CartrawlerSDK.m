//
//  CartrawlerSDK.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//


#import "CartrawlerSDK.h"
#import "LinkerUtils.h"
#import "CTSDKSettings.h"
#import "CTNavigationController.h"

#define kSearchViewStoryboard @"StepOne"
#define kSearchResultsViewStoryboard @"StepTwo"

@interface CartrawlerSDK()

@property (nonatomic, strong) StepOneViewController *stepOneViewController;
@property (nonatomic, strong) StepTwoViewController *stepTwoViewController;

@end

@implementation CartrawlerSDK

- (id)initWithRequestorID:(NSString *)requestorID
             languageCode:(NSString *)languageCode
                  isDebug:(BOOL)isDebug
{
    self = [super self];
    
    [LinkerUtils loadFiles];
    [[CTSDKSettings instance] setClientId:requestorID languageCode:languageCode isDebug:isDebug];
    
    return self;
}

- (void)changeLanguage:(NSString *)languageCode
{
    [[CTSDKSettings instance] setLanguageCode:languageCode];
}

- (void)changeCurrency:(NSString *)currencyCode
{
    [[CTSDKSettings instance] setCurrencyCode:currencyCode];
}

- (void)presentStepOneInViewController:(UIViewController *)viewController;
{
    if (self.stepOneViewController == nil) {
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:bundle];
        
        _stepOneViewController = [storyboard instantiateViewControllerWithIdentifier:@"SearchDetailsViewController"];
        self.stepOneViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    }
    
    [self.stepOneViewController setStepTwoViewController:[self stepTwoViewController_]];
    CTNavigationController *navController=[[CTNavigationController alloc]initWithRootViewController:self.stepOneViewController];
    navController.navigationBar.hidden = YES;

    [viewController presentViewController:navController animated:YES completion:nil];
    
}

- (void)presentStepTwoWithData:(NSString *)pickupLocationCode
            returnLocationCode:(NSString *)returnLocationCode
           customerCountryCode:(NSString *)customerCountryCode
                  passengerQty:(NSNumber *)passengerQty
                     driverAge:(NSNumber *)driverAge
                pickUpDateTime:(NSDate *)pickupDateTime
                returnDateTime:(NSDate *)returnDateTime
                  currencyCode:(NSString *)currencyCode
              inViewController:(UIViewController *)viewController
{
    
}

- (void)overrideStepOneViewController:(StepOneViewController *)viewController;
{
    _stepOneViewController = viewController;
}

- (void)overrideStepTwoViewController:(StepTwoViewController *)viewController;
{
    _stepTwoViewController = viewController;
}

- (StepTwoViewController *)stepTwoViewController_
{
    if (self.stepTwoViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchResultsViewStoryboard bundle:b];
        return [storyboard instantiateViewControllerWithIdentifier:@"SearchResultsViewController"];
    } else {
        return self.stepTwoViewController;
    }
}

@end
