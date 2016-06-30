//
//  CTFilterCarSizeDataSource.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTFilterDataSource.h"
#import "CTAppearance.h"
#import "CTFilterTableViewCell.h"
#import <CartrawlerAPI/CTVendor.h>

@interface CTFilterDataSource()

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSMutableArray *selectedData;

@end

@implementation CTFilterDataSource

- (id)initWithData:(NSArray *)data selectedData:(NSMutableArray *)selectedData
{
    self = [super init];
    _selectedData = selectedData;
    _data = data;
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if ([self.selectedData containsObject:self.data[indexPath.row]]) {
        [self.selectedData removeObject:self.data[indexPath.row]];
    } else {
        [self.selectedData addObject:self.data[indexPath.row]];
    }
    CTFilterTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell cellTapped];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if ([self.selectedData containsObject:self.data[indexPath.row]]) {
        [cell enableCheckmark:YES];
    }
    
    if ([self.data[indexPath.row] isKindOfClass:[NSString class]]) {
        NSString *str = self.data[indexPath.row];
        [cell setText:str];
    } else if ([self.data[indexPath.row] isKindOfClass:[CTVendor class]]) {
        CTVendor *ven = self.data[indexPath.row];
        [cell setText:ven.vendorName];
    }
    
    return cell;
}

@end
