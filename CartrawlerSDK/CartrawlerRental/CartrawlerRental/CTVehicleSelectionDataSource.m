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
@property (nonatomic, strong) VehicleSelectionCompletion selectedVehicle;

@property (nonatomic, assign) CGFloat lastContentOffset;

@end

@implementation CTVehicleSelectionDataSource

- (id)initWithData:(NSArray <CTAvailabilityItem *> *)data cellSelected:(VehicleSelectionCompletion)cellSeleted
{
    self = [super init];

    _vehicles = [self sortVehiclesByRecommendedIndex:data];
    _selectedVehicle = cellSeleted;
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
    if (self.selectedVehicle != nil) {
        self.selectedVehicle(self.vehicles[indexPath.row]);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint currentOffset = scrollView.contentOffset;

    if (!(currentOffset.y < 0)) {
        
        if (currentOffset.y < 1000) {
            
            if (currentOffset.y >= self.lastContentOffset)
            {
                if (self.direction) {
                    self.direction(NO);
                }
            } else {
                if (self.direction) {
                    self.direction(YES);
                }
            }
        }
        
    } else {
        if (self.direction) {
            self.direction(YES);
        }
    }
    self.lastContentOffset = currentOffset.y;
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
