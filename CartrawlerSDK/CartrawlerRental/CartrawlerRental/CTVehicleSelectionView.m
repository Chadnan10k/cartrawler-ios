//
//  CTVehicleSelectionView.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleSelectionView.h"
#import "CTVehicleSelectionDataSource.h"

@interface CTVehicleSelectionView()

@property (nonatomic, strong) CTVehicleSelectionDataSource *dataSource;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation CTVehicleSelectionView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tableView.estimatedRowHeight = 240;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
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
    __weak typeof (self) weakSelf = self;

    [self.tableView setContentInset:UIEdgeInsetsMake(55,0,0,0)];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    [self.tableView registerNib:[UINib nibWithNibName:@"CTVehicleTableViewCell_iPhone" bundle:bundle] forCellReuseIdentifier:@"VehicleCell"];

    _dataSource = [[CTVehicleSelectionDataSource alloc] initWithData:data cellSelected:^(CTAvailabilityItem *vehicle) {
        completion(vehicle);
    }];
    
    self.dataSource.direction = ^(BOOL direction) {
        if (weakSelf.direction) {
            weakSelf.direction(direction);
        }
    };
    
    self.tableView.delegate = self.dataSource;
    self.tableView.dataSource = self.dataSource;
    
    [self.tableView reloadData];
    
    self.tableView.scrollsToTop = YES;
}

- (void)updateSelection:(NSArray <CTAvailabilityItem *> *)data sortByPrice:(BOOL)sortByPrice
{
    [self.dataSource updateData:data sortByPrice:sortByPrice];
    [self.tableView reloadData];
    NSIndexPath* top = [NSIndexPath indexPathForRow:NSNotFound inSection:0];
    [self.tableView scrollToRowAtIndexPath:top atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
