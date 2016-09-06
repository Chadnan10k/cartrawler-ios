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
#import "CarRentalSearch.h"
#import "CTValidation.h"
#import "GTSearchValidation.h"
#import "GTSelectionValidation.h"
#import "GTPassengerDetailsValidation.h"
#import "GTGenericValidation.h"

#define kSearchViewStoryboard           @"StepOne"
#define kSearchResultsViewStoryboard    @"StepTwo"
#define kVehicleDetailsViewStoryboard   @"StepThree"
#define kExtrasViewStoryboard           @"StepFour"
#define kSummaryViewStoryboard          @"StepFive"
#define kDetailsViewStoryboard          @"StepSix"
#define kPaymentViewStoryboard          @"Payment"
#define kGroundTransportStoryboard      @"GroundTransport"

#define kGTViewStoryboard @"GroundTransport"

@interface CartrawlerSDK()

@property (nonatomic, strong, readonly) CTViewController *searchDetailsViewControllerOverride;

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic, strong) NSArray <CTViewController *> *customViewControllers;

@property (nonatomic, strong) NSBundle *bundle;

@property (nonatomic) BOOL isCarRental;//remove this hack

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
    
    //---SET DEFAULT CAR RENTAL VIEWS---
    UIStoryboard *searchStoryboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:self.bundle];
    _searchDetailsViewController = [searchStoryboard instantiateViewControllerWithIdentifier:@"SearchDetailsViewController"];
    
    UIStoryboard *searchResultsStoryboard = [UIStoryboard storyboardWithName:kSearchResultsViewStoryboard bundle:self.bundle];
    _vehicleSelectionViewController = [searchResultsStoryboard instantiateViewControllerWithIdentifier:@"SearchResultsViewController"];
    
    UIStoryboard *vehicleDetailsStoryboard = [UIStoryboard storyboardWithName:kVehicleDetailsViewStoryboard bundle:self.bundle];
    _vehicleDetailsViewController = [vehicleDetailsStoryboard instantiateViewControllerWithIdentifier:@"VehicleDetailsViewController"];
    
    UIStoryboard *extrasStoryboard = [UIStoryboard storyboardWithName:kExtrasViewStoryboard bundle:self.bundle];
    _insuranceExtrasViewController = [extrasStoryboard instantiateViewControllerWithIdentifier:@"ExtrasViewController"];
    
    UIStoryboard *summaryStoryboard = [UIStoryboard storyboardWithName:kSummaryViewStoryboard bundle:self.bundle];
    _paymentSummaryViewController = [summaryStoryboard instantiateViewControllerWithIdentifier:@"PaymentSummaryViewController"];
    
    UIStoryboard *detailsStoryboard = [UIStoryboard storyboardWithName:kDetailsViewStoryboard bundle:self.bundle];
    _driverDetialsViewController = [detailsStoryboard instantiateViewControllerWithIdentifier:@"DriverDetailsViewController"];
    
    UIStoryboard *paymentStoryboard = [UIStoryboard storyboardWithName:kPaymentViewStoryboard bundle:self.bundle];
    _paymentViewController = [paymentStoryboard instantiateViewControllerWithIdentifier:@"PaymentViewController"];
    _paymentCompletionViewController = [paymentStoryboard instantiateViewControllerWithIdentifier:@"PaymentCompletionViewController"];

    //---------------------------------
    
    //---SET DEFAULT GROUND TRANSPORT VIEWS---
    UIStoryboard *groundTransportStoryboard = [UIStoryboard storyboardWithName:kGroundTransportStoryboard bundle:self.bundle];
    _gtSearchDetailsViewController = [groundTransportStoryboard instantiateViewControllerWithIdentifier:@"GTSearchViewController"];
    
    _gtServiceSelectionViewController = [groundTransportStoryboard instantiateViewControllerWithIdentifier:@"GroundServicesViewController"];
    
    _gtDriverDetailsViewController = [groundTransportStoryboard instantiateViewControllerWithIdentifier:@"DriverDetailsViewController"];
    
    _gtPaymentViewController = [groundTransportStoryboard instantiateViewControllerWithIdentifier:@"PaymentViewController"];
    
    _gtPaymentCompletionViewController = [groundTransportStoryboard instantiateViewControllerWithIdentifier:@"PaymentCompletionViewController"];
    
    //----------------------------------------
    
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
    _isCarRental = YES;
    
    [[CarRentalSearch instance] reset];
    
    [self configureViews];

    CTNavigationController *navController;
    
    navController = [[CTNavigationController alloc] initWithRootViewController: self.searchDetailsViewController];

    navController.navigationBar.hidden = YES;
    [viewController presentViewController:navController animated:YES completion:nil];
}

- (void)presentGroundTransportInViewController:(UIViewController *)viewController
{
    _isCarRental = NO;
    
    [[GroundTransportSearch instance] reset];
    
    [self configureViews];
    
    CTNavigationController *navController;
    
    navController = [[CTNavigationController alloc] initWithRootViewController: self.gtSearchDetailsViewController];
    
    navController.navigationBar.hidden = YES;
    [viewController presentViewController:navController animated:YES completion:nil];
}

- (void)configureViews {
    
    //CAR RENTAL
    [self configureViewController:self.searchDetailsViewController viewType:ViewTypeSearchDetails destination:self.vehicleSelectionViewController fallback:nil];
    
    [self configureViewController:self.vehicleSelectionViewController viewType:ViewTypeVehicleSelection destination:self.vehicleDetailsViewController fallback:nil];
    
    [self configureViewController:self.vehicleDetailsViewController viewType:ViewTypeGeneric destination:self.insuranceExtrasViewController fallback:nil];
    
    [self configureViewController:self.insuranceExtrasViewController viewType:ViewTypeInsurance destination:self.paymentSummaryViewController fallback:nil];
    
    [self configureViewController:self.paymentSummaryViewController viewType:ViewTypeGeneric destination:self.driverDetialsViewController fallback:nil];
    
    [self configureViewController:self.driverDetialsViewController viewType:ViewTypeDriverDetails destination:self.paymentViewController fallback:nil];
    
    [self configureViewController:self.paymentViewController viewType:ViewTypePaymentDetails destination:self.paymentCompletionViewController fallback:nil];
    
    [self configureViewController:self.paymentCompletionViewController viewType:ViewTypeGeneric destination:self.vehicleSelectionViewController fallback:nil];
    
    //GROUND TRANSPORT
    
    [self configureViewController:self.gtSearchDetailsViewController validationController:[[GTSearchValidation alloc] init] destination:self.gtServiceSelectionViewController fallback:nil];
    
    [self configureViewController:self.gtServiceSelectionViewController validationController:[[GTSelectionValidation alloc] init] destination:self.gtDriverDetailsViewController fallback:nil];

    [self configureViewController:self.gtDriverDetailsViewController validationController:[[GTPassengerDetailsValidation alloc] init] destination:self.gtPaymentViewController fallback:nil];

    [self configureViewController:self.gtPaymentViewController validationController:[[GTGenericValidation alloc] init] destination:self.gtPaymentCompletionViewController fallback:nil];
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
    viewController.search = [CarRentalSearch instance];
    return viewController;
}

- (CTViewController *)configureViewController:(CTViewController *)viewController
                         validationController:(CTValidation *)validationController
                                  destination:(CTViewController *)destination
                                     fallback:(CTViewController *)fallback
{
    viewController.destinationViewController = destination;
    viewController.fallBackViewController = fallback;
    viewController.cartrawlerAPI = self.cartrawlerAPI;
    
    if (self.isCarRental) {
        viewController.search = [CarRentalSearch instance];
    } else {
        viewController.groundSearch = [GroundTransportSearch instance];
    }
    
    viewController.validationController = validationController;
    
    return viewController;
}

- (void)rerouteViewController:(CTViewController *)viewController
                  destination:(CTViewController *)destination
                     fallback:(CTViewController *)fallback
{
    viewController.destinationViewController = destination;
    viewController.fallBackViewController = fallback;
}


#pragma mark Push Notifications

+ (void)registerForPushNotifications:(NSData *)deviceToken
{
    //send call to server
}

+ (void)didReceivePushNotification:(NSDictionary *)notification
{
    //open booking info
}

#pragma Crash handling

void uncaughtExceptionHandler(NSException *exception)
{
    NSLog(@"\n\n\nCartrawlerSDK Crash:\n%@\n\n\n", exception);
    NSLog(@"\n\n\nCartrawlerSDK Stack Trace:\n\n\n%@", exception.callStackSymbols);
}

@end
