//
//  CTFilterViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTFilterViewController.h"
#import "CTFilterDataSource.h"
#import <CartrawlerAPI/CTFilter.h>
 
@interface CTFilterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *carSizeTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *carSizeHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *pickupLocationTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickupLocationConstraint;
@property (weak, nonatomic) IBOutlet UITableView *vendorsTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vendorsConstraint;

@property (strong, nonatomic) CTFilterDataSource *carSizeDataSource;
@property (strong, nonatomic) CTFilterDataSource *locationDataSource;
@property (strong, nonatomic) CTFilterDataSource *vendorsDataSource;

@property (strong, nonatomic) NSMutableArray<CTVehicle *> *sizeData;
@property (strong, nonatomic) NSMutableArray *locationData;
@property (strong, nonatomic) NSMutableArray<CTVendor *> *vendorsData;

@property (strong, nonatomic) NSMutableArray<CTVehicle *> *filteredData;

@property (strong, nonatomic) NSArray<CTVehicle *> *selectedSizeData;
@property (strong, nonatomic) NSArray *selectedLocationData;
@property (strong, nonatomic) NSArray<CTVendor *> *selectedVendorsData;
@property (strong, nonatomic) CTVehicleAvailability *data;

@property (strong, nonatomic) UIViewController *parentViewContoller;

@end

@implementation CTFilterViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _filteredData = [[NSMutableArray alloc] init];
    
    _carSizeDataSource = [[CTFilterDataSource alloc] initWithData:self.sizeData selectedData:self.selectedSizeData];
    _locationDataSource = [[CTFilterDataSource alloc] initWithData:@[@"At Airport"] selectedData:self.selectedLocationData];
    _vendorsDataSource = [[CTFilterDataSource alloc] initWithData:self.vendorsData selectedData:self.selectedVendorsData];

    self.carSizeTableView.layer.cornerRadius = 5;
    self.pickupLocationTableView.layer.cornerRadius = 5;
    self.vendorsTableView.layer.cornerRadius = 5;

    self.carSizeTableView.dataSource = self.carSizeDataSource;
    self.carSizeTableView.delegate = self.carSizeDataSource;
    self.pickupLocationTableView.dataSource = self.locationDataSource;
    self.pickupLocationTableView.delegate = self.locationDataSource;
    self.vendorsTableView.dataSource = self.vendorsDataSource;
    self.vendorsTableView.delegate = self.vendorsDataSource;
    
    [self.carSizeTableView reloadData];
    [self.pickupLocationTableView reloadData];
    [self.vendorsTableView reloadData];

    self.carSizeHeightConstraint.constant = self.carSizeTableView.contentSize.height-1;
    self.pickupLocationConstraint.constant = self.pickupLocationTableView.contentSize.height-1;
    self.vendorsConstraint.constant = self.vendorsTableView.contentSize.height-1;
    
    self.carSizeDataSource.filterCompletion = ^(NSArray<CTVehicle *> *filteredData){
        _selectedSizeData = filteredData;
    };
    
    self.locationDataSource.filterCompletion = ^(NSArray *filteredData){
        _selectedLocationData = filteredData;
    };
    
    self.vendorsDataSource.filterCompletion = ^(NSArray<CTVendor *> *filteredData){
        _selectedVendorsData = filteredData;
    };

}

- (void)setFilterData:(CTVehicleAvailability *)data
{
    _data = data;
    _selectedVendorsData = [[NSMutableArray alloc] init];
    _selectedLocationData = [[NSMutableArray alloc] init];
    _selectedSizeData = [[NSMutableArray alloc] init];

    _sizeData = [[NSMutableArray alloc] init];
    _locationData = [[NSMutableArray alloc] init];
    _vendorsData = [[NSMutableArray alloc] init];
    
    for (CTVehicle *v in data.allVehicles) {
        BOOL found = NO;
        for (CTVehicle *s in self.sizeData) {
            if ([v.vehicleCategory isEqualToString:s.vehicleCategory]) {
                found = YES;
            }
        }
        if (!found) {
            [self.sizeData addObject:v];
        }
    }
    
    for (int i = 0; i < data.availableVendors.count; ++i) {
        
        BOOL found = NO;
        for (int x = 0; x < self.vendorsData.count; ++x) {
            if ([data.availableVendors[i].vendorName isEqualToString:self.vendorsData[x].vendorName]) {
                found = YES;
            } else {
                found = NO;
            }
        }
        if (!found) {
            [self.vendorsData addObject:data.availableVendors[i]];
        }
    }
 
}

- (void)filter
{
    NSMutableArray<CTVehicle *> *filteredData = [[NSMutableArray alloc] init];

    filteredData =  [[NSMutableArray alloc] initWithArray:self.data.allVehicles];
    
    //pick away each car one by one
    NSMutableArray *vehsToAdd = [[NSMutableArray alloc] init];
    
    //car size
    for (CTVehicle *veh in filteredData) {
        for (CTVehicle *selectedVeh in self.selectedSizeData) {
            BOOL found = NO;
            
            if ([veh.vehicleCategory isEqualToString:selectedVeh.vehicleCategory]) {
                found = YES;
            }
            
            if (found) {
                if (![vehsToAdd containsObject:veh]) {
                    [vehsToAdd addObject:veh];
                }
            }
        }
    }
    
    NSMutableArray *vehsToAddStep2;

    //car vendor
    if (self.selectedSizeData.count == 0 && self.selectedVendorsData.count == 0) {
        vehsToAddStep2 = [[NSMutableArray alloc] initWithArray:self.data.allVehicles];
    } else if (self.selectedSizeData.count == 0 && self.selectedVendorsData.count != 0) {
        vehsToAddStep2 = [[NSMutableArray alloc] init];
        for (CTVendor *ven in self.selectedVendorsData) {
            for (CTVehicle *veh in self.data.allVehicles) {
                if ([ven.vendorName isEqualToString:veh.vendor.vendorName]) {
                    if (![vehsToAddStep2 containsObject:veh]) {
                        [vehsToAddStep2 addObject:veh];
                    }
                }
            }
        }
    } else if (self.selectedSizeData.count != 0 && self.selectedVendorsData.count == 0) {
        vehsToAddStep2 = [[NSMutableArray alloc] initWithArray:vehsToAdd];
    } else {
        vehsToAddStep2 = [[NSMutableArray alloc] init];
        for (CTVendor *ven in self.selectedVendorsData) {
            for (CTVehicle *veh in vehsToAdd) {
                if ([ven.vendorName isEqualToString:veh.vendor.vendorName]) {
                    if (![vehsToAddStep2 containsObject:veh]) {
                        [vehsToAddStep2 addObject:veh];
                    }
                }
            }
        }
    }
    _filteredData = [[NSMutableArray alloc] initWithArray:vehsToAddStep2];
    _filteredData = [[NSMutableArray alloc] initWithArray:[CTFilter sortPrice:YES cars:self.filteredData]];
}

+ (CTFilterViewController *)initInViewController:(UIViewController *)viewController withData:(CTVehicleAvailability *)data;
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepTwo" bundle:bundle];
    CTFilterViewController *vc = (CTFilterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CTFilterViewController"];
    [vc setFilterData:data];
    [vc setParentViewContoller:viewController];
    return vc;
}

- (void)present
{
    [self.parentViewContoller presentViewController:self animated:YES completion:nil];
}

- (IBAction)resetTapped:(id)sender {
    _filteredData = [[NSMutableArray alloc] init];
    [self.carSizeDataSource reset];
    [self.locationDataSource reset];
    [self.vendorsDataSource reset];
 
    [self.carSizeTableView reloadData];
    [self.pickupLocationTableView reloadData];
    [self.vendorsTableView reloadData];

}

- (IBAction)doneTapped:(id)sender {
    
    [self filter];
    if (self.filterCompletion) {
        self.filterCompletion(self.filteredData);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
