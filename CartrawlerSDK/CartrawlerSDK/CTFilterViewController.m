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
#import "CTTableView.h"

@interface CTFilterViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet CTTableView *carSizeTableView;
@property (weak, nonatomic) IBOutlet CTTableView *pickupLocationTableView;
@property (weak, nonatomic) IBOutlet CTTableView *vendorsTableView;
@property (weak, nonatomic) IBOutlet CTTableView *fuelPolicyTableView;
@property (weak, nonatomic) IBOutlet CTTableView *transmissionTableView;
@property (weak, nonatomic) IBOutlet CTTableView *carSpecsTableView;

@property (strong, nonatomic) CTFilterDataSource *carSizeDataSource;
@property (strong, nonatomic) CTFilterDataSource *locationDataSource;
@property (strong, nonatomic) CTFilterDataSource *vendorsDataSource;
@property (strong, nonatomic) CTFilterDataSource *fuelPolicyDataSource;
@property (strong, nonatomic) CTFilterDataSource *transmissionDataSource;

@property (strong, nonatomic) NSMutableArray<CTVehicle *> *sizeData;
@property (strong, nonatomic) NSMutableArray *locationData;
@property (strong, nonatomic) NSMutableArray<CTVendor *> *vendorsData;
@property (strong, nonatomic) NSMutableArray<CTVehicle *> *transmissionData;
@property (strong, nonatomic) NSMutableArray<CTVehicle *> *carSpecsData;
@property (strong, nonatomic) NSMutableArray<CTVehicle *> *fuelPolicyData;

@property (strong, nonatomic) NSMutableArray<CTVehicle *> *filteredData;

@property (strong, nonatomic) NSArray<CTVehicle *> *selectedSizeData;
@property (strong, nonatomic) NSArray<CTVehicle *> *selectedFuelPolicyData;
@property (strong, nonatomic) NSArray<CTVehicle *> *selectedTransmissionData;
@property (strong, nonatomic) NSArray<CTVehicle *> *selectedCarSpecsData;
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
    
    _carSizeDataSource = [[CTFilterDataSource alloc] initWithData:self.sizeData
                                                     selectedData:self.selectedSizeData
                                                       filterType:FilterDataTypeVehicleSize];
    
    _locationDataSource = [[CTFilterDataSource alloc] initWithData:@[@"At Airport"]
                                                      selectedData:self.selectedLocationData
                                                        filterType:FilterDataTypeLocation];
    
    _vendorsDataSource = [[CTFilterDataSource alloc] initWithData:self.vendorsData
                                                     selectedData:self.selectedVendorsData
                                                       filterType:FilterDataTypeVendor];

    _fuelPolicyDataSource = [[CTFilterDataSource alloc] initWithData:self.fuelPolicyData
                                                        selectedData:self.selectedFuelPolicyData
                                                          filterType:FilterDataTypeFuelPolicy];

    _transmissionDataSource = [[CTFilterDataSource alloc] initWithData:self.transmissionData
                                                        selectedData:self.selectedTransmissionData
                                                          filterType:FilterDataTypeTransmission];

    self.carSizeTableView.dataSource = self.carSizeDataSource;
    self.carSizeTableView.delegate = self.carSizeDataSource;
    self.pickupLocationTableView.dataSource = self.locationDataSource;
    self.pickupLocationTableView.delegate = self.locationDataSource;
    self.vendorsTableView.dataSource = self.vendorsDataSource;
    self.vendorsTableView.delegate = self.vendorsDataSource;
    self.fuelPolicyTableView.dataSource = self.fuelPolicyDataSource;
    self.fuelPolicyTableView.delegate = self.fuelPolicyDataSource;
    self.transmissionTableView.dataSource = self.transmissionDataSource;
    self.transmissionTableView.delegate = self.transmissionDataSource;
    
    [self.carSizeTableView reloadData];
    [self.pickupLocationTableView reloadData];
    [self.vendorsTableView reloadData];
    [self.fuelPolicyTableView reloadData];
    [self.transmissionTableView reloadData];

    self.carSizeDataSource.filterCompletion = ^(NSArray<CTVehicle *> *filteredData){
        _selectedSizeData = filteredData;
    };
    
    self.locationDataSource.filterCompletion = ^(NSArray *filteredData){
        _selectedLocationData = filteredData;
    };
    
    self.vendorsDataSource.filterCompletion = ^(NSArray<CTVendor *> *filteredData){
        _selectedVendorsData = filteredData;
    };
    
    self.fuelPolicyDataSource.filterCompletion = ^(NSArray<CTVehicle *> *filteredData){
        _selectedFuelPolicyData = filteredData;
    };
    
    self.transmissionDataSource.filterCompletion = ^(NSArray<CTVehicle *> *filteredData){
        _selectedTransmissionData = filteredData;
    };
    
    //
}

- (void)setFilterData:(CTVehicleAvailability *)data
{
    _data = data;
    _selectedVendorsData = [[NSMutableArray alloc] init];
    _selectedLocationData = [[NSMutableArray alloc] init];
    _selectedSizeData = [[NSMutableArray alloc] init];
    _selectedFuelPolicyData = [[NSMutableArray alloc] init];

    _sizeData = [[NSMutableArray alloc] init];
    _locationData = [[NSMutableArray alloc] init];
    _vendorsData = [[NSMutableArray alloc] init];
    _transmissionData = [[NSMutableArray alloc] init];
    _carSpecsData = [[NSMutableArray alloc] init];
    _fuelPolicyData = [[NSMutableArray alloc] init];

    //vehicle size
    for (CTVehicle *v in data.allVehicles) {
        BOOL found = NO;
        for (CTVehicle *s in self.sizeData) {
            if ([v.categoryDescriptionCode isEqualToString: s.categoryDescriptionCode]) {
                found = YES;
            }
        }
        if (!found) {
            [self.sizeData addObject:v];
        }
    }
    //vendors
    for (int i = 0; i < data.availableVendors.count; ++i) {
        
        BOOL found = NO;
        for (int x = 0; x < self.vendorsData.count; ++x) {
            if ([data.availableVendors[i].name isEqualToString:self.vendorsData[x].name]) {
                found = YES;
            } else {
                found = NO;
            }
        }
        if (!found) {
            [self.vendorsData addObject:data.availableVendors[i]];
        }
    }
    //vehicle size
    for (CTVehicle *v in data.allVehicles) {
        BOOL found = NO;
        for (CTVehicle *s in self.transmissionData) {
            if ([v.transmissionType isEqualToString: s.transmissionType]) {
                found = YES;
            }
        }
        if (!found) {
            [self.transmissionData addObject:v];
        }
    }
    
    //fuel policy
    for (CTVehicle *v in data.allVehicles) {
        BOOL found = NO;
        for (CTVehicle *s in self.fuelPolicyData) {
            if (v.fuelPolicy == s.fuelPolicy) {
                found = YES;
            }
        }
        if (!found) {
            [self.fuelPolicyData addObject:v];
        }
    }
    
    //transmission
    for (CTVehicle *v in data.allVehicles) {
        BOOL found = NO;
        for (CTVehicle *s in self.transmissionData) {
            if ([v.transmissionType isEqualToString: s.transmissionType]) {
                found = YES;
            }
        }
        if (!found) {
            [self.transmissionData addObject:v];
        }
    }
}

- (void)buildTableViews
{

    NSArray <CTTableView *>*viewArray;
    
    for (int i = 0; i < viewArray.count; ++i) {
        CGFloat height = viewArray[i].contentSize.height;
        
        if (i == 0) {
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.view
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0
                                                                              constant:40];
            
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:height];
            
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.view
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:5];
            
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0
                                                                                constant:-5];
            [self.view addConstraints:@[topConstraint,
                                        leftConstraint,
                                        rightConstraint,
                                        heightConstraint]];
            
            [self.view updateConstraints];
            
        } else {
            
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:viewArray[i-1]
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:5];
            
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:height];
            
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.view
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:5];
            
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0
                                                                                constant:-5];
            [self.view addConstraints:@[topConstraint,
                                        leftConstraint,
                                        rightConstraint,
                                        heightConstraint]];
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
            
            if ([veh.categoryDescriptionCode isEqualToString:selectedVeh.categoryDescriptionCode]) {
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
                if ([ven.name isEqualToString:veh.vendor.name]) {
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
                if ([ven.name isEqualToString:veh.vendor.name]) {
                    if (![vehsToAddStep2 containsObject:veh]) {
                        [vehsToAddStep2 addObject:veh];
                    }
                }
            }
        }
    }
    
    //fuel policy
    NSMutableArray *vehsToAddStep3 = [[NSMutableArray alloc] init];
    if (self.selectedFuelPolicyData.count == 0) {
        vehsToAddStep3 = vehsToAddStep2;
    } else {
        for (CTVehicle *veh in vehsToAddStep2) {
            for (CTVehicle *selectedVeh in self.selectedFuelPolicyData) {
                BOOL found = NO;
                
                if (veh.fuelPolicy == selectedVeh.fuelPolicy) {
                    found = YES;
                }
                
                if (found) {
                    if (![vehsToAddStep3 containsObject:veh]) {
                        [vehsToAddStep3 addObject:veh];
                    }
                }
            }
        }
    }
    
    //transmission
    NSMutableArray *vehsToAddStep4 = [[NSMutableArray alloc] init];
    if (self.selectedTransmissionData.count == 0) {
        vehsToAddStep4 = vehsToAddStep3;
    } else {
        for (CTVehicle *veh in vehsToAddStep3) {
            for (CTVehicle *selectedVeh in self.selectedTransmissionData) {
                BOOL found = NO;
                
                if ([veh.transmissionType isEqualToString: selectedVeh.transmissionType]) {
                    found = YES;
                }
                
                if (found) {
                    if (![vehsToAddStep4 containsObject:veh]) {
                        [vehsToAddStep4 addObject:veh];
                    }
                }
            }
        }
    }
    
    _filteredData = [[NSMutableArray alloc] initWithArray:vehsToAddStep4];
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
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
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
