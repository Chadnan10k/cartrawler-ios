//
//  CTPaymentSummaryDataSource.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentSummaryDataSource.h"
#import "CTPaymentLocationTableViewCell.h"
#import "CTPaymentDriverTableViewCell.h"
#import "CTPaymentVehicleTableViewCell.h"
#import "CTPaymentSummaryTableViewCell.h"
#import <CartrawlerSDK/CTAppearance.h>

@interface CTPaymentSummaryDataSource()

@property (nonatomic, strong) CTRentalSearch *search;

@end

@implementation CTPaymentSummaryDataSource

- (void)setData:(CTRentalSearch *)search
{
    _search = search;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 3;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: {
            CTPaymentLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"location"];
            [cell setData:self.search.pickupLocation date:self.search.pickupDate];
            return cell;
        }
        case 1: {
            CTPaymentLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"location"];
            [cell setData:self.search.dropoffLocation date:self.search.dropoffDate];
            return cell;
        }
        case 2: {
            CTPaymentDriverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"driver_details"];
            if (indexPath.row == 0) {
                [cell setData:[NSString stringWithFormat:@"%@ %@", self.search.firstName, self.search.surname]];
            } else if (indexPath.row == 1) {
                [cell setData:self.search.email];
            } else if (indexPath.row == 2) {
                [cell setData:self.search.phone];
            }
            return cell;
        }
        case 3: {
            CTPaymentVehicleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vehicle"];
            [cell setData:self.search];
            return cell;
        }
        case 4: {
            CTPaymentSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payment"];
            [cell setData:self.search];
            return cell;
        }
        default:
            return [UITableViewCell new];

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.textColor = [CTAppearance instance].viewBackgroundColor;
    headerLabel.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:17];
    headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1.0, 20)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    headerView.alpha = 0.9;
    
    [headerView addSubview:headerLabel];
    NSNumber *padding = [NSNumber numberWithDouble:[CTAppearance instance].containerViewMarginPadding];
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[label]"
                                                                       options:0
                                                                       metrics:@{@"padding" : padding}
                                                                         views:@{@"label" : headerLabel}]];
    
    [headerView addConstraint:   [NSLayoutConstraint constraintWithItem:headerLabel
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:headerView
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1
                                                               constant:0]];
    
    switch (section) {
        case 0:
            headerLabel.text = @"Pick-up";
            break;
        case 1:
            headerLabel.text = @"Drop-off";
            break;
        case 2:
            headerLabel.text = @"Lead driver details";
            break;
        case 3:
            headerLabel.text = @"Vehicle summary";
            break;
        case 4:
            headerLabel.text = @"Payment summary";
            break;
        default:
            break;
    }
    
    return headerView;
}

@end
