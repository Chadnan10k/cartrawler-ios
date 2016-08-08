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

#define kSearchViewStoryboard           @"StepOne"
#define kSearchResultsViewStoryboard    @"StepTwo"
#define kVehicleDetailsViewStoryboard   @"StepThree"
#define kExtrasViewStoryboard           @"StepFour"
#define kSummaryViewStoryboard          @"StepFive"
#define kDetailsViewStoryboard          @"StepSix"
#define kPaymentViewStoryboard          @"Payment"

#define kGTViewStoryboard @"GroundTransport"

@interface CartrawlerSDK()

@property (nonatomic, strong) CTViewController *paymentViewController;
@property (nonatomic, strong) CTViewController *paymentCompletionViewController;

@property (nonatomic, strong) GroundTransportViewController *groundTransportViewController;

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic, strong) NSArray <CTViewController *> *customViewControllers;

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
    
    _searchDetailsViewController = [self searchDetailsViewController_];
    [self.searchDetailsViewController setSearch:[CTSearch instance]];
    
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
    [[CTSearch instance] reset];
    CTNavigationController *navController;
    
    if (self.customViewControllers.count > 0) {
        navController=[[CTNavigationController alloc]initWithRootViewController:
                                               self.customViewControllers.firstObject];
    } else {
        navController=[[CTNavigationController alloc]initWithRootViewController:
                                               [self searchDetailsViewController_]];
    }
    
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

- (void)overrideSearchDetailsViewController:(CTViewController *)viewController
{
    _searchDetailsViewController = viewController;
    [self.searchDetailsViewController setCartrawlerAPI:self.cartrawlerAPI];
}

- (void)overrideVehicleSelectionViewController:(CTViewController *)viewController
{
    _vehicleSelectionViewController = viewController;
    [self.vehicleSelectionViewController setCartrawlerAPI:self.cartrawlerAPI];
}

- (void)overrideVehicleDetailsViewController:(CTViewController *)viewController
{
    _vehicleDetailsViewController = viewController;
    [self.vehicleDetailsViewController setCartrawlerAPI:self.cartrawlerAPI];
}

- (void)overrideInsuranceExtrasViewController:(CTViewController *)viewController
{
    _insuranceExtrasViewController = viewController;
    [self.insuranceExtrasViewController setCartrawlerAPI:self.cartrawlerAPI];
}

- (void)overridePaymentSummaryViewController:(CTViewController *)viewController
{
    _paymentSummaryViewController = viewController;
    [self.paymentSummaryViewController setCartrawlerAPI:self.cartrawlerAPI];
}

- (void)overrideDriverDetialsViewController:(CTViewController *)viewController
{
    _driverDetialsViewController = viewController;
    [self.driverDetialsViewController setCartrawlerAPI:self.cartrawlerAPI];
}

- (CTViewController *)searchDetailsViewController_
{
    if (self.searchDetailsViewController) {
        [self.searchDetailsViewController setSearch:[CTSearch instance]];
        return self.searchDetailsViewController;
    } else {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:b];
        _searchDetailsViewController = [storyboard instantiateViewControllerWithIdentifier:@"SearchDetailsViewController"];
        
        [self.searchDetailsViewController setDestinationViewController:[self vehicleSelectionViewController_]];
        [self.searchDetailsViewController setFallBackViewController:nil];
        [self.searchDetailsViewController setViewType:ViewTypeSearchDetails];
        [self.searchDetailsViewController setCartrawlerAPI:self.cartrawlerAPI];
        [self.searchDetailsViewController setSearch:[CTSearch instance]];

        return self.searchDetailsViewController;
    }
}

- (CTViewController *)vehicleSelectionViewController_
{
    if (self.vehicleSelectionViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchResultsViewStoryboard bundle:b];
        _vehicleSelectionViewController = [storyboard instantiateViewControllerWithIdentifier:@"SearchResultsViewController"];

        [self.vehicleSelectionViewController setDestinationViewController:[self vehicleDetailsViewController_]];
        [self.vehicleSelectionViewController setViewType:ViewTypeVehicleSelection];
        [self.vehicleSelectionViewController setFallBackViewController:nil];
        [self.vehicleSelectionViewController setCartrawlerAPI:self.cartrawlerAPI];

        return self.vehicleSelectionViewController;
    } else {
        return self.vehicleSelectionViewController;
    }
}

- (CTViewController *)vehicleDetailsViewController_
{
    if (self.vehicleDetailsViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kVehicleDetailsViewStoryboard bundle:b];
        _vehicleDetailsViewController = [storyboard instantiateViewControllerWithIdentifier:@"VehicleDetailsViewController"];
        
        [self.vehicleDetailsViewController setDestinationViewController:[self insuranceExtrasViewController_]];
        [self.vehicleDetailsViewController setViewType:ViewTypeGeneric];
        [self.vehicleDetailsViewController setFallBackViewController:[self paymentSummaryViewController_]];
        [self.vehicleDetailsViewController setCartrawlerAPI:self.cartrawlerAPI];
        
        return self.vehicleDetailsViewController;
    } else {
        return self.vehicleDetailsViewController;
    }
}

- (CTViewController *)insuranceExtrasViewController_
{
    if (self.insuranceExtrasViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kExtrasViewStoryboard bundle:b];
        
        _insuranceExtrasViewController = [storyboard instantiateViewControllerWithIdentifier:@"ExtrasViewController"];
        
        [self.insuranceExtrasViewController setDestinationViewController:[self paymentSummaryViewController_]];
        [self.insuranceExtrasViewController setViewType:ViewTypeInsurance];
        [self.insuranceExtrasViewController setFallBackViewController:[self driverDetialsViewController_]];
        [self.insuranceExtrasViewController setCartrawlerAPI:self.cartrawlerAPI];
        
        return self.insuranceExtrasViewController;

        
    } else {
        return self.insuranceExtrasViewController;
    }
}


- (CTViewController *)paymentSummaryViewController_
{
    if (self.paymentSummaryViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSummaryViewStoryboard bundle:b];
        _paymentSummaryViewController = [storyboard instantiateViewControllerWithIdentifier:@"PaymentSummaryViewController"];
        
        [self.paymentSummaryViewController setDestinationViewController:[self driverDetialsViewController_]];
        [self.paymentSummaryViewController setViewType:ViewTypeGeneric];
        [self.paymentSummaryViewController setFallBackViewController:nil];
        [self.paymentSummaryViewController setCartrawlerAPI:self.cartrawlerAPI];
        
        return self.paymentSummaryViewController;

    } else {
        return self.paymentSummaryViewController;
    }
}

- (CTViewController *)driverDetialsViewController_
{
    if (self.driverDetialsViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kDetailsViewStoryboard bundle:b];
        _driverDetialsViewController = [storyboard instantiateViewControllerWithIdentifier:@"DriverDetailsViewController"];
        
        [self.driverDetialsViewController setViewType:ViewTypeDriverDetails];
        [self.driverDetialsViewController setDestinationViewController:[self paymentViewController_]];
        [self.driverDetialsViewController setFallBackViewController:nil];
        [self.driverDetialsViewController setCartrawlerAPI:self.cartrawlerAPI];
        
        return self.driverDetialsViewController;
    } else {
        return self.driverDetialsViewController;
    }
}

- (CTViewController *)paymentViewController_
{
    if (self.paymentViewController == nil) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kPaymentViewStoryboard bundle:b];
        _paymentViewController = [storyboard instantiateViewControllerWithIdentifier:@"PaymentViewController"];
        
        [self.paymentViewController setViewType:ViewTypePaymentDetails];
        [self.paymentViewController setDestinationViewController:[self paymentCompletionViewController_]];

        return self.paymentViewController;

    } else {
        return self.paymentViewController;
    }
}

- (CTViewController *)paymentCompletionViewController_
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *b = [NSBundle bundleWithPath:bundlePath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kPaymentViewStoryboard bundle:b];
    _paymentCompletionViewController = [storyboard instantiateViewControllerWithIdentifier:@"PaymentCompletionViewController"];
    
    [self.paymentCompletionViewController setViewType:ViewTypeGeneric];
    
    return self.paymentCompletionViewController;
}

- (void)setCarRentalViewsFromArray:(NSArray <CTViewController *> *)carRentalViews
{
    NSMutableArray <CTViewController *>* viewArr = [[NSMutableArray alloc] init];
    
    BOOL hasSearchDetails = NO;
    BOOL hasVehicleSelection= NO;
    BOOL hasInsurance = NO;
    BOOL hasDrvierDetails = NO;
    BOOL hasPaymentDetails = NO;
    
    for (CTViewController *vc in carRentalViews) {
        
        [vc setCartrawlerAPI:self.cartrawlerAPI];
        
        if (vc.viewType == ViewTypeSearchDetails) {
            hasSearchDetails = YES;
        }
        
        if (vc.viewType == ViewTypeVehicleSelection) {
            hasVehicleSelection = YES;
        }
        
        if (vc.viewType == ViewTypeInsurance) {
            hasInsurance = YES;
        }
        
        if (vc.viewType == ViewTypeDriverDetails) {
            hasDrvierDetails = YES;
        }
        
        if (vc.viewType == ViewTypePaymentDetails) {
            hasPaymentDetails = YES;
        }
        
        [viewArr addObject:vc];
    }
    
    if (!hasSearchDetails)
    {
        [viewArr removeAllObjects];
        NSLog(@"CartrawlerSDK: Cannot set custom views, could not find ViewTypeSearchDetails");
    }
    
    if (!hasVehicleSelection)
    {
        [viewArr removeAllObjects];
        NSLog(@"CartrawlerSDK: Cannot set custom views, could not find ViewTypeVehicleSelection");
    }
    
    if (!hasInsurance)
    {
        [viewArr removeAllObjects];
        NSLog(@"CartrawlerSDK: Cannot set custom views, could not find ViewTypeInsurance");
    }
    
    if (!hasDrvierDetails)
    {
        [viewArr removeAllObjects];
        NSLog(@"CartrawlerSDK: Cannot set custom views, could not find ViewTypeDriverDetails");
    }
    
    if (!hasPaymentDetails)
    {
        [viewArr removeAllObjects];
        NSLog(@"CartrawlerSDK: Cannot set custom views, could not find ViewTypePaymentDetails");
    }
    
    if (hasSearchDetails &&
        hasVehicleSelection &&
        hasInsurance &&
        hasDrvierDetails &&
        hasPaymentDetails)
    {
        _customViewControllers = [[NSArray alloc] initWithArray:viewArr];
    }
    
}

- (void)rerouteViewController:(CTViewController *)viewController
                  destination:(CTViewController *)destination
                     fallback:(CTViewController *)fallback
{
    viewController.destinationViewController = destination;
    viewController.fallBackViewController = fallback;
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
