//
//  PaymentSummaryViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 11/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentSummaryViewController.h"
#import "PaymentSummaryTableViewCell.h"

@interface PaymentSummaryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (strong, nonatomic) NSMutableArray *items;

@end

@implementation PaymentSummaryViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _items = [[NSMutableArray alloc] init];
    
    [self.items addObject:@{@"Normal" : @{@"Name" : @"Car hire", @"Price" : self.selectedVehicle.totalPriceForThisVehicle}}];

    if (self.isBuyingInsurance) {
        [self.items addObject:@{@"Normal" : @{@"Name" : @"Damage Refund Insurance", @"Price" : self.insurance.premiumAmount}}];
    }
    
    for (CTExtraEquipment *extra in self.extras) {
        [self.items addObject:@{@"Extra" : @{@"Name" : extra.equipDescription, @"Price" : @"Pay at desk"}}];
    }
    
    NSLog(@"%@", self.items);
    
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    [self.view layoutIfNeeded];
    self.tableViewHeight.constant = self.tableView.contentSize.height + 180;

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
        
       // NSLog(@"%@ :: %@", [[data objectForKey:@"Extra"] objectForKey:@"Name"], [[data objectForKey:@"Extra"] objectForKey:@"Price"]);
    } else {
        [cell setDetails:[[data objectForKey:@"Normal"] objectForKey:@"Name"] price:[[data objectForKey:@"Normal"] objectForKey:@"Price"]];
       // NSLog(@"%@ :: %@", [[data objectForKey:@"Normal"] objectForKey:@"Name"], [[data objectForKey:@"Normal"] objectForKey:@"Price"]);
    }
    
    return cell;
}


@end
