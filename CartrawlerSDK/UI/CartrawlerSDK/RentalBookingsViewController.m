//
//  RentalBookingsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "RentalBookingsViewController.h"
#import "RentalBookingCell.h"
#import "DataStore.h"

@interface RentalBookingsViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<RentalBooking *> *bookings;

@end

@implementation RentalBookingsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 120.0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _bookings = [DataStore retrieveRentalBookings];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newBooking:(id)sender {
    if (self.showRentalEngine) {
        self.showRentalEngine(self);
    }
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
