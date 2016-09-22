//
//  CTVehicleSelectionView.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleSelectionView.h"
#import "CTVehicleSelectionViewModel.h"

@interface CTVehicleSelectionView()

@property (nonatomic, strong) CTVehicleSelectionViewModel *dataSource;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation CTVehicleSelectionView

+ (void)forceLinkerLoad_
{
    
}

- (void)showLoading
{
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.tableView.alpha = 0;
        weakSelf.tableView.scrollsToTop = YES;
    }];
}

- (void)hideLoading
{
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.tableView.alpha = 1;
        weakSelf.tableView.scrollsToTop = YES;
    }];
}

- (void)initWithVehicleAvailability:(NSArray <CTAvailabilityItem *> *)data
                         completion:(VehicleSelectionCompletion)completion;
{
    
    [self.tableView setContentInset:UIEdgeInsetsMake(40,0,0,0)];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    [self.tableView registerNib:[UINib nibWithNibName:@"VehicleTableViewCell_iPhone" bundle:bundle] forCellReuseIdentifier:@"VehicleCell"];

    _dataSource = [[CTVehicleSelectionViewModel alloc] initWithData:data cellSelected:^(CTAvailabilityItem *vehicle) {
        completion(vehicle);
    }];
    
    self.tableView.delegate = self.dataSource;
    self.tableView.dataSource = self.dataSource;
    
    [self.tableView reloadData];
    
    self.tableView.scrollsToTop = YES;
}

- (void)updateSelection:(NSArray <CTAvailabilityItem *> *)data
{
    [self.dataSource updateData:data];
    [self.tableView reloadData];
}

@end
