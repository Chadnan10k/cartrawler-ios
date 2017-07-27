//
//  CTSearchLocationsViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchLocationsViewController.h"
#import "CTAppController.h"
#import "CTSearchLocationsViewModel.h"

@interface CTSearchLocationsViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) CTSearchLocationsViewModel *viewModel;
@end

@implementation CTSearchLocationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchBar becomeFirstResponder];
}

- (void)updateWithViewModel:(CTSearchLocationsViewModel *)viewModel {
    self.viewModel = viewModel;
    self.searchBar.placeholder = viewModel.searchBarPlaceholder;
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [CTAppController dispatchAction:CTActionSearchLocationsUserDidEnterCharacters payload:searchText];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [CTAppController dispatchAction:CTActionSearchLocationsUserDidTapCancel payload:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.sectionTitles.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.viewModel.sectionTitles[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.rows[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Extract String
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                           reuseIdentifier:CellIdentifier] ;
    }
    
    CTMatchedLocation *location = self.viewModel.rows[indexPath.section][indexPath.row];
    cell.textLabel.text = location.name;
    // TODO: Extract logic to view model and localise
    cell.detailTextLabel.text = location.isAtAirport ? @"Airport" : @"City Location";
    
    CGRect frame = CGRectMake(0, 0, 15, 15);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"V5-Mobile" size:16];
    label.text = location.isAtAirport ? @"" : @"";
    cell.accessoryView = label;
    [cell.accessoryView setFrame:frame];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [CTAppController dispatchAction:CTActionSearchLocationsUserDidTapLocation payload:self.viewModel.rows[indexPath.section][indexPath.row]];
}

@end
