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
@property (nonatomic, strong) NSArray <CTExtraEquipment *> *extras;

@end

@implementation CTInclusionsDataSource

- (void)setData:(NSArray <CTPricedCoverage *> *)coverages extras:(NSArray <CTPricedCoverage *> *)extras;
{
    _coverages = coverages;
    
    NSMutableArray *tempExtras = [NSMutableArray new];
    for(CTExtraEquipment *extra in extras) {
        if (extra.isIncludedInRate) {
            [tempExtras addObject:extra];
        }
    }
    
    _extras = tempExtras;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.coverages.count;
    } else {
        return self.extras.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CTInclusionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        [cell setLabelText:self.coverages[indexPath.row].chargeDescription];
        return cell;
    } else {
        CTInclusionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        [cell setLabelText:self.extras[indexPath.row].equipDescription];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.cellTapped) {
            self.cellTapped(tableView, [self tooltipTextForPricedCoverage:self.coverages[indexPath.row]]);
        }
    } else {
        if (self.cellTapped) {
            self.cellTapped(tableView, @"This vehicle includes a free additional driver");
        }
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
