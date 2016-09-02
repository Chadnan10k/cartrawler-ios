//
//  GroundServicesViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 14/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GroundServicesViewController.h"
#import "GTServiceTableViewCell.h"

@interface GroundServicesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) CTGroundAvailability *availability;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GroundServicesViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)setAvailability:(CTGroundAvailability *)availabilty
{
    _availability = availabilty;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 300;
    
//    [self.tableView reloadData];
//    [self.tableView layoutIfNeeded];    
//    self.tableViewHeight.constant = self.tableView.contentSize.height;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TABLE VIEW

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.availability.services.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GTServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setService:self.availability.services[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
