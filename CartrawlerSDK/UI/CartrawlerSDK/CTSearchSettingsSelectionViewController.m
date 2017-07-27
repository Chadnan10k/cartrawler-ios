//
//  SelectCountryViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSearchSettingsSelectionViewController.h"
//#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTLabel.h>
//#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CTButton.h>
#import "CTSearchSettingsSelectionViewModel.h"
#import "CTCSVItem.h"
#import "CTAppController.h"

@interface CTSearchSettingsSelectionViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) CTSearchSettingsSelectionViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;
@property (weak, nonatomic) IBOutlet CTButton *backButton;
@end

@implementation CTSearchSettingsSelectionViewController

- (void)updateWithViewModel:(CTSearchSettingsSelectionViewModel *)viewModel {
    self.viewModel = viewModel;
    self.navigationItem.title = viewModel.title;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.rowViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    CTCSVItem *item = self.viewModel.rowViewModels[indexPath.row];
    cell.textLabel.text = item.displayName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CTCSVItem *item = self.viewModel.rowViewModels[indexPath.row];
    [CTAppController dispatchAction:CTActionSearchSettingsDetailsUserDidSelectItem payload:item];
}

- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {
    [CTAppController dispatchAction:CTActionSearchSettingsDetailsUserDidTapCancelButton payload:nil];
}

@end
