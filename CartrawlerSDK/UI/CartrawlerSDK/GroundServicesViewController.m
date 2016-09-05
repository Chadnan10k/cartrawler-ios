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
    self.tableView.estimatedRowHeight = 80;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    GTServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section == 1) {
        [cell setService:self.availability.services[indexPath.row]];
    } else {
        [cell setShuttle:self.availability.shuttles[indexPath.row]];
    }
    
    NSLog(@"CTHEIGHT %f", cell.inclusionsCollectionView.contentSize.height);
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 250;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
