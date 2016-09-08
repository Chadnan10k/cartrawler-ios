//
//  GroundServicesViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 14/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GroundServicesViewController.h"
#import "GTServiceTableViewCell.h"
#import "InclusionTableViewDataSource.h"
#import "GTShuttleTableViewCell.h"

@interface GroundServicesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) CTGroundAvailability *availability;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) InclusionTableViewDataSource *inclusionDataSource;

@end

@implementation GroundServicesViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _availability = self.groundSearch.availability;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    _inclusionDataSource = [[InclusionTableViewDataSource alloc] init];
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
    if (section == 1) {
        return self.availability.services.count;
    } else {
        return self.availability.shuttles.count;
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
        cell.inclusionDataSource = self.inclusionDataSource;
        [cell.inclusionDataSource setInclusions:self.availability.shuttles[indexPath.row].inclusions];
        [cell setShuttle:self.availability.shuttles[indexPath.row]];
        cell.inclusionHeightConstraint.constant = cell.inclusionsCollectionView.contentSize.height;
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
        self.groundSearch.selectedService = nil;
    }
    [self pushToDestination];
}

@end
