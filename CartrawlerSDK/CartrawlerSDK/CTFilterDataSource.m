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
#import <CartrawlerAPI/CTVehicle.h>

@interface CTFilterDataSource()

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSMutableArray *selectedData;
@property (nonatomic) FilterDataType filterType;

@end

@implementation CTFilterDataSource

- (id)initWithData:(NSArray *)data selectedData:(NSArray *)selectedData filterType:(FilterDataType)filterType;
{
    self = [super init];
    _filterType = filterType;
    _selectedData = [[NSMutableArray alloc] initWithArray:selectedData];
    _data = data;
    return self;
}

- (void)reset
{
    [self.selectedData removeAllObjects];
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
    
    if (self.filterCompletion) {
        self.filterCompletion(self.selectedData);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setup];
    
    if ([self.selectedData containsObject:self.data[indexPath.row]]) {
        [cell enableCheckmark:YES];
    } else {
        [cell enableCheckmark:NO];
    }
    
    if ([self.data[indexPath.row] isKindOfClass:[NSString class]]) {
        NSString *str = self.data[indexPath.row];
        [cell setText:str];
    } else if (self.filterType == FilterDataTypeVendor) {
        CTVendor *ven = self.data[indexPath.row];
        [cell setText:ven.name];
    } else if (self.filterType == FilterDataTypeVehicleSize) {
        CTVehicle *veh = self.data[indexPath.row];
        [cell setText:veh.categoryDescription];
    } else if (self.filterType == FilterDataTypeFuelPolicy) {
        CTVehicle *veh = self.data[indexPath.row];
        [cell setText:veh.fuelPolicyDescription];
    } else if (self.filterType == FilterDataTypeTransmission) {
        CTVehicle *veh = self.data[indexPath.row];
        [cell setText:veh.transmissionType];
    } else if (self.filterType == FilterDataTypeLocation) {
        CTVehicle *veh = self.data[indexPath.row];
        [cell setText:[self localizedPickupType:veh.vendor.pickupType]];
    }
    
    return cell;
}

- (NSString *)localizedPickupType:(PickupType)pickupType
{
    switch (pickupType) {
        case PickupTypeTerminal:
            return NSLocalizedString(@"In Terminal", @"");
            break;
        case PickupTypeShuttleBus:
            return NSLocalizedString(@"Shuttle bus", @"");
            break;
        case PickupTypeTerminalAndShuttle:
            return NSLocalizedString(@"Shuttle bus from terminal", @"");
            break;
        case PickupTypeMeetAndGreet:
            return NSLocalizedString(@"Meet and greet", @"");
            break;
        case PickupTypeCarDriver:
            return NSLocalizedString(@"Driver pickup", @"");
            break;
        case PickupTypeUnknown:
            return NSLocalizedString(@"Unknown", @"");
            break;
        default:
            return NSLocalizedString(@"Unknown", @"");
            break;
    }
}

@end
