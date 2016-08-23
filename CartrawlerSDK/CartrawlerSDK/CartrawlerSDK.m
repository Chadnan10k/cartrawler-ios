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
    
    if (isDebug) {
        [self.cartrawlerAPI enableLogging:YES];
    }
    
    //set default views
    UIStoryboard *sa = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:self.bundle];
    _searchDetailsViewController = [sa instantiateViewControllerWithIdentifier:@"SearchDetailsViewController"];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:kSearchResultsViewStoryboard bundle:self.bundle];
    _vehicleSelectionViewController = [sb instantiateViewControllerWithIdentifier:@"SearchResultsViewController"];
    
    UIStoryboard *sc = [UIStoryboard storyboardWithName:kVehicleDetailsViewStoryboard bundle:self.bundle];
    _vehicleDetailsViewController = [sc instantiateViewControllerWithIdentifier:@"VehicleDetailsViewController"];
    
    UIStoryboard *sd = [UIStoryboard storyboardWithName:kExtrasViewStoryboard bundle:self.bundle];
    _insuranceExtrasViewController = [sd instantiateViewControllerWithIdentifier:@"ExtrasViewController"];
    
    UIStoryboard *se = [UIStoryboard storyboardWithName:kSummaryViewStoryboard bundle:self.bundle];
    _paymentSummaryViewController = [se instantiateViewControllerWithIdentifier:@"PaymentSummaryViewController"];
    
    UIStoryboard *sf = [UIStoryboard storyboardWithName:kDetailsViewStoryboard bundle:self.bundle];
    _driverDetialsViewController = [sf instantiateViewControllerWithIdentifier:@"DriverDetailsViewController"];
    
    UIStoryboard *sg = [UIStoryboard storyboardWithName:kPaymentViewStoryboard bundle:self.bundle];
    _paymentViewController = [sg instantiateViewControllerWithIdentifier:@"PaymentViewController"];
    
    UIStoryboard *sh = [UIStoryboard storyboardWithName:kPaymentViewStoryboard bundle:self.bundle];
    _paymentCompletionViewController = [sh instantiateViewControllerWithIdentifier:@"PaymentCompletionViewController"];
    
    [self configureViews];
    
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
    
    navController = [[CTNavigationController alloc] initWithRootViewController: self.searchDetailsViewController];

    navController.navigationBar.hidden = YES;
    [viewController presentViewController:navController animated:YES completion:nil];
}

- (void)presentGroundTransportInViewController:(UIViewController *)viewController
{
    CTNavigationController *navController=[[CTNavigationController alloc]initWithRootViewController:[self groundTransportViewController_]];
    navController.navigationBar.hidden = YES;
    [viewController presentViewController:navController animated:YES completion:nil];
}

- (void)configureViews {
    [self configureViewController:self.searchDetailsViewController viewType:ViewTypeSearchDetails destination:self.vehicleSelectionViewController fallback:nil];
    
    [self configureViewController:self.vehicleSelectionViewController viewType:ViewTypeVehicleSelection destination:self.vehicleDetailsViewController fallback:nil];
    
    [self configureViewController:self.vehicleDetailsViewController viewType:ViewTypeGeneric destination:self.insuranceExtrasViewController fallback:nil];
    
    [self configureViewController:self.insuranceExtrasViewController viewType:ViewTypeInsurance destination:self.paymentSummaryViewController fallback:nil];
    
    [self configureViewController:self.paymentSummaryViewController viewType:ViewTypeGeneric destination:self.driverDetialsViewController fallback:nil];
    
    [self configureViewController:self.driverDetialsViewController viewType:ViewTypeDriverDetails destination:self.paymentViewController fallback:nil];
    
    [self configureViewController:self.paymentViewController viewType:ViewTypePaymentDetails destination:self.paymentCompletionViewController fallback:nil];
    
    [self configureViewController:self.paymentCompletionViewController viewType:ViewTypeGeneric destination:self.vehicleSelectionViewController fallback:nil];
}

- (void)overrideSearchDetailsViewController:(CTViewController *)viewController
{
    _searchDetailsViewControllerOverride = viewController;
    [self configureViews];
}

- (void)overrideVehicleSelectionViewController:(CTViewController *)viewController
{
    _vehicleSelectionViewController = viewController;
    [self configureViews];
}

- (void)overrideVehicleDetailsViewController:(CTViewController *)viewController
{
    _vehicleDetailsViewController = viewController;
    [self configureViews];
}

- (void)overrideInsuranceExtrasViewController:(CTViewController *)viewController
{
    _insuranceExtrasViewController = viewController;
    [self configureViews];
}

- (void)overridePaymentSummaryViewController:(CTViewController *)viewController
{
    _paymentSummaryViewController = viewController;
    [self configureViews];
}

- (void)overrideDriverDetialsViewController:(CTViewController *)viewController
{
    _driverDetialsViewController = viewController;
    [self configureViews];
}

- (void)overridePaymentCompletionViewController:(CTViewController *)viewController
{
    _paymentCompletionViewController = viewController;
    [self configureViews];
}

- (CTViewController *)configureViewController:(CTViewController *)viewController
                                     viewType:(ViewType)viewType
                                  destination:(CTViewController *)destination
                                     fallback:(CTViewController *)fallback
{
    viewController.destinationViewController = destination;
    viewController.fallBackViewController = fallback;
    viewController.viewType = viewType;
    viewController.cartrawlerAPI = self.cartrawlerAPI;
    viewController.search = [CTSearch instance];
    return viewController;
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
