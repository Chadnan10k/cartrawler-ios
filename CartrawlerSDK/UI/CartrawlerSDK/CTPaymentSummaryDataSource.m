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
#import "CTAppearance.h"

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
    UILabel *customLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0,5.0,200.0,20.0)];
    customLabel.textColor = [CTAppearance instance].viewBackgroundColor;
    customLabel.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:17];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 20)];
    
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    headerView.alpha = 0.9;
    [headerView addSubview:customLabel];
    switch (section) {
        case 0:
            customLabel.text = @"Pick-up";
            break;
        case 1:
            customLabel.text = @"Drop-off";
            break;
        case 2:
            customLabel.text = @"Lead driver details";
            break;
        case 3:
            customLabel.text = @"Vehicle summary";
            break;
        case 4:
            customLabel.text = @"Payment summary";
            break;
        default:
            break;
    }
    
    return headerView;
}

@end
