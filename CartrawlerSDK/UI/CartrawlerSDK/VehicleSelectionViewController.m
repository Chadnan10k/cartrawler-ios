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
#import "DateUtils.h"
#import "CTFilterViewController.h"

@interface VehicleSelectionViewController ()

@property (weak, nonatomic) IBOutlet CTVehicleSelectionView *vehicleSelectionView;
@property (weak, nonatomic) IBOutlet UILabel *locationsLabel;
@property (weak, nonatomic) IBOutlet CTLabel *datesLabel;
@property (weak, nonatomic) IBOutlet CTLabel *carCountLabel;

@property (nonatomic, strong) CTFilterViewController *filterViewController;

@end

@implementation VehicleSelectionViewController {
    BOOL viewLoaded;
}

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.carCountLabel.text = [NSString stringWithFormat:@"%ld %@", (unsigned long)self.search.vehicleAvailability.items.count,
                               NSLocalizedString(@"cars available", @"cars available")];
    __weak typeof (self) weakSelf = self;

    _filterViewController = [CTFilterViewController initInViewController:self withData:self.search.vehicleAvailability];
    
    self.filterViewController.filterCompletion = ^(NSArray<CTAvailabilityItem *> *filteredData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.vehicleSelectionView initWithVehicleAvailability:filteredData completion:^(CTAvailabilityItem *vehicle) {
                weakSelf.search.selectedVehicle = vehicle;
                [weakSelf pushToDestination];
            }];
            
            weakSelf.carCountLabel.text = [NSString stringWithFormat:@"%ld %@", (unsigned long)filteredData.count
                                           ,NSLocalizedString(@"cars available", @"cars available")];
        });
    };
    
    [self.vehicleSelectionView initWithVehicleAvailability:self.search.vehicleAvailability.items completion:^(CTAvailabilityItem *vehicle) {
        self.search.selectedVehicle = vehicle;
       [self pushToDestination];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    __weak typeof (self) weakSelf = self;
    if (viewLoaded) {
        self.carCountLabel.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"Getting latest vehicles", @"Getting latest vehicles")];
        [self.vehicleSelectionView showLoading];
        [self.search refreshResults:^(BOOL success, NSString *errorMessage) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.vehicleSelectionView hideLoading];
                    [weakSelf refresh];
                });
            } else {
                //could not refresh
            }
        }];
    } else {
        viewLoaded = YES;
    }
    
    if (self.search.pickupLocation == self.search.dropoffLocation) {
        self.locationsLabel.text = [NSString stringWithFormat:@"%@", self.search.pickupLocation.name];
    } else {
        self.locationsLabel.text = [NSString stringWithFormat:@"%@\n- to -\n%@",
                                    self.search.pickupLocation.name, self.search.dropoffLocation.name];
    }
    
    
    NSString *pickupDate = [DateUtils shortDescriptionFromDate:self.search.pickupDate];
    NSString *dropoffDate = [DateUtils shortDescriptionFromDate:self.search.dropoffDate];
    
    self.datesLabel.text = [NSString stringWithFormat:@"%@ - %@", pickupDate, dropoffDate];
}

- (void)refresh
{
    self.carCountLabel.text = [NSString stringWithFormat:@"%ld %@", (unsigned long)self.search.vehicleAvailability.items.count,
                               NSLocalizedString(@"cars available", @"cars available")];
    
    [self.filterViewController setFilterData:self.search.vehicleAvailability];
}

- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)filterTapped:(id)sender {
    [self.filterViewController present];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
