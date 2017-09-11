//
//  CTVehicleListViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleListViewController.h"
#import "CTVehicleListFilterViewController.h"
#import "CTVehicleListViewModel.h"
#import "CTVehicleListTableViewCell.h"
#import "CTAppController.h"

@interface CTVehicleListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) CTVehicleListViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *headerLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerRightLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIAlertController *alertController;
@property (weak, nonatomic) IBOutlet UIView *badgeView;
@property (weak, nonatomic) IBOutlet UILabel *badgeCount;
@end

@implementation CTVehicleListViewController

+ (Class)viewModelClass {
    return CTVehicleListViewModel.class;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Buzz" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Allow space to scroll above filter button
    [self.tableView setContentInset:UIEdgeInsetsMake(5.0, 0, 62, 0)];
    
    [self updateWithViewModel:self.viewModel];
}

- (void)updateWithViewModel:(CTVehicleListViewModel *)viewModel {
    if (!self.viewModel || self.viewModel.selectedSort != viewModel.selectedSort) {
        [self.tableView reloadData];
    }
    
    self.viewModel = viewModel;
    
    self.navigationBar.barTintColor = viewModel.navigationBarColor;
    self.titleLabel.text = viewModel.navigationBarTitle;
    self.detailLabel.text = viewModel.navigationBarDetail;
    
    self.headerLeftLabel.text = viewModel.leftLabelText;
    self.headerRightLabel.attributedText = viewModel.rightLabelText;
    
    self.badgeView.hidden = !viewModel.showSortBadge;
    self.badgeCount.text = viewModel.badgeCount;
    
    switch (viewModel.selectedView) {
        case CTVehicleListSelectedViewNone:
            if (self.presentedViewController) {
                [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
            }
            break;
        case CTVehicleListSelectedViewSort:
            if (!self.presentedViewController) {
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
    
    UIAlertAction *recommended = [UIAlertAction actionWithTitle:viewModel.sortOptions[0]
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            [CTAppController dispatchAction:CTActionVehicleListUserDidTapSortOption payload:@(CTVehicleListSortRecommended)];
                                                        }];
    
    UIAlertAction *price = [UIAlertAction actionWithTitle:viewModel.sortOptions[1]
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            [CTAppController dispatchAction:CTActionVehicleListUserDidTapSortOption payload:@(CTVehicleListSortPrice)];
                                                        }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:viewModel.cancelTitle
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [CTAppController dispatchAction:CTActionVehicleListUserDidTapCancelSort payload:nil];
                                                   }];
    [self.alertController addAction:recommended];
    [self.alertController addAction:price];
    [self.alertController addAction:cancel];
    
    [self presentViewController:self.alertController animated:YES completion:nil];
}

- (void)presentFilterViewController {
    [self performSegueWithIdentifier:@"VehicleListFilter" sender:self];
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

- (IBAction)backButtonTapped:(id)sender {
    [CTAppController dispatchAction:CTActionVehicleListUserDidTapBack payload:nil];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}

@end
