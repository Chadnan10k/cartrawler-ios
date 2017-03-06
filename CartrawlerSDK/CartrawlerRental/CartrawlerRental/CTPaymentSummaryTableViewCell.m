//
//  CTCTPaymentSummaryTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentSummaryTableViewCell.h"
#import <CartrawlerSDK/CTLabel.h>
#import "CTPaymentSummaryTableViewCell.h"
#import "CTPaymentSummaryItemTableViewCell.h"
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import <CartrawlerSDK/CartrawlerSDK+UIView.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTPaymentSummaryTableViewCell() <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet CTLabel *totalLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<NSDictionary *> *items;
@property (weak, nonatomic) IBOutlet UILabel *totalTitleLabel;

@end

@implementation CTPaymentSummaryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.dataSource = self;
    self.totalTitleLabel.text = CTLocalizedString(CTRentalSummaryTotal);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(CTRentalSearch *)search
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    double total = 0;
    _items = [[NSMutableArray alloc] init];
    
    for (CTFee *fee in search.selectedVehicle.vehicle.fees) {
        if (fee.feePurpose == CTFeeTypePayNow && fee.feeAmount.doubleValue > 0.0) {//Deposit
            [self.items addObject:@{@"Normal" : @{@"Name" : CTLocalizedString(CTRentalSummaryPayNow), @"Price" : fee.feeAmount}}];
        } else if (fee.feePurpose == CTFeeTypePayAtDesk && fee.feeAmount.doubleValue > 0.0) {//Pay at desk
            [self.items addObject:@{@"Normal" : @{@"Name" : CTLocalizedString(CTRentalSummaryPayAtDesk), @"Price" : fee.feeAmount}}];
        } else if (fee.feePurpose == CTFeeTypeBooking && fee.feeAmount.doubleValue > 0.0) {//Booking fee
            [self.items addObject:@{@"Normal" : @{@"Name" : CTLocalizedString(CTRentalSummaryBookingFee), @"Price" : fee.feeAmount}}];
        }
    }
    
    if (search.isBuyingInsurance) {
        [self.items addObject:@{@"Normal" : @{@"Name" : CTLocalizedString(CTRentalSummaryDamageRefund), @"Price" : search.insurance.premiumAmount}}];
        total += search.insurance.premiumAmount.doubleValue;
    }
    
    for (CTExtraEquipment *extra in search.selectedVehicle.vehicle.extraEquipment) {
        if (extra.qty > 0) {
           // [self.items addObject:@{@"Normal" : @{@"Name" : extra.equipDescription, @"Price" : extra.chargeAmount}}];
            [self.items addObject:@{@"Extra" : @{@"Name" : extra.equipDescription, @"Price" : CTLocalizedString(CTRentalSummaryPayAtDesk)}}];
        }
    }
    
    total += search.selectedVehicle.vehicle.totalPriceForThisVehicle.doubleValue;
    
    self.totalLabel.text = [@(total) numberStringWithCurrencyCode];
    
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    
    [self.tableView cartrawlerConstraintForAttribute:NSLayoutAttributeHeight].constant = self.tableView.contentSize.height;
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
    CTPaymentSummaryItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *data = self.items[indexPath.row];
    
    if (data[@"Extra"]) {
        [cell setDetailsItalic:data[@"Extra"][@"Name"]];
    } else {
        [cell setDetails:data[@"Normal"][@"Name"] price:data[@"Normal"][@"Price"]];
    }
    
    return cell;
}

@end
