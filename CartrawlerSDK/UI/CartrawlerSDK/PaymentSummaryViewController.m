//
//  PaymentSummaryViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 11/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentSummaryViewController.h"
#import "PaymentSummaryTableViewCell.h"
#import "CTDesignableView.h"
#import "CTSDKSettings.h"
#import "NSNumberUtils.h"
#import "BookingSummaryButton.h"
#import "CTLabel.h"
@interface PaymentSummaryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (strong, nonatomic) NSMutableArray *items;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryHeight;

@property (weak, nonatomic) IBOutlet BookingSummaryButton *bookingSummaryContainer;
@property (weak, nonatomic) IBOutlet CTLabel *totalLabel;

@end

@implementation PaymentSummaryViewController
{
    BOOL summaryVisible;
    double total;
}

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    
    self.tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.bookingSummaryContainer closeIfOpen];
    
    [self.bookingSummaryContainer setDataWithVehicle:self.search.selectedVehicle
                                          pickupDate:self.search.pickupDate
                                         dropoffDate:self.search.dropoffDate
                                   isBuyingInsurance:self.search.isBuyingInsurance];
    
    total = 0;
    _items = [[NSMutableArray alloc] init];

    [self.items addObject:@{@"Normal" : @{@"Name" : @"Car hire", @"Price" : self.search.selectedVehicle.vehicle.totalPriceForThisVehicle}}];

    if (self.search.isBuyingInsurance) {
        [self.items addObject:@{@"Normal" : @{@"Name" : @"Damage Refund Insurance", @"Price" : self.search.insurance.premiumAmount}}];
        total += self.search.insurance.premiumAmount.doubleValue;
    }
    
    for (CTExtraEquipment *extra in self.search.selectedVehicle.vehicle.extraEquipment) {
        if (extra.qty > 0) {
            [self.items addObject:@{@"Extra" : @{@"Name" : extra.equipDescription, @"Price" : @"Pay at desk"}}];
        }
    }
    
    total += self.search.selectedVehicle.vehicle.totalPriceForThisVehicle.doubleValue;
    
    self.totalLabel.text = [NSNumberUtils numberStringWithCurrencyCode:@(total)];

    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];

    self.tableView.alpha = 1;
    self.tableViewHeight.constant = self.tableView.contentSize.height;


}

- (IBAction)pushView:(id)sender {
    [self pushToDestination];
}

#pragma mark TABLE VIEW

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaymentSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *data = self.items[indexPath.row];
    
    if (data[@"Extra"]) {
        [cell setDetailsItalic:data[@"Extra"][@"Name"]];
        } else {
        [cell setDetails:data[@"Normal"][@"Name"] price:data[@"Normal"][@"Price"]];
    }
    
    return cell;
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
