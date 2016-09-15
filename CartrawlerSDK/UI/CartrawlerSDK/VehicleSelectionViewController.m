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
    
    __weak typeof (self) weakSelf = self;

    [self.vehicleSelectionView initWithVehicleAvailability:self.search.vehicleAvailability.items completion:^(CTAvailabilityItem *vehicle) {
        self.search.selectedVehicle = vehicle;
        [self pushToDestination];
    }];
    
    _filterViewController = [CTFilterViewController initInViewController:self withData:self.search.vehicleAvailability];
    
    self.filterViewController.filterCompletion = ^(NSArray<CTAvailabilityItem *> *filteredData) {
        [weakSelf.vehicleSelectionView updateSelection:filteredData];
        [weakSelf updateAvailableCarsLabel:filteredData.count];
    };
    
    [self updateAvailableCarsLabel:self.search.vehicleAvailability.items.count];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
    if (self.filterViewController) {
        [self.filterViewController updateData:self.search.vehicleAvailability];
    }
    
    [self.vehicleSelectionView updateSelection:self.search.vehicleAvailability.items];

    [self updateAvailableCarsLabel:self.search.vehicleAvailability.items.count];
}

- (void)updateAvailableCarsLabel:(NSInteger)availableCars
{
    self.carCountLabel.text = [NSString stringWithFormat:@"%ld %@", (unsigned long)availableCars
                               ,NSLocalizedString(@"vehicles available", @"cars available")];
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
