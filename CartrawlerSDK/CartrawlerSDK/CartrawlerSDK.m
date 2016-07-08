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
#define kVehicleDetailsViewStoryboard @"StepThree"
#define kExtrasViewStoryboard @"StepFour"

@interface CartrawlerSDK()

@property (nonatomic, strong) StepOneViewController *stepOneViewController;
@property (nonatomic, strong) StepTwoViewController *stepTwoViewController;
@property (nonatomic, strong) StepThreeViewController *stepThreeViewController;
@property (nonatomic, strong) StepFourViewController *stepFourViewController;

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
    
    _stepOneViewController = [self stepOneViewController_];
    
    [self.stepOneViewController setStepTwoViewController:[self stepTwoViewController_]];
    [self.stepOneViewController setStepThreeViewController:[self stepThreeViewController_]];
    [self.stepOneViewController setStepFourViewController:[self stepFourViewController_]];

    //CTNavigationController *navController=[[CTNavigationController alloc]initWithRootViewController:[self stepFourViewController_]];
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

- (void)overrideStepThreeViewController:(StepThreeViewController *)viewController
{
    _stepThreeViewController = viewController;
}

- (void)overrideStepFourViewController:(StepFourViewController *)viewController
{
    _stepFourViewController = viewController;
}

- (StepOneViewController *)stepOneViewController_
{
    if (self.stepTwoViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:b];
        return [storyboard instantiateViewControllerWithIdentifier:@"SearchDetailsViewController"];
    } else {
        return self.stepTwoViewController;
    }
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

- (StepThreeViewController *)stepThreeViewController_
{
    if (self.stepThreeViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kVehicleDetailsViewStoryboard bundle:b];
        return [storyboard instantiateViewControllerWithIdentifier:@"VehicleDetailsViewController"];
    } else {
        return self.stepThreeViewController;
    }
}

- (StepFourViewController *)stepFourViewController_
{
    if (self.stepFourViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kExtrasViewStoryboard bundle:b];
        return [storyboard instantiateViewControllerWithIdentifier:@"ExtrasViewController"];
    } else {
        return self.stepFourViewController_;
    }
}

@end
