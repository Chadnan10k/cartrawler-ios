//
//  CTPaymentSummaryViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 15/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTPaymentSummaryViewController.h"
#import "CTPaymentSummaryViewModel.h"
#import "CTPaymentSummaryCell.h"

@interface CTPaymentSummaryViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) CTPaymentSummaryViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *payAtDesk;
@property (weak, nonatomic) IBOutlet UITableView *payAtDeskTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payAtDeskHeight;
@property (weak, nonatomic) IBOutlet UIView *divider;
@property (weak, nonatomic) IBOutlet UILabel *payNow;
@property (weak, nonatomic) IBOutlet UITableView *payNowTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payNowHeight;
@property (weak, nonatomic) IBOutlet UIView *divider2;
@property (weak, nonatomic) IBOutlet UILabel *payableNow;
@property (weak, nonatomic) IBOutlet UILabel *total;

@end

@implementation CTPaymentSummaryViewController

+ (Class)viewModelClass {
    return CTPaymentSummaryViewModel.class;
}

- (void)updateWithViewModel:(CTPaymentSummaryViewModel *)viewModel {
    self.viewModel = viewModel;
    self.payAtDeskHeight.constant = viewModel.payAtDeskRowViewModels.count * 20;
    self.payNowHeight.constant = viewModel.payNowRowViewModels.count * 20;
    self.payAtDeskTableView.backgroundColor = [UIColor clearColor];
    self.payNowTableView.backgroundColor = [UIColor clearColor];
    [self.view layoutIfNeeded];
    [self.payAtDeskTableView reloadData];
    [self.payNowTableView reloadData];
    self.total.text = viewModel.total;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.payAtDeskTableView) {
        return self.viewModel.payAtDeskRowViewModels.count;
    }
    if (tableView == self.payNowTableView) {
        return self.viewModel.payNowRowViewModels.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 21;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CTPaymentSummaryCell *cell = [self.payAtDeskTableView dequeueReusableCellWithIdentifier:@"PaymentSummaryCell"];
    
    cell.backgroundColor = [UIColor clearColor];
    CTPaymentSummaryCellModel *cellModel;
    if (tableView == self.payAtDeskTableView) {
        cellModel = self.viewModel.payAtDeskRowViewModels[indexPath.row];
    }
    if (tableView == self.payNowTableView) {
        cellModel = self.viewModel.payNowRowViewModels[indexPath.row];
    }
    [cell updateWithViewModel:cellModel];
    
    return cell;
}

@end
