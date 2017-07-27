//
//  CTVehicleListViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleListViewController.h"
#import "CTVehicleListViewModel.h"
#import "CTVehicleListTableViewCell.h"
#import "CTAppController.h"

@interface CTVehicleListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) CTVehicleListViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *headerLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerRightLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) UIAlertController *alertController;
@end

@implementation CTVehicleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setContentInset:UIEdgeInsetsMake(5.0, 0, 30, 0)];
    [self updateWithViewModel:self.viewModel];
}

- (void)updateWithViewModel:(CTVehicleListViewModel *)viewModel {
    self.viewModel = viewModel;
    self.headerLeftLabel.text = viewModel.leftLabelText;
    self.headerRightLabel.attributedText = viewModel.rightLabelText;
    [self.tableView reloadData];
    
    switch (viewModel.selectedView) {
        case CTVehicleListSelectedViewNone:
            if (self.presentedViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            break;
        case CTVehicleListSelectedViewSort:
            if (!self.alertController) {
                [self presentSortViewControllerWithViewModel:viewModel];
            }
            break;
        default:
            break;
    }
    
    if (viewModel.scrollToTop) {
        // TODO: Extract magic number
        [self.tableView setContentOffset:CGPointMake(0, -5.0) animated:YES];
        [CTAppController dispatchAction:CTActionVehicleListScreenDidScrollToTop payload:nil];
    }
}

// MARK: Sort

- (IBAction)sortButtonTapped:(UIGestureRecognizer *)sender {
    [CTAppController dispatchAction:CTActionVehicleListUserDidTapSort payload:nil];
}

- (void)presentSortViewControllerWithViewModel:(CTVehicleListViewModel *)viewModel {
    self.alertController = [UIAlertController alertControllerWithTitle:viewModel.sortTitle
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *price = [UIAlertAction actionWithTitle:viewModel.sortOptions[0]
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            [CTAppController dispatchAction:CTActionVehicleListUserDidTapSortOption payload:@(CTVehicleListSortPrice)];
                                                        }];
    
    UIAlertAction *recommended = [UIAlertAction actionWithTitle:viewModel.sortOptions[1]
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * action) {
                                                                    [CTAppController dispatchAction:CTActionVehicleListUserDidTapSortOption payload:@(CTVehicleListSortRecommended)];
                                                                }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:viewModel.cancelTitle
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [CTAppController dispatchAction:CTActionVehicleListUserDidTapCancelSort payload:nil];
                                                   }];
    
    [self.alertController addAction:price];
    [self.alertController addAction:recommended];
    [self.alertController addAction:cancel];
    
    [self presentViewController:self.alertController animated:YES completion:nil];
}

// MARK: Filter Button

- (IBAction)filterButtonTapped:(UITapGestureRecognizer *)sender {
    [CTAppController dispatchAction:CTActionVehicleListUserDidTapFilter payload:nil];
}


// MARK: Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.rowViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CTVehicleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VehicleListCell"];
    
    cell.backgroundColor = [UIColor clearColor];
    [cell updateWithViewModel:self.viewModel.rowViewModels[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.viewModel.rowViewModels[indexPath.row].displaySpecialOffer ? 252 : 222;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CTAvailabilityItem *item = self.viewModel.rowViewModels[indexPath.row].availabilityItem;
    [CTAppController dispatchAction:CTActionVehicleListUserDidTapVehicle payload:item];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        [CTAppController dispatchAction:CTActionSearchUserDidTapBack payload:nil];
    }
}

@end
