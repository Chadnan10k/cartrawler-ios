//
//  CTRentalBookingsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTRentalBookingsViewController.h"
#import "CTRentalBookingCell.h"
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTDataStore.h>
#import <CartrawlerSDK/CTNextButton.h>
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CTSDKSettings.h>

@interface CTRentalBookingsViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<CTRentalBooking *> *bookings;
@property (weak, nonatomic) IBOutlet CTNextButton *nextButton;
@property (weak, nonatomic) IBOutlet UIView *subHeaderView;
@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;
@property (weak, nonatomic) IBOutlet CTLabel *tableHeaderLabel;

@end

@implementation CTRentalBookingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.subHeaderView.backgroundColor = [CTAppearance instance].iconTint;
    
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 120.0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.nextButton setText:CTLocalizedString(CTRentalCTAAdd)];
    self.titleLabel.text = CTLocalizedString(CTRentalTitleSearchRental);
    self.tableHeaderLabel.text = CTLocalizedString(CTRentalBookingTableHeaderTitle);
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)newBooking:(id)sender {
    [self sendEvent:NO customParams:@{@"buttonName" : @"Add a booking"} eventName:@"Button Click" eventType:@"UserAction"];
    [self pushToDestination];
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
    CTRentalBookingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setData:self.bookings[indexPath.row]];
    return cell;
}

@end
