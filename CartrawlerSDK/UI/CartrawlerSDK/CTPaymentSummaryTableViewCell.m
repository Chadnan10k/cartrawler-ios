//
//  CTPaymentSummaryTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentSummaryTableViewCell.h"
#import "CTLabel.h"
#import "PaymentSummaryTableViewCell.h"
#import "CartrawlerSDK+NSNumber.h"
#import "CartrawlerSDK+UIView.h"

@interface CTPaymentSummaryTableViewCell() <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet CTLabel *totalLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<NSDictionary *> *items;

@end

@implementation CTPaymentSummaryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(CarRentalSearch *)search
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    double total = 0;
    _items = [[NSMutableArray alloc] init];
    
    [self.items addObject:@{@"Normal" : @{@"Name" : @"Car hire", @"Price" : search.selectedVehicle.vehicle.totalPriceForThisVehicle}}];
    
    if (search.isBuyingInsurance) {
        [self.items addObject:@{@"Normal" : @{@"Name" : @"Damage Refund Insurance", @"Price" : search.insurance.premiumAmount}}];
        total += search.insurance.premiumAmount.doubleValue;
    }
    
    for (CTExtraEquipment *extra in search.selectedVehicle.vehicle.extraEquipment) {
        if (extra.qty > 0) {
            [self.items addObject:@{@"Extra" : @{@"Name" : extra.equipDescription, @"Price" : @"Pay at desk"}}];
        }
    }
    
    total += search.selectedVehicle.vehicle.totalPriceForThisVehicle.doubleValue;
    
    self.totalLabel.text = [@(total) numberStringWithCurrencyCode];
    
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    
    self.tableView.heightConstraint.constant = self.tableView.contentSize.height;
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

@end
