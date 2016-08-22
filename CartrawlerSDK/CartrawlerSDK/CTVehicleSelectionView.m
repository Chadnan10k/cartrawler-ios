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
   /// [UIView animateWithDuration:0.3 animations:^{
        self.tableView.alpha = 0;
        self.tableView.scrollsToTop = YES;
    ///}];
}

- (void)hideLoading
{
    __weak typeof (self) weakSelf = self;
   // [UIView animateWithDuration:0.3 animations:^{
        self.tableView.alpha = 1;
        self.tableView.scrollsToTop = YES;
   // }];
}

- (void)initWithVehicleAvailability:(NSArray <CTVehicle *> *)data
                         completion:(VehicleSelectionCompletion)completion;
{
    
//    [self.tableView setContentOffset:
//     CGPointMake(0, -self.tableView.contentInset.top) animated:YES];
//    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    [self.tableView registerNib:[UINib nibWithNibName:@"VehicleTableViewCell_iPhone" bundle:bundle] forCellReuseIdentifier:@"VehicleCell"];

    _dataSource = [[CTVehicleSelectionViewModel alloc] initWithData:data cellSelected:^(CTVehicle *vehicle) {
        completion(vehicle);
    }];
    
    self.tableView.delegate = self.dataSource;
    self.tableView.dataSource = self.dataSource;
    
    [self.tableView reloadData];
    
    self.tableView.scrollsToTop = YES;

}


@end
