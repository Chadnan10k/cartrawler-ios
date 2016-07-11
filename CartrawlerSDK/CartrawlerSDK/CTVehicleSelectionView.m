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

- (void)initWithVehicleAvailability:(NSArray <CTVehicle *> *)data
                         completion:(VehicleSelectionCompletion)completion;
{
    //self = [super self];
    
    [self.tableView setContentOffset:
     CGPointMake(0, -self.tableView.contentInset.top) animated:YES];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    [self.tableView registerNib:[UINib nibWithNibName:@"VehicleTableViewCell_iPhone" bundle:bundle] forCellReuseIdentifier:@"VehicleCell"];
    
    _dataSource = [[CTVehicleSelectionViewModel alloc] initWithData:data cellSelected:^(CTVehicle *vehicle) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(vehicle);
        });
    }];
    
    self.tableView.delegate = self.dataSource;
    self.tableView.dataSource = self.dataSource;
    [self.tableView reloadData];
    //return self;
}

@end
