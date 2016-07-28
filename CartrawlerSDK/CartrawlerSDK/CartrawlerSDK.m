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
#import "CTSearch.h"

#import "GroundTransportViewController.h"

#define kSearchViewStoryboard @"StepOne"
#define kSearchResultsViewStoryboard @"StepTwo"
#define kVehicleDetailsViewStoryboard @"StepThree"
#define kExtrasViewStoryboard @"StepFour"
#define kSummaryViewStoryboard @"StepFive"
#define kDetailsViewStoryboard @"StepSix"
#define kPaymentViewStoryboard @"StepSeven"

#define kGTViewStoryboard @"GroundTransport"

@interface CartrawlerSDK()

@property (nonatomic, strong) CTSearchDetailsViewController *stepOneViewController;
@property (nonatomic, strong) VehicleSelectionViewController *stepTwoViewController;
@property (nonatomic, strong) StepThreeViewController *stepThreeViewController;
@property (nonatomic, strong) StepFourViewController *stepFourViewController;
@property (nonatomic, strong) StepFiveViewController *stepFiveViewController;
@property (nonatomic, strong) StepSixViewController *stepSixViewController;
@property (nonatomic, strong) StepSevenViewController *stepSevenViewController;

@property (nonatomic, strong) GroundTransportViewController *groundTransportViewController;

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;


@end

@implementation CartrawlerSDK

- (id)initWithRequestorID:(NSString *)requestorID
             languageCode:(NSString *)languageCode
                  isDebug:(BOOL)isDebug
{
    self = [super self];
    
    [LinkerUtils loadFiles];
    [[CTSDKSettings instance] setClientId:requestorID languageCode:languageCode isDebug:isDebug];
    
    _cartrawlerAPI = [[CartrawlerAPI alloc] initWithClientKey:[CTSDKSettings instance].clientId
                                                     language:[CTSDKSettings instance].languageCode
                                                        debug:[CTSDKSettings instance].isDebug];
    
    if (isDebug) {
        [self.cartrawlerAPI enableLogging:YES];
    }
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);

    return self;
}

+ (CTAppearance *)appearance
{
    return [CTAppearance instance];
}

- (void)presentCarRentalInViewController:(UIViewController *)viewController;
{
    
    _stepOneViewController = [self stepOneViewController_];
    [self.stepOneViewController setSearch:[CTSearch instance]];
    
    CTNavigationController *navController=[[CTNavigationController alloc]initWithRootViewController:self.stepOneViewController];

    navController.navigationBar.hidden = YES;

    [viewController presentViewController:navController animated:YES completion:nil];
    
}

- (void)presentGroundTransportInViewController:(UIViewController *)viewController
{
    CTNavigationController *navController=[[CTNavigationController alloc]initWithRootViewController:[self groundTransportViewController_]];
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

- (void)overrideStepOneViewController:(CTSearchDetailsViewController *)viewController;
{
    _stepOneViewController = viewController;
}

- (void)overrideStepTwoViewController:(VehicleSelectionViewController *)viewController;
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

- (void)overrideStepFiveViewController:(StepFiveViewController *)viewController
{
    _stepFiveViewController = viewController;
}

- (void)overrideStepSixViewController:(StepSixViewController *)viewController
{
    _stepSixViewController = viewController;
}

- (void)overrideStepSevenViewController:(StepSevenViewController *)viewController
{
    _stepSevenViewController = viewController;
}

- (CTSearchDetailsViewController *)stepOneViewController_
{
    if (self.stepOneViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:b];
        _stepOneViewController = [storyboard instantiateViewControllerWithIdentifier:@"SearchDetailsViewController"];
        
        [self.stepOneViewController setDestinationViewController:[self stepTwoViewController_]];
        [self.stepOneViewController setFallBackViewController:nil];
        [self.stepOneViewController setCartrawlerAPI:self.cartrawlerAPI];
        
        return self.stepOneViewController;
    } else {
        return self.stepOneViewController;
    }
}

- (VehicleSelectionViewController *)stepTwoViewController_
{
    if (self.stepTwoViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchResultsViewStoryboard bundle:b];
        _stepTwoViewController = [storyboard instantiateViewControllerWithIdentifier:@"SearchResultsViewController"];

        [self.stepTwoViewController setDestinationViewController:[self stepThreeViewController_]];
        [self.stepTwoViewController setFallBackViewController:nil];
        [self.stepTwoViewController setCartrawlerAPI:self.cartrawlerAPI];

        return self.stepTwoViewController;

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
        _stepThreeViewController = [storyboard instantiateViewControllerWithIdentifier:@"VehicleDetailsViewController"];
        
        [self.stepThreeViewController setDestinationViewController:[self stepFourViewController_]];
        [self.stepThreeViewController setFallBackViewController:[self stepFiveViewController_]];
        [self.stepThreeViewController setCartrawlerAPI:self.cartrawlerAPI];
        
        return self.stepThreeViewController;
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
        
        _stepFourViewController = [storyboard instantiateViewControllerWithIdentifier:@"ExtrasViewController"];
        
        [self.stepFourViewController setDestinationViewController:[self stepFiveViewController_]];
        [self.stepFourViewController setFallBackViewController:nil];
        [self.stepFourViewController setCartrawlerAPI:self.cartrawlerAPI];
        
        return self.stepFourViewController;

        
    } else {
        return self.stepFourViewController;
    }
}


- (StepFiveViewController *)stepFiveViewController_
{
    if (self.stepFiveViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSummaryViewStoryboard bundle:b];
        _stepFiveViewController = [storyboard instantiateViewControllerWithIdentifier:@"PaymentSummaryViewController"];
        
        [self.stepFiveViewController setDestinationViewController:[self stepSixViewController_]];
        [self.stepFiveViewController setFallBackViewController:nil];
        [self.stepFiveViewController setCartrawlerAPI:self.cartrawlerAPI];
        
        return self.stepFiveViewController;

    } else {
        return self.stepFiveViewController;
    }
}

- (StepSixViewController *)stepSixViewController_
{
    if (self.stepSixViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kDetailsViewStoryboard bundle:b];
        return [storyboard instantiateViewControllerWithIdentifier:@"DriverDetailsViewController"];
    } else {
        return self.stepSixViewController;
    }
}

- (StepSevenViewController *)stepSevenViewController_
{
    if (self.stepSevenViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kPaymentViewStoryboard bundle:b];
        return [storyboard instantiateViewControllerWithIdentifier:@"PaymentViewController"];
    } else {
        return self.stepSevenViewController;
    }
}

- (GroundTransportViewController *)groundTransportViewController_
{
    if (self.groundTransportViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kGTViewStoryboard bundle:b];
        return [storyboard instantiateViewControllerWithIdentifier:@"GroundTransportViewController"];
    } else {
        return self.groundTransportViewController;
    }
}

#pragma Crash handling

void uncaughtExceptionHandler(NSException *exception)
{
    NSLog(@"\n\n\nCartrawlerSDK Crash:\n%@\n\n\n", exception);
    NSLog(@"\n\n\nCartrawlerSDK Stack Trace:\n\n\n%@", [exception callStackSymbols]);
}


@end
