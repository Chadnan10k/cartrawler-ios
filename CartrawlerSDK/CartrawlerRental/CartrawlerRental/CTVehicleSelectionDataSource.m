//
//  CTVehicleSelectionViewModel.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleSelectionDataSource.h"
#import "CTVehicleTableViewCell.h"

@interface CTVehicleSelectionDataSource()

@property (nonatomic, strong) NSArray <CTAvailabilityItem *> *vehicles;

@property (nonatomic, assign) CGFloat lastContentOffset;

@end

@implementation CTVehicleSelectionDataSource

- (instancetype)init
{
    self = [super init];
    _vehicles = @[];
    return self;
}

- (void)updateData:(NSArray <CTAvailabilityItem *> *)data sortByPrice:(BOOL)sortByPrice
{
    if (sortByPrice) {
        _vehicles = [self sortVehiclesByPrice:data];
    } else {
        _vehicles = [self sortVehiclesByRecommendedIndex:data];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vehicles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTAvailabilityItem *vehicle = self.vehicles[indexPath.row];
    CTVehicleTableViewCell *cell = (CTVehicleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"VehicleCell" forIndexPath:indexPath];
    [cell initWithVehicle:vehicle index:indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate) {
        [self.delegate didSelectCellAtIndex:indexPath data:self.vehicles[indexPath.row]];
    }
}

#pragma mark Sorting

- (NSArray <CTAvailabilityItem *> *)sortVehiclesByRecommendedIndex:(NSArray <CTAvailabilityItem *> *)stockArray
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey: @"vehicle.config.relevance" ascending: YES];
    
    return [stockArray sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
}
    
- (NSArray <CTAvailabilityItem *> *)sortVehiclesByPrice:(NSArray <CTAvailabilityItem *> *)stockArray
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey: @"vehicle.totalPriceForThisVehicle" ascending: YES];
    
    return [stockArray sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
}

@end
