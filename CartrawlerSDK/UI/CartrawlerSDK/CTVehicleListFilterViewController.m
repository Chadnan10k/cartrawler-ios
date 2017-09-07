//
//  CTVehicleListFilterViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleListFilterViewController.h"
#import "CTVehicleListFilterViewModel.h"
#import "CTVehicleListFilterCellTableViewCell.h"
#import "CTVehicleListFilterHeaderView.h"
#import "CTAppController.h"

@interface CTVehicleListFilterViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic) CTVehicleListFilterViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CTVehicleListFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // TODO: Extract string
    [self.tableView registerNib:[UINib nibWithNibName:@"CTVehicleListFilterHeaderView" bundle:[NSBundle bundleForClass:self.class]] forHeaderFooterViewReuseIdentifier:@"HeaderView"];
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)updateWithViewModel:(CTVehicleListFilterViewModel *)viewModel {
    self.viewModel = viewModel;
    self.navigationBar.barTintColor = viewModel.navigationBarColor;
    self.navigationBar.topItem.title = viewModel.navigationTitle;
    [self.tableView reloadData];
}

+ (Class)viewModelClass {
    return CTVehicleListFilterViewModel.class;
}

- (IBAction)cancelButtonTapped:(id)sender {
    [CTAppController dispatchAction:CTActionVehicleListUserDidTapCancelFilter payload:nil];
}

- (IBAction)applyButtonTapped:(id)sender {
    [CTAppController dispatchAction:CTActionVehicleListUserDidTapApplyFilter payload:nil];
}

// MARK: <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.headerViewModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.headerViewModels[section].rowViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CTVehicleListFilterCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VehicleListFilterCell"];
    CTVehicleListFilterHeaderViewModel *headerViewModel = self.viewModel.headerViewModels[indexPath.section];
    CTVehicleListFilterCellTableViewModel *cellViewModel = headerViewModel.rowViewModels[indexPath.row];
    [cell updateWithViewModel:cellViewModel];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CTVehicleListFilterHeaderView *headerView = (CTVehicleListFilterHeaderView *)[self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderView"];
    headerView.contentView.backgroundColor = [UIColor clearColor];
    CTVehicleListFilterHeaderViewModel *viewModel = self.viewModel.headerViewModels[section];
    [headerView updateWithViewModel:viewModel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 68.0;
}

// MARK: <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CTVehicleListFilterHeaderViewModel *headerViewModel = self.viewModel.headerViewModels[indexPath.section];
    CTVehicleListFilterCellTableViewModel *cellViewModel = headerViewModel.rowViewModels[indexPath.row];
    CTVehicleListFilterModel *filterModel = cellViewModel.filterModel;
    [CTAppController dispatchAction:CTActionVehicleListUserDidTapFilterOption payload:filterModel];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}

@end
