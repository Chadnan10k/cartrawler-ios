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

@interface CTVehicleSelectionViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet CTVehicleSelectionView *vehicleSelectionView;
@property (weak, nonatomic) IBOutlet UILabel *locationsLabel;
@property (weak, nonatomic) IBOutlet CTLabel *datesLabel;
@property (weak, nonatomic) IBOutlet CTLabel *carCountLabel;
@property (weak, nonatomic) IBOutlet UIView *subheaderView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

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
    
    [self.search addObserver:self forKeyPath:@"vehicleAvailability"
                     options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                     context:nil];
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
    [[CTAnalytics instance] tagScreen:@"Step" detail:@"vehicles" step:@2];
    [self produceHeaderText];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.search.vehicleAvailability.items.count < 1) {
        [CTInterstitialViewController present:self search:self.search];
    }
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
                               ,NSLocalizedString(@"results", @"results")];
}

- (IBAction)backTapped:(id)sender {
    if (self.navigationController.viewControllers.firstObject == self) {
        //present the search details view modally
        [self backToSearchModally];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)filterTapped:(id)sender {
    [self.filterViewController present];
}

- (void)backToSearchModally
{
    [self.navigationController setViewControllers:[NSArray arrayWithObjects:self.optionalRoute,self,nil]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sortVehicles:(BOOL)byPrice
{
    _sortingByPrice = byPrice;
    [self.vehicleSelectionView updateSelection:self.filteredData ?: self.search.vehicleAvailability.items
                                   sortByPrice:self.sortingByPrice];
}
    
- (IBAction)sortTapped:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sort results"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *lowestPrice = [UIAlertAction actionWithTitle:@"Lowest Price" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self sortVehicles:YES];
                                                          }];
    UIAlertAction *recommendedVehicles = [UIAlertAction actionWithTitle:@"Recommended Vehicles" style:UIAlertActionStyleDefault
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

- (void)refreshFromOTA
{
    self.search.vehicleAvailability = nil;
    __weak typeof(self) weakSelf = self;
    [self.cartrawlerAPI requestVehicleAvailabilityForLocation:self.search.pickupLocation.code
                                           returnLocationCode:self.search.dropoffLocation.code
                                          customerCountryCode:[CTSDKSettings instance].homeCountryCode
                                                 passengerQty:self.search.passengerQty
                                                    driverAge:self.search.driverAge
                                               pickUpDateTime:self.search.pickupDate
                                               returnDateTime:self.search.dropoffDate
                                                 currencyCode:[CTSDKSettings instance].currencyCode
                                                   completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                                                       if (response) {
                                                           weakSelf.search.vehicleAvailability = response;
                                                       } else if (error) {
                                                           [[CTAnalytics instance] tagError:@"Vehicle selection"
                                                                                      event:@" in path country change OTA avail"
                                                                                    message:error.errorMessage];
                                                       }
                                            }];
}

@end
