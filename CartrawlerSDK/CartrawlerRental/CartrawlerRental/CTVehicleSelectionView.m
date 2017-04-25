//
//  CTVehicleSelectionView.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleSelectionView.h"
#import "CTVehicleSelectionDataSource.h"
#import "CTVehicleDetailTableViewCell.h"
#import "CartrawlerSDK/CTLayoutManager.h"

@interface CTVehicleSelectionView() <CTVehicleSelectionDelegate>

@property (nonatomic, strong) CTVehicleSelectionDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CTVehicleSelectionView

- (instancetype)init
{
    self = [super init];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    _dataSource = [CTVehicleSelectionDataSource new];
    
    _tableView = [self createTableView];
    self.tableView.delegate = self.dataSource;
    self.tableView.dataSource = self.dataSource;
    self.dataSource.delegate = self;
    [self layout];
    
    return self;
}

- (UITableView *)createTableView
{
    UITableView *tv = [UITableView new];
    tv.estimatedRowHeight = 240;
    tv.rowHeight = UITableViewAutomaticDimension;
    [tv registerClass:[CTVehicleDetailTableViewCell class] forCellReuseIdentifier:@"VehicleCell"];
    tv.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tv;
}

- (void)layout
{
    [self addSubview:self.tableView];
    [CTLayoutManager pinView:self.tableView toSuperView:self padding:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)updateSelection:(NSArray <CTAvailabilityItem *> *)data pickupDate:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate sortByPrice:(BOOL)sortByPrice
{
    [self.dataSource updateData:data pickupDate:pickupDate dropoffDate:dropoffDate sortByPrice:sortByPrice];
    [self.tableView reloadData];
}

- (void)sortByPrice:(BOOL)sortByPrice
{
    [self.dataSource sortByPrice:sortByPrice];
    [self.tableView reloadData];
    [self scrollToTop];
}

- (void)scrollToTop
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];}

//MARK: CTVehicleSelectionDelegate

- (void)didSelectCellAtIndex:(NSIndexPath *)indexPath data:(CTAvailabilityItem *)data
{
    if (self.delegate) {
        [self.delegate didSelectVehicle:data];
    }
}

@end
