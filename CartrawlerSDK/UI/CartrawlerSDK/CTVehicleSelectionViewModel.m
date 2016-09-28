//
//  CTVehicleSelectionViewModel.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleSelectionViewModel.h"
#import "VehicleTableViewCell.h"

@interface CTVehicleSelectionViewModel()

@property (nonatomic, strong) NSArray <CTAvailabilityItem *> *vehicles;
@property (nonatomic, strong) VehicleSelectionCompletion selectedVehicle;

@property (nonatomic, assign) CGFloat lastContentOffset;

@end

@implementation CTVehicleSelectionViewModel

- (id)initWithData:(NSArray <CTAvailabilityItem *> *)data cellSelected:(VehicleSelectionCompletion)cellSeleted
{
    self = [super init];

    _vehicles = data;
    _selectedVehicle = cellSeleted;
    return self;
}

- (void)updateData:(NSArray <CTAvailabilityItem *> *)data
{
    _vehicles = data;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vehicles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTAvailabilityItem *vehicle = self.vehicles[indexPath.row];
    VehicleTableViewCell *cell = (VehicleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"VehicleCell" forIndexPath:indexPath];
    [cell initWithVehicle:vehicle];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 208;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedVehicle != nil) {
        self.selectedVehicle(self.vehicles[indexPath.row]);
    }
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
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

@end
