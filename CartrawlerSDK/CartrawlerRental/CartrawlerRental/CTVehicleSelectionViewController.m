//
//  ViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleSelectionViewController.h"
#import <CartrawlerAPI/CartrawlerAPI.h>
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CartrawlerSDK+NSDateUtils.h>
#import "CTFilterViewController.h"
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTSDKSettings.h>
#import "CTSearchDetailsViewController.h"
#import "CTInterstitialViewController.h"
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CTButton.h>

@interface CTVehicleSelectionViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet CTVehicleSelectionView *vehicleSelectionView;
@property (weak, nonatomic) IBOutlet UILabel *locationsLabel;
@property (weak, nonatomic) IBOutlet CTLabel *datesLabel;
@property (weak, nonatomic) IBOutlet CTLabel *carCountLabel;
@property (weak, nonatomic) IBOutlet UIView *subheaderView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet CTButton *sortButton;
@property (weak, nonatomic) IBOutlet CTButton *filterButton;

@property (nonatomic, strong) CTFilterViewController *filterViewController;
@property (nonatomic, strong) NSArray<CTAvailabilityItem *> *filteredData;
    
@property (nonatomic, assign) BOOL lastScrollDirection;
@property (nonatomic, assign) BOOL sortingByPrice;

#pragma MARK ScrollView

@end

@implementation CTVehicleSelectionViewController {
    BOOL viewLoaded;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof (self) weakSelf = self;

    [self.vehicleSelectionView initWithVehicleAvailability:self.search.vehicleAvailability.items completion:^(CTAvailabilityItem *vehicle) {
        self.search.selectedVehicle = vehicle;
        [self pushToDestination];
    }];
    
    _filterViewController = [CTFilterViewController initInViewController:self
                                                                withData:self.search.vehicleAvailability];
    
    self.filterViewController.filterCompletion = ^(NSArray<CTAvailabilityItem *> *filteredData) {
        weakSelf.filteredData = filteredData;
        [weakSelf.vehicleSelectionView updateSelection:filteredData sortByPrice:weakSelf.sortingByPrice];
        [weakSelf updateAvailableCarsLabel:filteredData.count];
    };
    
    [self updateAvailableCarsLabel:self.search.vehicleAvailability.items.count];
    
    self.subheaderView.backgroundColor = [CTAppearance instance].iconTint;
    
    
    [self.sortButton setTitle:CTLocalizedString(CTRentalResultsSort) forState:UIControlStateNormal];
    [self.filterButton setTitle:CTLocalizedString(CTRentalResultsFilter) forState:UIControlStateNormal];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self refresh];
    });
    [CTInterstitialViewController dismiss];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self tagScreen];
    [self produceHeaderText];
    [self.search addObserver:self forKeyPath:@"vehicleAvailability"
                     options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                     context:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.search.vehicleAvailability.items.count < 1) {
        [CTInterstitialViewController present:self search:self.search];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //is there results?
            if (self.search.vehicleAvailability.items.count < 1) {
                [CTInterstitialViewController dismiss];
                [self backToSearch];
            }
        });
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.search removeObserver:self forKeyPath:@"vehicleAvailability"];
}

- (void)showText:(BOOL)show
{
    if (show != self.lastScrollDirection) {
        if (show) {
            [self produceHeaderText];
        } else {
            self.locationsLabel.text = @"";
        }
        _lastScrollDirection = show;
    }
    
    NSString *pickupDate = [self.search.pickupDate stringFromDate:@"dd MMM, hh:mm a"];
    NSString *dropoffDate = [self.search.dropoffDate stringFromDate:@"dd MMM, hh:mm a"];
    
    self.datesLabel.text = [NSString stringWithFormat:@"%@ - %@", pickupDate, dropoffDate];
}

- (void)produceHeaderText
{
    if (self.search.pickupLocation == self.search.dropoffLocation) {
        self.locationsLabel.text = [NSString stringWithFormat:@"%@", self.search.pickupLocation.name];
    } else {
        self.locationsLabel.text = [NSString stringWithFormat:@"%@\n- to -\n%@",
                                    self.search.pickupLocation.name, self.search.dropoffLocation.name];
    }
    
    NSString *pickupDate = [self.search.pickupDate stringFromDate:@"dd MMM, hh:mm a"];
    NSString *dropoffDate = [self.search.dropoffDate stringFromDate:@"dd MMM, hh:mm a"];
    
    self.datesLabel.text = [NSString stringWithFormat:@"%@ - %@", pickupDate, dropoffDate];
}

- (void)refresh
{
    if (self.filterViewController) {
        [self.filterViewController updateData:self.search.vehicleAvailability];
    }
    
    [self.vehicleSelectionView updateSelection:self.search.vehicleAvailability.items sortByPrice:self.sortingByPrice];

    [self updateAvailableCarsLabel:self.search.vehicleAvailability.items.count];
}

- (void)updateAvailableCarsLabel:(NSInteger)availableCars
{
    self.carCountLabel.text = [NSString stringWithFormat:@"%ld %@", (unsigned long)availableCars
                               ,CTLocalizedString(CTRentalTitleResults)];
}

- (IBAction)backTapped:(id)sender {
    if (self.navigationController.viewControllers.firstObject == self) {
        //present the search details view modally
        [self backToSearch];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)filterTapped:(id)sender {
    [self.filterViewController present];
}

- (void)backToSearch
{
    [self.navigationController setViewControllers:[NSArray arrayWithObjects:self.optionalRoute,self,nil]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sortVehicles:(BOOL)byPrice
{
    _sortingByPrice = byPrice;
    if (self.filteredData.count > 0) {
        [self.vehicleSelectionView updateSelection:self.filteredData
                                       sortByPrice:self.sortingByPrice];
    } else {
        [self.vehicleSelectionView updateSelection:self.search.vehicleAvailability.items
                                       sortByPrice:self.sortingByPrice];
    }
}
    
- (IBAction)sortTapped:(id)sender {
    NSString *sortResults = CTLocalizedString(CTRentalSortTitle);
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:sortResults
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSString *sortPrice = CTLocalizedString(CTRentalSortPrice);
    UIAlertAction *lowestPrice = [UIAlertAction actionWithTitle:sortPrice
                                                          style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self sortVehicles:YES];
                                                          }];
    
    NSString *sortRecommended = CTLocalizedString(CTRentalSortRecommended);
    UIAlertAction *recommendedVehicles = [UIAlertAction actionWithTitle:sortRecommended
                                                                  style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self sortVehicles:NO];
                                                          }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                                handler:nil];
    
    [alert addAction:lowestPrice];
    [alert addAction:recommendedVehicles];
    [alert addAction:cancel];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark analyitics
- (void)tagScreen
{
    [self sendEvent:NO customParams:@{@"eventName" : @"Vehicle Selection Step",
                                      @"stepName" : @"Step2",
                                      @"age" : self.search.driverAge.stringValue,
                                      @"clientID" : [CTSDKSettings instance].clientId,
                                      @"residenceID" : [CTSDKSettings instance].homeCountryCode,
                                      @"pickupID" : self.search.pickupLocation.code,
                                      @"pickupName" : self.search.pickupLocation.name,
                                      @"pickupDate" : [self.search.pickupDate stringFromDateWithFormat:@"dd/MM/yyyy"],
                                      @"pickupTime" : [self.search.pickupDate stringFromDateWithFormat:@"HH:mm"],
                                      @"pickupCountry" : self.search.pickupLocation.countryCode,
                                      @"returnID" : self.search.dropoffLocation.code,
                                      @"returnName" : self.search.dropoffLocation.name,
                                      @"returnDate" : [self.search.dropoffDate stringFromDateWithFormat:@"dd/MM/yyyy"],
                                      @"returnTime" : [self.search.dropoffDate stringFromDateWithFormat:@"HH:mm"],
                                      @"returnCountry" : self.search.dropoffLocation.countryCode,
                                      @"currency" : [CTSDKSettings instance].homeCountryCode
                                      } eventName:@"Step of search" eventType:@"Step"];
    [[CTAnalytics instance] tagScreen:@"step" detail:@"vehicles" step:@2];
}

@end
