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

@implementation VehicleSelectionViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof (self) weakSelf = self;
    
    [self.vehicleSelectionView initWithVehicleAvailability:self.vehicleAvailability.allVehicles completion:^(CTVehicle *vehicle) {
        [self pushToStepThree:vehicle];
    }];
    
    _filterViewController = [CTFilterViewController initInViewController:self withData:self.vehicleAvailability];
    self.filterViewController.filterCompletion = ^(NSArray<CTVehicle *> *filteredData) {
        dispatch_async(dispatch_get_main_queue(), ^{

            [weakSelf.vehicleSelectionView initWithVehicleAvailability:filteredData completion:^(CTVehicle *vehicle) {
                [weakSelf pushToStepThree:vehicle];
            }];
            
            weakSelf.carCountLabel.text = [NSString stringWithFormat:@"%ld %@", (unsigned long)filteredData.count
                                           , NSLocalizedString(@"cars available", @"cars available")];
        });
    };
    
    self.locationsLabel.text = [NSString stringWithFormat:@"%@ - %@", self.pickupLocation.name, self.dropoffLocation.name];
    
    NSString *pickupDate = [DateUtils shortDescriptionFromDate:self.pickupDate];
    NSString *dropoffDate = [DateUtils shortDescriptionFromDate:self.dropoffDate];

    self.datesLabel.text = [NSString stringWithFormat:@"%@ - %@", pickupDate, dropoffDate];
    
    self.carCountLabel.text = [NSString stringWithFormat:@"%ld %@", (unsigned long)self.vehicleAvailability.allVehicles.count,
                               NSLocalizedString(@"cars available", @"cars available")];
}

- (void)refresh
{
    [self.vehicleSelectionView initWithVehicleAvailability:self.vehicleAvailability.allVehicles completion:^(CTVehicle *vehicle) {
        [self pushToStepThree:vehicle];
    }];
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
