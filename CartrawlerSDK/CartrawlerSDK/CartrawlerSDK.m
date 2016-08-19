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

@property (nonatomic, strong, readonly) CTViewController *searchDetailsViewControllerOverride;

@property (nonatomic, strong) GroundTransportViewController *groundTransportViewController;

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic, strong) NSArray <CTViewController *> *customViewControllers;

@property (nonatomic, strong) NSBundle *bundle;

@end

@implementation CartrawlerSDK

- (instancetype)initWithRequestorID:(NSString *)requestorID
             languageCode:(NSString *)languageCode
                  isDebug:(BOOL)isDebug
{
    self = [super self];
    
    [LinkerUtils loadFiles];
    [[CTSDKSettings instance] setClientId:requestorID languageCode:languageCode isDebug:isDebug];
    
    _cartrawlerAPI = [[CartrawlerAPI alloc] initWithClientKey:[CTSDKSettings instance].clientId
                                                     language:[CTSDKSettings instance].languageCode
                                                        debug:[CTSDKSettings instance].isDebug];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    _bundle = [NSBundle bundleWithPath:bundlePath];
    
    _searchDetailsViewController = [self searchDetailsViewController_];
    (self.searchDetailsViewController).search = [CTSearch instance];
    
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
    
    navController = [[CTNavigationController alloc] initWithRootViewController:
                                           [self searchDetailsViewController_]];

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
    _searchDetailsViewControllerOverride = viewController;
    (self.searchDetailsViewControllerOverride).cartrawlerAPI = self.cartrawlerAPI;
}

- (void)overrideVehicleSelectionViewController:(CTViewController *)viewController
{
    _vehicleSelectionViewController = viewController;
    (self.vehicleSelectionViewController).cartrawlerAPI = self.cartrawlerAPI;
}

- (void)overrideVehicleDetailsViewController:(CTViewController *)viewController
{
    _vehicleDetailsViewController = viewController;
    (self.vehicleDetailsViewController).cartrawlerAPI = self.cartrawlerAPI;
}

- (void)overrideInsuranceExtrasViewController:(CTViewController *)viewController
{
    _insuranceExtrasViewController = viewController;
    (self.insuranceExtrasViewController).cartrawlerAPI = self.cartrawlerAPI;
}

- (void)overridePaymentSummaryViewController:(CTViewController *)viewController
{
    _paymentSummaryViewController = viewController;
    (self.paymentSummaryViewController).cartrawlerAPI = self.cartrawlerAPI;
}

- (void)overrideDriverDetialsViewController:(CTViewController *)viewController
{
    _driverDetialsViewController = viewController;
    (self.driverDetialsViewController).cartrawlerAPI = self.cartrawlerAPI;
}

- (void)overridePaymentCompletionViewController:(CTViewController *)viewController
{
    _paymentCompletionViewController = viewController;
    (self.paymentCompletionViewController).cartrawlerAPI = self.cartrawlerAPI;
}

- (CTViewController *)searchDetailsViewController_
{
    if (self.searchDetailsViewControllerOverride) {
        self.searchDetailsViewControllerOverride.search = [CTSearch instance];
        return self.searchDetailsViewControllerOverride;
    } else {

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:self.bundle];
        _searchDetailsViewController = [storyboard instantiateViewControllerWithIdentifier:@"SearchDetailsViewController"];
        
        self.searchDetailsViewController.destinationViewController = [self vehicleSelectionViewController_];
        [self.searchDetailsViewController setFallBackViewController:nil];
        self.searchDetailsViewController.viewType = ViewTypeSearchDetails;
        self.searchDetailsViewController.cartrawlerAPI = self.cartrawlerAPI;
        self.searchDetailsViewController.search = [CTSearch instance];

        return self.searchDetailsViewController;
    }
}

- (CTViewController *)vehicleSelectionViewController_
{
    if (self.vehicleSelectionViewController == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchResultsViewStoryboard bundle:self.bundle];
        _vehicleSelectionViewController = [storyboard instantiateViewControllerWithIdentifier:@"SearchResultsViewController"];

        (self.vehicleSelectionViewController).destinationViewController = [self vehicleDetailsViewController_];
        (self.vehicleSelectionViewController).viewType = ViewTypeVehicleSelection;
        [self.vehicleSelectionViewController setFallBackViewController:nil];
        (self.vehicleSelectionViewController).cartrawlerAPI = self.cartrawlerAPI;

        return self.vehicleSelectionViewController;
    } else {
        return self.vehicleSelectionViewController;
    }
}

- (CTViewController *)vehicleDetailsViewController_
{
    if (self.vehicleDetailsViewController == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kVehicleDetailsViewStoryboard bundle:self.bundle];
        _vehicleDetailsViewController = [storyboard instantiateViewControllerWithIdentifier:@"VehicleDetailsViewController"];
        
        (self.vehicleDetailsViewController).destinationViewController = [self insuranceExtrasViewController_];
        (self.vehicleDetailsViewController).viewType = ViewTypeGeneric;
        (self.vehicleDetailsViewController).fallBackViewController = [self paymentSummaryViewController_];
        (self.vehicleDetailsViewController).cartrawlerAPI = self.cartrawlerAPI;
        
        return self.vehicleDetailsViewController;
    } else {
        return self.vehicleDetailsViewController;
    }
}

- (CTViewController *)insuranceExtrasViewController_
{
    if (self.insuranceExtrasViewController == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kExtrasViewStoryboard bundle:self.bundle];
        
        _insuranceExtrasViewController = [storyboard instantiateViewControllerWithIdentifier:@"ExtrasViewController"];
        
        (self.insuranceExtrasViewController).destinationViewController = [self paymentSummaryViewController_];
        (self.insuranceExtrasViewController).viewType = ViewTypeInsurance;
        (self.insuranceExtrasViewController).fallBackViewController = [self driverDetialsViewController_];
        (self.insuranceExtrasViewController).cartrawlerAPI = self.cartrawlerAPI;
        
        return self.insuranceExtrasViewController;

        
    } else {
        return self.insuranceExtrasViewController;
    }
}


- (CTViewController *)paymentSummaryViewController_
{
    if (self.paymentSummaryViewController == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSummaryViewStoryboard bundle:self.bundle];
        _paymentSummaryViewController = [storyboard instantiateViewControllerWithIdentifier:@"PaymentSummaryViewController"];
        
        (self.paymentSummaryViewController).destinationViewController = [self driverDetialsViewController_];
        (self.paymentSummaryViewController).viewType = ViewTypeGeneric;
        [self.paymentSummaryViewController setFallBackViewController:nil];
        (self.paymentSummaryViewController).cartrawlerAPI = self.cartrawlerAPI;
        
        return self.paymentSummaryViewController;

    } else {
        return self.paymentSummaryViewController;
    }
}

- (CTViewController *)driverDetialsViewController_
{
    if (self.driverDetialsViewController == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kDetailsViewStoryboard bundle:self.bundle];
        _driverDetialsViewController = [storyboard instantiateViewControllerWithIdentifier:@"DriverDetailsViewController"];
        
        (self.driverDetialsViewController).viewType = ViewTypeDriverDetails;
        (self.driverDetialsViewController).destinationViewController = [self paymentViewController_];
        [self.driverDetialsViewController setFallBackViewController:nil];
        (self.driverDetialsViewController).cartrawlerAPI = self.cartrawlerAPI;
        
        return self.driverDetialsViewController;
    } else {
        return self.driverDetialsViewController;
    }
}

- (CTViewController *)paymentViewController_
{
    if (self.paymentViewController == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kPaymentViewStoryboard bundle:self.bundle];
        _paymentViewController = [storyboard instantiateViewControllerWithIdentifier:@"PaymentViewController"];
        
        (self.paymentViewController).viewType = ViewTypePaymentDetails;
        (self.paymentViewController).destinationViewController = [self paymentCompletionViewController_];

        return self.paymentViewController;

    } else {
        return self.paymentViewController;
    }
}

- (CTViewController *)paymentCompletionViewController_
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kPaymentViewStoryboard bundle:self.bundle];
    _paymentCompletionViewController = [storyboard instantiateViewControllerWithIdentifier:@"PaymentCompletionViewController"];
    
    (self.paymentCompletionViewController).viewType = ViewTypeGeneric;
    
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
        
        vc.cartrawlerAPI = self.cartrawlerAPI;
        
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
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kGTViewStoryboard bundle:self.bundle];
        return [storyboard instantiateViewControllerWithIdentifier:@"GroundTransportViewController"];
    } else {
        return self.groundTransportViewController;
    }
}

#pragma Crash handling

void uncaughtExceptionHandler(NSException *exception)
{
    NSLog(@"\n\n\nCartrawlerSDK Crash:\n%@\n\n\n", exception);
    NSLog(@"\n\n\nCartrawlerSDK Stack Trace:\n\n\n%@", exception.callStackSymbols);
}


@end
