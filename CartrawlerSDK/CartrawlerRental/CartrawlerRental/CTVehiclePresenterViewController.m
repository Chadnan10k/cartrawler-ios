//
//  CTVehiclePresenterViewController.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 20/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehiclePresenterViewController.h"
#import "CTVehicleSelectionView.h"
#import "CTVehicleInfoView.h"
#import <CartrawlerSDK/CTLayoutManager.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CartrawlerSDK+UIImageView.h>
#import <CartrawlerSDK/CartrawlerSDK+NSString.h>
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import <CartrawlerSDK/CTAnalytics.h>
#import "CTSearchDetailsViewController.h"
#import "CTRentalConstants.h"
#import "CTRentalLocalizationConstants.h"
#import "CTFilterViewController.h"
#import "CTPaymentSummaryExpandedView.h"
#import <CartrawlerSDK/CTAnalytics.h>
#import "CTRentalScrollingLogic.h"
#import "CTInterstitialViewController.h"

@interface CTVehiclePresenterViewController () <CTVehicleSelectionViewDelegate, CTVehicleInfoDelegate, CTFilterDelegate>

typedef NS_ENUM(NSInteger, CTPresentedView) {
    CTPresentedViewNone = 0,
    CTPresentedViewList,
    CTPresentedViewDetails
};

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *secondaryNavigationBar;
@property (weak, nonatomic) IBOutlet CTLabel *locationLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (nonatomic, strong) CTVehicleSelectionView *vehicleSelectionView;
@property (nonatomic, strong) CTVehicleInfoView *vehicleDetailsView;
@property (nonatomic, strong) CTFilterViewController *filterViewController;

@property (nonatomic) CTPresentedView presentedView;

@property (nonatomic, assign) BOOL sortByPrice;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarHeightConstraint;
@property (nonatomic, strong) CTRentalScrollingLogic *scrollingLogic;

@property (weak, nonatomic) IBOutlet CTPaymentSummaryExpandedView *summaryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *dimmingView;

@end

@implementation CTVehiclePresenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sortByPrice = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.rightButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.rightButton.titleLabel.minimumScaleFactor = 0.6;
    
    [self createVehicleListView];
    [self updateVehicleListView];
    [self updateButtonTitlesForPresentedView:CTPresentedViewList];
    [self setNavigationBarLocationLabel];
    [self setNavigationBarDateLabel];
    [self setNavigationBarBackButtonImage];
    [self addScrollingBehaviour];
    [self addObserverForVehicleSearchUpdates];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.presentedView == CTPresentedViewNone) {
        if (self.search.vehicleAvailability.items.count == 0) {
            self.secondaryNavigationBar.alpha = 0;
            [CTInterstitialViewController present:self search:self.search];
        }
    }
    
    if (self.presentedView == CTPresentedViewList) {
        [self tagVehiclesStep];
    }
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(checkVehicleAvailabilityScreen)
												 name:UIApplicationDidBecomeActiveNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector: @selector(checkVehicleAvailabilityScreen)
												 name: UIApplicationDidEnterBackgroundNotification
											   object: nil];
}

- (void) checkVehicleAvailabilityScreen {
	
	if (self.search.vehicleAvailability.items.count > 0) {
		[self hideVehicleDetailsView];
		[self animateNavigationBarToOriginalPosition];
		[self setNavigationBarLocationLabel];
		[self setNavigationBarDateLabel];
		[self updateVehicleListView];
		[self updateButtonTitlesForPresentedView:self.presentedView];
		self.secondaryNavigationBar.alpha = 1;
		[CTInterstitialViewController dismiss];
	} else {
		[CTInterstitialViewController dismiss];
		self.secondaryNavigationBar.alpha = 0;
		[CTInterstitialViewController present:self search:self.search];
		[self addObserverForVehicleSearchUpdates];
		
	}
}

// MARK: Setup Views

- (void)createVehicleListView {
    self.vehicleSelectionView = [CTVehicleSelectionView new];
    self.vehicleSelectionView.verticalOffset = self.toolbarHeightConstraint.constant;
    self.vehicleSelectionView.delegate = self;
    [self.containerView addSubview:self.vehicleSelectionView];
    [CTLayoutManager pinView:self.vehicleSelectionView toSuperView:self.containerView padding:UIEdgeInsetsZero];
}

- (void)createVehicleDetailsView {
    self.vehicleDetailsView = [[CTVehicleInfoView alloc] initWithVerticalOffset:self.toolbarHeightConstraint.constant];
    self.vehicleDetailsView.search = self.search;
    self.vehicleDetailsView.cartrawlerAPI = self.cartrawlerAPI;
    self.vehicleDetailsView.delegate = self;
    self.vehicleDetailsView.alpha = 0;
    [self.containerView addSubview:self.vehicleDetailsView];
    [CTLayoutManager pinView:self.vehicleDetailsView toSuperView:self.containerView padding:UIEdgeInsetsZero];
}

// MARK: View Updates

- (void)updateVehicleListView {
    if (self.search.vehicleAvailability.items > 0) {
        [self.vehicleSelectionView updateSelection:self.search.vehicleAvailability.items
                                        pickupDate:self.search.pickupDate
                                       dropoffDate:self.search.dropoffDate
                                       sortByPrice:self.sortByPrice];
        [self.vehicleSelectionView scrollToTop];
        self.presentedView = CTPresentedViewList;
    }
}

- (void)updateVehicleDetailView {
    [self.vehicleDetailsView refreshViewWithVehicle:self.search.selectedVehicle];
}

// MARK: View Appearance

- (void)showVehicleDetailsView {
    [UIView animateWithDuration:0.2 animations:^{
        self.vehicleDetailsView.alpha = 1;
        self.vehicleSelectionView.alpha = 0;
    } completion:nil];
    self.presentedView = CTPresentedViewDetails;
}

- (void)hideVehicleDetailsView {
    [UIView animateWithDuration:0.2 animations:^{
        self.vehicleDetailsView.alpha = 0;
        self.vehicleSelectionView.alpha = 1;
    } completion:^(BOOL finished) {
        [self.vehicleDetailsView removeFromSuperview];
        self.vehicleDetailsView = nil;
    }];
    self.presentedView = CTPresentedViewList;
}

// MARK: Model Updates

- (void)addObserverForVehicleSearchUpdates {
    [self.search addObserver:self forKeyPath:@"vehicleAvailability"
                     options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                     context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideVehicleDetailsView];
        [self animateNavigationBarToOriginalPosition];
        [self setNavigationBarLocationLabel];
        [self setNavigationBarDateLabel];
        [self updateVehicleListView];
        [self updateButtonTitlesForPresentedView:self.presentedView];
        self.secondaryNavigationBar.alpha = 1;
        [CTInterstitialViewController dismiss];
    });
}

- (void)dealloc {
    @try {
        [self.search removeObserver:self forKeyPath:@"vehicleAvailability"];
		[[NSNotificationCenter defaultCenter] removeObserver:self
														name:UIApplicationDidBecomeActiveNotification
													  object:nil];
		[[NSNotificationCenter defaultCenter] removeObserver:self
														name:UIApplicationDidEnterBackgroundNotification
													  object:nil];
    } @catch (NSException *exception) {
    }
}

// MARK: Search

- (IBAction)search:(id)sender
{
    [[CTAnalytics instance] tagScreen:@"editSearch" detail:@"open" step:nil];
    [self tagSearchStep];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:CTRentalSearchStoryboard bundle:bundle];
    CTSearchDetailsViewController *searchViewController = [storyboard instantiateViewControllerWithIdentifier:CTRentalSearchViewIdentifier];
    searchViewController.cartrawlerAPI = self.cartrawlerAPI;
    searchViewController.search = self.search;
    searchViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:searchViewController animated:YES completion:nil];
}

// MARK: Navigation Bar

- (void)setNavigationBarBackButtonImage {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIImage *buttonImage;
    if (self.navigationController.viewControllers.firstObject == self) {
        buttonImage = [UIImage imageNamed:@"down_arrow" inBundle:bundle compatibleWithTraitCollection:nil];
    } else {
        buttonImage = [UIImage imageNamed:@"backArrow" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    [self.dismissButton setImage:buttonImage forState:UIControlStateNormal];
}

- (void)setNavigationBarLocationLabel {
    if (self.search.pickupLocation == self.search.dropoffLocation) {
        self.locationLabel.text = [NSString stringWithFormat:@"%@", self.search.pickupLocation.name];
    } else {
        self.locationLabel.text = [NSString stringWithFormat:@"%@\n- to -\n%@",
                                   self.search.pickupLocation.name, self.search.dropoffLocation.name];
    }
}

- (void)setNavigationBarDateLabel {
    NSString *pickupDate = [self.search.pickupDate stringFromDateWithFormat:@"dd MMM, hh:mm a"];
    NSString *dropoffDate = [self.search.dropoffDate stringFromDateWithFormat:@"dd MMM, hh:mm a"];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@", pickupDate, dropoffDate];
}

- (void)updateButtonTitlesForPresentedView:(CTPresentedView)presentedView {
    switch (presentedView) {
        case CTPresentedViewNone:
            [self.leftButton setTitle:@"" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"" forState:UIControlStateNormal];
            break;
        case CTPresentedViewList:
            [self.leftButton setTitle:CTLocalizedString(CTRentalResultsFilter) forState:UIControlStateNormal];
            [self.rightButton setAttributedTitle:[self sortDropdownTitle:self.sortByPrice] forState:UIControlStateNormal];
            break;
        case CTPresentedViewDetails:
            [self.leftButton setTitle:CTLocalizedString(CTRentalResultsOtherCars) forState:UIControlStateNormal];
            [self.rightButton setAttributedTitle:[self priceDropdownTitle] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (NSAttributedString *)priceDropdownTitle
{
    NSString *price = @"";
    
    if (self.search.isBuyingInsurance) {
        price = [[NSNumber numberWithFloat:self.search.selectedVehicle.vehicle.totalPriceForThisVehicle.floatValue + self.search.insurance.premiumAmount.floatValue] numberStringWithCurrencyCode];
    } else {
        price = [self.search.selectedVehicle.vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode];
    }
    NSAttributedString *priceString = [NSString regularText:CTLocalizedString(CTRentalCarRentalTotal)
                                               regularColor:[UIColor whiteColor]
                                                regularSize:17
                                             attributedText:price
                                                  boldColor:[UIColor whiteColor]
                                                   boldSize:17
                                                   useSpace:YES];
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    UIImage *image = [[UIImage imageNamed:@"down_arrow" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    priceString = [NSString string:priceString withInlineImage:image inlineImageScale:0.65];
    
    return priceString;
}

- (NSAttributedString *)sortDropdownTitle:(BOOL)sortByPrice
{
    NSString *boldText = sortByPrice ? CTLocalizedString(CTRentalSortPrice) : CTLocalizedString(CTRentalSortRecommended);
    
    NSAttributedString *sortString = [NSString regularText:CTLocalizedString(CTRentalSortTitle)
                                              regularColor:[UIColor whiteColor]
                                               regularSize:17
                                            attributedText:boldText
                                                 boldColor:[UIColor whiteColor]
                                                  boldSize:17
                                                  useSpace:YES];
    
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    UIImage *image = [[UIImage imageNamed:@"down_arrow" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return [NSString string:sortString withInlineImage:image inlineImageScale:0.65];
}

// MARK: Navigation Bar Button Selections

- (IBAction)leftTap:(id)sender
{
    switch (self.presentedView) {
        case CTPresentedViewNone:
            break;
        case CTPresentedViewList:
            [self didSelectFilter];
            break;
        case CTPresentedViewDetails:
            [self didSelectOtherCars];
            break;
        default:
            break;
    }
}

- (IBAction)rightTap:(id)sender
{
    switch (self.presentedView) {
        case CTPresentedViewNone:
            break;
        case CTPresentedViewList:
            [self didSelectSort];
            break;
        case CTPresentedViewDetails:
            [self updateDetailedPriceSummary];
            [self showDetailedPriceSummary];
            break;
        default:
            break;
    }
}

// MARK: Filter

- (CTFilterViewController *)filterViewController {
    if (!_filterViewController) {
        _filterViewController = [CTFilterViewController initInViewController:self withData:self.search.vehicleAvailability];
        _filterViewController.delegate = self;
    }
    return _filterViewController;
}

- (void)didSelectFilter {
    [[CTAnalytics instance] tagScreen:@"mdl_filter" detail:@"open" step:nil];
    [self.filterViewController present];
}

// MARK: CTFilterDelegate

- (void)filterDidUpdate:(NSArray<CTAvailabilityItem *> *)filteredData
{
    [self.vehicleSelectionView updateSelection:filteredData
                                    pickupDate:self.search.pickupDate
                                   dropoffDate:self.search.dropoffDate
                                   sortByPrice:self.sortByPrice];
}

// MARK: Sort

- (void)didSelectSort {
    [[CTAnalytics instance] tagScreen:@"mdl_sort" detail:@"open" step:nil];
    
    NSString *sortResults = CTLocalizedString(CTRentalSortTitle);
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:sortResults
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSString *sortPrice = CTLocalizedString(CTRentalSortPrice);
    UIAlertAction *lowestPrice = [UIAlertAction actionWithTitle:sortPrice
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            [self sortVehicleListByPrice:YES];
                                                        }];
    
    NSString *sortRecommended = CTLocalizedString(CTRentalSortRecommended);
    UIAlertAction *recommendedVehicles = [UIAlertAction actionWithTitle:sortRecommended
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * action) {
                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        [self sortVehicleListByPrice:NO];
                                                                    });
                                                                }];
    NSString *cancelString = CTLocalizedString(CTRentalCTACancel);
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelString style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [[CTAnalytics instance] tagScreen:@"mdl_sort" detail:@"close" step:nil];
                                                   }];
    
    [alert addAction:lowestPrice];
    [alert addAction:recommendedVehicles];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sortVehicleListByPrice:(BOOL)sortByPrice {
    self.sortByPrice = sortByPrice;
    if (sortByPrice) {
        [[CTAnalytics instance] tagScreen:@"sort" detail:@"price" step:nil];
    } else {
        [[CTAnalytics instance] tagScreen:@"sort" detail:@"relevance" step:nil];
    }
    
    [self updateButtonTitlesForPresentedView:self.presentedView];
    [self.vehicleSelectionView sortByPrice:sortByPrice];
}

// MARK: Other Cars

- (void)didSelectOtherCars {
    [self.search resetUserSelections];
    [self hideVehicleDetailsView];
    [self animateNavigationBarToOriginalPosition];
    [self updateButtonTitlesForPresentedView:self.presentedView];
}

// MARK: Detailed Price Summary

- (void)updateDetailedPriceSummary
{
    [self.summaryView updateWithSearch:self.search];
    self.summaryViewHeightConstraint.constant = self.summaryView.desiredHeight;
    self.summaryViewTopConstraint.constant = -self.summaryView.desiredHeight;
    [self.view layoutIfNeeded];
}

- (void)showDetailedPriceSummary
{
    [[CTAnalytics instance] tagScreen:@"price_sum" detail:@"open" step:nil];
    
    self.summaryViewTopConstraint.constant = 0;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.dimmingView.alpha = 0.3;
                         [self.view layoutIfNeeded];
                     }];
}

- (void)hideDetailedPriceSummary
{
    self.summaryViewTopConstraint.constant = -self.summaryView.desiredHeight;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.dimmingView.alpha = 0;
                         [self.view layoutIfNeeded];
                     }];
}

- (IBAction)didInteractWithDetailedPriceSummary:(UIGestureRecognizer *)gestureRecognizer {
    [[CTAnalytics instance] tagScreen:@"price_sum" detail:@"close" step:nil];
    [self hideDetailedPriceSummary];
}

// MARK: Scrolling Behaviour

- (void)addScrollingBehaviour {
    self.scrollingLogic = [[CTRentalScrollingLogic alloc] initWithTopViewHeight:self.toolbarHeightConstraint.constant];
}

- (void)animateNavigationBarToOriginalPosition {
    [UIView animateWithDuration:0.2 animations:^{
        self.toolbarTopConstraint.constant = 0;
        [self.view layoutIfNeeded];
    } completion:nil];
}

// MARK: CTVehicleSelectionViewDelegate

- (void)didSelectVehicle:(CTAvailabilityItem *)item
{
    self.search.selectedVehicle = item;
    
    [self tagVehicleStep];
    
    if ([CTSDKSettings instance].isStandalone) {
        [self pushToDestination];
    } else {
        [self createVehicleDetailsView];
        [self updateVehicleDetailView];
        [self showVehicleDetailsView];
        [self updateButtonTitlesForPresentedView:self.presentedView];
    }
}

// MARK: Dismiss

- (IBAction)dismiss:(id)sender
{
    [self tagExit];
    
    [self.search resetUserSelections];
    
    [self hideDetailedPriceSummary];
    
    self.presentedView = CTPresentedViewNone;
    
    BOOL isInPath = self.navigationController.viewControllers.firstObject == self;
    
    if (isInPath) {
        [self dismiss];
    } else {
        [[CTAnalytics instance] tagScreen:@"back_btn" detail:@"vehicles" step:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// MARK: CTVehicleInfoDelegate

- (void)infoViewPresentViewController:(UIViewController *)viewController
{
    [self presentModalViewController:viewController];
}

- (void)infoViewPushToExtraDetail
{
    
}

- (void)infoViewPushViewController:(UIViewController *)viewController
{
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)infoViewRequestNewVehiclePrice:(CTNewVehiclePriceCompeltion)completion
{
    [self requestNewVehiclePrice:completion];
}

- (void)infoViewPresentVehicleSelection
{
    
}

- (void)infoViewAddInsuranceTapped:(BOOL)didAddInsurance
{
    [self.rightButton setAttributedTitle:[self priceDropdownTitle] forState:UIControlStateNormal];
}

- (void)infoViewPushToNextStep
{
    if (![CTSDKSettings instance].isStandalone) {
        self.presentedView = CTPresentedViewNone;
        [self dismiss];
    } else {
        [self pushToDestination];
    }
}

- (void)infoViewDidScroll:(CGFloat)verticalOffset {
    self.toolbarTopConstraint.constant = [self.scrollingLogic offsetForDesiredOffset:verticalOffset
                                                                         currentOffset:self.toolbarTopConstraint.constant];
}

- (void)infoViewDidScrollToInsuranceView {
    [self tagInsuranceStep];
}

// MARK: Analytics

- (void)tagSearchStep {
    [[CTAnalytics instance] tagScreen:@"step" detail:@"searchcars" step:nil];
    [self sendEvent:NO customParams:@{@"eventName" : @"Search Step",
                                      @"stepName" : @"Step1",
                                      @"clientID" : [CTSDKSettings instance].clientId,
                                      @"residenceID" : [CTSDKSettings instance].homeCountryCode
                                      } eventName:@"Step of search" eventType:@"Step"];
}

- (void)tagVehiclesStep {
    [[CTAnalytics instance] setAnalyticsStep:CTAnalyticsStepVehicleSelection];
    [[CTAnalytics instance] tagScreen:@"step" detail:@"vehicles" step:nil];
}

- (void)tagVehicleStep {
    [[CTAnalytics instance] setAnalyticsStep:CTAnalyticsStepVehicleDetails];
    [[CTAnalytics instance] tagScreen:@"step" detail:@"vehicle-v" step:nil];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:self.search.pickupDate
                                                          toDate:self.search.dropoffDate
                                                         options:0];
    
    NSNumber *pricePerDay = [NSNumber numberWithFloat:self.search.selectedVehicle.vehicle.totalPriceForThisVehicle.floatValue
                             / ([components day] ?: 1)];
    
    NSString *vehName = [NSString stringWithFormat:@"%@ %@", self.search.selectedVehicle.vehicle.makeModelName,
                         self.search.selectedVehicle.vehicle.orSimilar];
    
    [self sendEvent:NO customParams:@{@"eventName" : @"Vehicle Details Step",
                                      @"stepName" : @"Step3",
                                      @"carPrice" : self.search.selectedVehicle.vehicle.totalPriceForThisVehicle.stringValue,
                                      @"carPricePerDay" : pricePerDay.stringValue,
                                      @"carSelected" : vehName,
                                      } eventName:@"Step of search" eventType:@"Step"];
}

- (void)tagInsuranceStep {
    NSString *insOffered = self.search.insurance ? @"true" : @"false";
    
    [[CTAnalytics instance] tagScreen:@"ins_offer" detail:insOffered step:nil];
    [[CTAnalytics instance] tagScreen:@"step" detail:@"vehicle-e" step:nil];
    
    [self sendEvent:NO customParams:@{@"eventName" : @"Insurance & Extras Step",
                                      @"stepName" : @"Step4",
                                      @"insuranceOffered" : insOffered
                                      } eventName:@"Step of search" eventType:@"Step"];
}

- (void)tagExit {
    if (self.presentedView == CTPresentedViewDetails) {
        if (self.vehicleDetailsView.insuranceViewDidAppear) {
            [[CTAnalytics instance] tagScreen:@"exit" detail:@"vehicle-v" step:nil];
        } else {
            [[CTAnalytics instance] tagScreen:@"exit" detail:@"vehicle-e" step:nil];
        }
    } else {
        [[CTAnalytics instance] tagScreen:@"exit" detail:@"vehicles" step:nil];
    }
    [[CTAnalytics instance] setAnalyticsStep:CTAnalyticsStepSearch];
}

@end
