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

@property (nonatomic, strong) NSArray <CTVehicle *> *vehicles;
@property (nonatomic, strong) VehicleSelectionCompletion selectedVehicle;

@end

@implementation CTVehicleSelectionViewModel

- (id)initWithData:(CTVehicleAvailability *)data cellSelected:(VehicleSelectionCompletion)cellSeleted
{
    self = [super init];

    self.vehicles = data.allVehicles;
    self.selectedVehicle = cellSeleted;
    return self;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vehicles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CTVehicle *vehicle = self.vehicles[indexPath.row];
    VehicleTableViewCell *cell = (VehicleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"VehicleCell" forIndexPath:indexPath];
    [cell initWithVehicle:vehicle];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 128;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedVehicle != nil) {
        self.selectedVehicle(self.vehicles[indexPath.row]);
    }
}

@end
