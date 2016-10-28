//
//  CTInclusionsDataSource.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 27/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInclusionsDataSource.h"
#import "CTInclusionTableViewCell.h"

@interface CTInclusionsDataSource()

@property (nonatomic, strong) NSArray <CTPricedCoverage *> *coverages;

@end

@implementation CTInclusionsDataSource

- (void)setData:(NSArray <CTPricedCoverage *> *)coverages
{
    _coverages = coverages;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.coverages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTInclusionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setLabelText:self.coverages[indexPath.row].chargeDescription];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellTapped) {
        self.cellTapped(tableView, [self tooltipTextForPricedCoverage:self.coverages[indexPath.row]]);
    }
}

- (NSString *)tooltipTextForPricedCoverage:(CTPricedCoverage *)coverage
{
    if ([coverage.coverageType isEqualToString:@"6"]) {//CDW
        return @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s";
    }
    
    if ([coverage.coverageType isEqualToString:@"47"]) {//TW
        return @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s";
    }
    
    if ([coverage.coverageType isEqualToString:@"50"]) {//TP
        return @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s";
    }
    
    return @"This item is included in the price of this vehicle";
}

@end
