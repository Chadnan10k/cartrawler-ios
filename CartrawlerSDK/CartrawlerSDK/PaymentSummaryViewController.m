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

@interface PaymentSummaryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (strong, nonatomic) NSMutableArray *items;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryHeight;

@property (weak, nonatomic) IBOutlet BookingSummaryButton *bookingSummaryContainer;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end

@implementation PaymentSummaryViewController
{
    BOOL summaryVisible;
    double total;
}

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bookingSummaryContainer setDataWithVehicle:self.selectedVehicle
                                          pickupDate:self.pickupDate
                                         dropoffDate:self.dropoffDate
                                   isBuyingInsurance:self.isBuyingInsurance];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    total = 0;
    _items = [[NSMutableArray alloc] init];

    [self.items addObject:@{@"Normal" : @{@"Name" : @"Car hire", @"Price" : self.selectedVehicle.totalPriceForThisVehicle}}];

    if (self.isBuyingInsurance) {
        [self.items addObject:@{@"Normal" : @{@"Name" : @"Damage Refund Insurance", @"Price" : self.insurance.premiumAmount}}];
        total += self.insurance.premiumAmount.doubleValue;

    }
    
    for (CTExtraEquipment *extra in self.extras) {
        if (extra.qty > 0) {
            [self.items addObject:@{@"Extra" : @{@"Name" : extra.equipDescription, @"Price" : @"Pay at desk"}}];
        }
    }
    
    total += self.selectedVehicle.totalPriceForThisVehicle.doubleValue;
    
    self.totalLabel.text = [NSNumberUtils numberStringWithCurrencyCode:[NSNumber numberWithDouble:total]];
    
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    [self.view layoutIfNeeded];
    self.tableViewHeight.constant = self.tableView.contentSize.height;
}

- (IBAction)pushView:(id)sender {
    [self pushToStepSix];
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
    
    if ([data objectForKey:@"Extra"]) {
        [cell setDetailsItalic:[[data objectForKey:@"Extra"] objectForKey:@"Name"]];
        } else {
        [cell setDetails:[[data objectForKey:@"Normal"] objectForKey:@"Name"] price:[[data objectForKey:@"Normal"] objectForKey:@"Price"]];
    }
    
    return cell;
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
