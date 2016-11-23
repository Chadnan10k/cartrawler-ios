//
//  ViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "VehicleSelectionViewController.h"
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "CTLabel.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CTFilterViewController.h"

@interface VehicleSelectionViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet CTVehicleSelectionView *vehicleSelectionView;
@property (weak, nonatomic) IBOutlet UILabel *locationsLabel;
@property (weak, nonatomic) IBOutlet CTLabel *datesLabel;
@property (weak, nonatomic) IBOutlet CTLabel *carCountLabel;

@property (nonatomic, strong) CTFilterViewController *filterViewController;
@property (nonatomic, strong) NSArray<CTAvailabilityItem *> *filteredData;
    
@property (nonatomic, assign) BOOL lastScrollDirection;
@property (nonatomic, assign) BOOL sortingByPrice;

#pragma MARK ScrollView

@end

@implementation VehicleSelectionViewController {
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
    
    _filterViewController = [CTFilterViewController initInViewController:self withData:self.search.vehicleAvailability];
    
    self.filterViewController.filterCompletion = ^(NSArray<CTAvailabilityItem *> *filteredData) {
        weakSelf.filteredData = filteredData;
        [weakSelf.vehicleSelectionView updateSelection:filteredData sortByPrice:weakSelf.sortingByPrice];
        [weakSelf updateAvailableCarsLabel:filteredData.count];
    };
    
    [self updateAvailableCarsLabel:self.search.vehicleAvailability.items.count];
    
//    self.vehicleSelectionView.direction = ^(BOOL scrollDirectionUp) {
//        [weakSelf showText:scrollDirectionUp];
//    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *pickupDate = [self.search.pickupDate stringFromDate:@"dd MMM, hh:mm a"];
    NSString *dropoffDate = [self.search.dropoffDate stringFromDate:@"dd MMM, hh:mm a"];
    
    self.datesLabel.text = [NSString stringWithFormat:@"%@ - %@", pickupDate, dropoffDate];
    [self produceHeaderText];
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
}

- (void)produceHeaderText
{
    if (self.search.pickupLocation == self.search.dropoffLocation) {
        self.locationsLabel.text = [NSString stringWithFormat:@"%@", self.search.pickupLocation.name];
    } else {
        self.locationsLabel.text = [NSString stringWithFormat:@"%@\n- to -\n%@",
                                    self.search.pickupLocation.name, self.search.dropoffLocation.name];
    }
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)filterTapped:(id)sender {
    [self.filterViewController present];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
