//
//  GroundServicesViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 14/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GroundServicesViewController.h"
#import "GTServiceTableViewCell.h"
#import "InclusionCollectionViewDataSource.h"
#import "GTShuttleTableViewCell.h"
#import "FilterCollectionViewDataSource.h"

@interface GroundServicesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) CTGroundAvailability *availability;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *filterCollectionView;

@property (strong, nonatomic) InclusionCollectionViewDataSource *inclusionDataSource;
@property (strong, nonatomic) FilterCollectionViewDataSource *filterDataSource;

@property (nonatomic) GTFilterType selectedFilterType;
@end

@implementation GroundServicesViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _selectedFilterType = GTFilterTypeNone;
    _availability = self.groundSearch.availability;
    _filterDataSource.avail = self.availability;
    [self.filterCollectionView reloadData];
    [self.tableView reloadData];
    
//    NSIndexPath* top = [NSIndexPath indexPathForRow:NSNotFound inSection:0];
//    [self.tableView scrollToRowAtIndexPath:top atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _inclusionDataSource = [[InclusionCollectionViewDataSource alloc] init];
    _filterDataSource = [[FilterCollectionViewDataSource alloc] init];
    _filterDataSource.avail = self.groundSearch.availability;
    
    self.filterCollectionView.dataSource = self.filterDataSource;
    self.filterCollectionView.delegate = self.filterDataSource;
    [self.filterCollectionView reloadData];
    
    __weak typeof (self) weakSelf = self;
    
    self.filterDataSource.selectedFilter = ^(GTFilterType selectedFilter) {
        weakSelf.selectedFilterType = selectedFilter;
        [weakSelf.tableView reloadData];
    };
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 500;
    
    [self.tableView setNeedsLayout];
    [self.tableView layoutIfNeeded];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark TABLE VIEW

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (self.selectedFilterType) {
        case GTFilterTypeService:
            if (section == 1) {
                return self.availability.services.count;
            } else {
                return 0;
            }
            break;
        case GTFilterTypeShuttle:
            if (section == 1) {
                return 0;
            } else {
                return self.availability.shuttles.count;
            }
            break;
        default:
            if (section == 1) {
                return self.availability.services.count;
            } else {
                return self.availability.shuttles.count;
            }
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        GTServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"service"];
        [cell setService:self.availability.services[indexPath.row]];
        return cell;

    } else {
        GTShuttleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shuttle"];
        [cell setShuttle:self.availability.shuttles[indexPath.row]];
        [cell layoutIfNeeded];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        self.groundSearch.selectedService = self.availability.services[indexPath.row];
        self.groundSearch.selectedShuttle = nil;
    } else {
        self.groundSearch.selectedShuttle = self.availability.shuttles[indexPath.row];
        self.groundSearch.flightNumber = nil;
        self.groundSearch.selectedService = nil;
    }
    [self pushToDestination];
}

@end
