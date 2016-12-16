//
//  RentalBookingsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "RentalBookingsViewController.h"
#import "RentalBookingCell.h"
#import "CTDataStore.h"
#import "CTNextButton.h"
#import "CTAppearance.h"

@interface RentalBookingsViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<CTRentalBooking *> *bookings;
@property (weak, nonatomic) IBOutlet CTNextButton *nextButton;
@property (weak, nonatomic) IBOutlet UIView *subHeaderView;

@end

@implementation RentalBookingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.subHeaderView.backgroundColor = [CTAppearance instance].iconTint;
    
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 120.0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak typeof(self) weakSelf = self;
    [self.nextButton setText:@"Add a booking" didTap:^{
        [weakSelf pushToDestination];
    }];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _bookings = [CTDataStore retrieveRentalBookings];
    [self.tableView reloadData];
}

#pragma MARK UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bookings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RentalBookingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setData:self.bookings[indexPath.row]];
    return cell;
}

@end
