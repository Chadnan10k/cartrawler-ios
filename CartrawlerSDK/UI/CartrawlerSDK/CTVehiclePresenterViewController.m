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
#import "CTSearchDetailsViewController.h"
#import "CTRentalConstants.h"
#import "CTRentalLocalizationConstants.h"
#import "CTFilterViewController.h"
#import "CTPaymentSummaryExpandedView.h"

@interface CTVehiclePresenterViewController () <CTVehicleSelectionViewDelegate, CTVehicleInfoDelegate, CTFilterDelegate>

typedef NS_ENUM(NSInteger, CTPresentedView) {
    CTPresentedViewNone = 0,
    CTPresentedViewSelection,
    CTPresentedViewDetails
};

@property (weak, nonatomic) IBOutlet UIView *containerView;
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

@property (weak, nonatomic) IBOutlet CTPaymentSummaryExpandedView *summaryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *dimmingView;

@end

@implementation CTVehiclePresenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateNavigationBar];
    [self.search addObserver:self forKeyPath:@"vehicleAvailability"
                     options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                     context:nil];
    
    if (self.search.selectedVehicle) {
        [self presentVehicleDetails];
    } else {
        [self presentVehicleSelection];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    @try {
        [self.search removeObserver:self forKeyPath:@"vehicleAvailability"];
    } @catch (NSException *exception) {
        //do nothing
    }
    [self hideDetailedPriceSummary];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateNavigationBar];
        [self presentVehicleSelection];
        [self.vehicleSelectionView scrollToTop];
    });
}

- (void)setupViews
{
    _filterViewController = [CTFilterViewController initInViewController:self withData:self.search.vehicleAvailability];
    self.filterViewController.delegate = self;
    
    _vehicleDetailsView = [CTVehicleInfoView new];
    self.vehicleDetailsView.search = self.search;
    self.vehicleDetailsView.cartrawlerAPI = self.cartrawlerAPI;
    self.vehicleDetailsView.delegate = self;
    
    _vehicleSelectionView = [CTVehicleSelectionView new];
    self.vehicleSelectionView.delegate = self;
    
}

- (void)presentVehicleDetails
{
    [UIView animateWithDuration:0.2 animations:^{
        self.vehicleDetailsView.alpha = 1;
        self.vehicleSelectionView.alpha = 0;
    } completion:nil];
    
    _presentedView = CTPresentedViewDetails;
    [self.vehicleSelectionView removeFromSuperview];
    [self.containerView addSubview:self.vehicleDetailsView];
    [CTLayoutManager pinView:self.vehicleDetailsView toSuperView:self.containerView padding:UIEdgeInsetsZero];
    [self.vehicleDetailsView refreshView];
    [self updateNavigationBar];
    [self updatePriceSummary:NO];
    [self updateDetailedPriceSummary];
}

- (void)presentVehicleSelection
{
    if (self.presentedView != CTPresentedViewSelection) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.vehicleDetailsView.alpha = 0;
            self.vehicleSelectionView.alpha = 1;
        } completion:nil];
        
        _presentedView = CTPresentedViewSelection;
        [self.vehicleDetailsView removeFromSuperview];
        [self.containerView addSubview:self.vehicleSelectionView];
        [CTLayoutManager pinView:self.vehicleSelectionView toSuperView:self.containerView padding:UIEdgeInsetsZero];
    }
    [self updateSortButtonByPrice:YES];
    [self.vehicleSelectionView updateSelection:self.search.vehicleAvailability.items pickupDate:self.search.pickupDate dropoffDate:self.search.dropoffDate sortByPrice:YES];
    [self updateNavigationBar];
}

- (void)updateNavigationBar
{
    
    if (self.search.pickupLocation == self.search.dropoffLocation) {
        self.locationLabel.text = [NSString stringWithFormat:@"%@", self.search.pickupLocation.name];
    } else {
        self.locationLabel.text = [NSString stringWithFormat:@"%@\n- to -\n%@",
                                   self.search.pickupLocation.name, self.search.dropoffLocation.name];
    }
    
    NSString *pickupDate = [self.search.pickupDate stringFromDateWithFormat:@"dd MMM, hh:mm a"];
    NSString *dropoffDate = [self.search.dropoffDate stringFromDateWithFormat:@"dd MMM, hh:mm a"];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@", pickupDate, dropoffDate];

    
    if (self.presentedView == CTPresentedViewDetails) {
        [self.leftButton setTitle:CTLocalizedString(CTRentalResultsOtherCars) forState:UIControlStateNormal];
        [self.rightButton setTitle:CTLocalizedString(CTRentalCarRentalTotal) forState:UIControlStateNormal];
    } else {
        [self.leftButton setTitle:CTLocalizedString(CTRentalResultsFilter) forState:UIControlStateNormal];
        [self.rightButton setTitle:CTLocalizedString(CTRentalResultsSort) forState:UIControlStateNormal];
    }
}

- (IBAction)dismiss:(id)sender
{
    self.search.selectedVehicle = nil;
    [self dismiss];
}

- (IBAction)search:(id)sender
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:CTRentalSearchStoryboard bundle:bundle];
    CTSearchDetailsViewController *searchViewController = [storyboard instantiateViewControllerWithIdentifier:CTRentalSearchViewIdentifier];
    searchViewController.cartrawlerAPI = self.cartrawlerAPI;
    searchViewController.search = self.search;
    searchViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:searchViewController animated:YES completion:nil];
}

- (IBAction)leftTap:(id)sender
{
    if (self.presentedView == CTPresentedViewSelection) {
        [self.filterViewController present];
    } else {
        [self presentVehicleSelection];
    }
}

- (IBAction)rightTap:(id)sender
{
    if (self.presentedView == CTPresentedViewSelection) {
        NSString *sortResults = CTLocalizedString(CTRentalSortTitle);
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:sortResults
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        
        NSString *sortPrice = CTLocalizedString(CTRentalSortPrice);
        UIAlertAction *lowestPrice = [UIAlertAction actionWithTitle:sortPrice
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    [self updateSortButtonByPrice:YES];
                                                                    [self.vehicleSelectionView sortByPrice:YES];
                                                                });
                                                            }];
        
        NSString *sortRecommended = CTLocalizedString(CTRentalSortRecommended);
        UIAlertAction *recommendedVehicles = [UIAlertAction actionWithTitle:sortRecommended
                                                                      style:UIAlertActionStyleDefault
                                                                    handler:^(UIAlertAction * action) {
                                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                            [self updateSortButtonByPrice:NO];
                                                                            [self.vehicleSelectionView sortByPrice:NO];
                                                                        });
                                                                    }];
        NSString *cancelString = CTLocalizedString(CTRentalCTACancel);
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelString style:UIAlertActionStyleCancel
                                                       handler:nil];
        
        [alert addAction:lowestPrice];
        [alert addAction:recommendedVehicles];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    if (self.presentedView == CTPresentedViewDetails) {
            [self showDetailedPriceSummary];
    }
    
}

- (void)updatePriceSummary:(BOOL)isBuyingInsurance
{
    NSString *price = @"";
    
    if (isBuyingInsurance) {
        price = [[NSNumber numberWithFloat:self.search.selectedVehicle.vehicle.totalPriceForThisVehicle.floatValue + self.search.insurance.premiumAmount.floatValue] numberStringWithCurrencyCode];
    } else {
        price = [self.search.selectedVehicle.vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode];
    }
    
    
    NSAttributedString *priceString = [NSString attributedText:CTLocalizedString(CTRentalCarRentalTotal)
                                                    boldColor:[UIColor whiteColor]
                                                     boldSize:17
                                                  regularText:price
                                                 regularColor:[UIColor whiteColor]
                                                  regularSize:17
                                                     useSpace:YES];
    
    [self.rightButton setAttributedTitle:priceString forState:UIControlStateNormal];
}

- (void)updateDetailedPriceSummary
{
    [self.summaryView updateWithSearch:self.search];
    self.summaryViewHeightConstraint.constant = self.summaryView.desiredHeight;
    self.summaryViewTopConstraint.constant = -self.summaryView.desiredHeight;
    [self.view layoutIfNeeded];
}

- (void)showDetailedPriceSummary
{
    [self updateDetailedPriceSummary];
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
    [self hideDetailedPriceSummary];
}

- (void)updateSortButtonByPrice:(BOOL)sortByPrice
{
    NSAttributedString *sortString = [NSString attributedText:CTLocalizedString(CTRentalSortTitle)
                                                    boldColor:[UIColor whiteColor]
                                                     boldSize:17
                                                  regularText:sortByPrice ? CTLocalizedString(CTRentalSortPrice) : CTLocalizedString(CTRentalSortRecommended)
                                                 regularColor:[UIColor whiteColor]
                                                  regularSize:17
                                                     useSpace:YES];
    
    [self.rightButton setAttributedTitle:sortString forState:UIControlStateNormal];
}

//MARK: CTFilterDelegate
- (void)filterDidUpdate:(NSArray<CTAvailabilityItem *> *)filteredData
{
    [self.vehicleSelectionView updateSelection:filteredData
                                    pickupDate:self.search.pickupDate
                                   dropoffDate:self.search.dropoffDate
                                   sortByPrice:YES];
}

//MARK: CTVehicleSelectionViewDelegate

- (void)didSelectVehicle:(CTAvailabilityItem *)item
{
    self.search.selectedVehicle = item;
    [self presentVehicleDetails];
}

//MARK: CTVehicleInfoDelegate

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
    [self presentVehicleSelection];
}

- (void)infoViewAddInsuranceTapped:(BOOL)didAddInsurance
{
    [self updatePriceSummary:didAddInsurance];
}

- (void)infoViewPushToNextStep
{
    if (self.navigationController.viewControllers.firstObject == self) {
        [self dismiss];
    } else {
        [self pushToDestination];
    }
}

@end
