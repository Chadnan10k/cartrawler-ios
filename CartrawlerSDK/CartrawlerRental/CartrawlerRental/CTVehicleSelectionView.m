//
//  CTVehicleSelectionView.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleSelectionView.h"
#import "CTVehicleSelectionDataSource.h"
#import "CartrawlerSDK/CTLayoutManager.h"

@interface CTVehicleSelectionView() <CTVehicleSelectionDelegate>

@property (nonatomic, strong) CTVehicleSelectionDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CTVehicleSelectionView

- (instancetype)init
{
    self = [super init];
    
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
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    [tv registerNib:[UINib nibWithNibName:@"CTVehicleTableViewCell_iPhone" bundle:bundle] forCellReuseIdentifier:@"VehicleCell"];
    tv.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tv;
}

- (void)layout
{
    [self addSubview:self.tableView];
    [CTLayoutManager pinView:self.tableView toSuperView:self padding:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)showLoading
{
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.alpha = 0;
        self.tableView.scrollsToTop = YES;
    }];
}

- (void)hideLoading
{
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.alpha = 1;
        self.tableView.scrollsToTop = YES;
    }];
}

- (void)updateSelection:(NSArray <CTAvailabilityItem *> *)data sortByPrice:(BOOL)sortByPrice
{
    [self.dataSource updateData:data sortByPrice:sortByPrice];
    [self.tableView reloadData];
    NSIndexPath* top = [NSIndexPath indexPathForRow:NSNotFound inSection:0];
    [self.tableView scrollToRowAtIndexPath:top atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

//MARK: CTVehicleSelectionDelegate

- (void)didSelectCellAtIndex:(NSIndexPath *)indexPath data:(CTAvailabilityItem *)data
{
    if (self.delegate) {
        [self.delegate didSelectVehicle:data];
    }
}

@end
