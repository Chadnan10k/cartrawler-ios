//
//  LocationSearchViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 08/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTLocationSearchViewController.h"
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "LocationSearchDataSource.h"
#import "CTAppearance.h"
@interface CTLocationSearchViewController () <UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray <CTMatchedLocation *> *airportLocations;
@property (nonatomic, strong) NSArray <CTMatchedLocation *> *otherLocations;
@property (nonatomic, strong) LocationSearchDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@end

@implementation CTLocationSearchViewController


{
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //self.tableView.alpha = 0;
    
    self.headerView.backgroundColor = [CTAppearance instance].navigationBarColor;
    
    _dataSource = [[LocationSearchDataSource alloc] init];
    self.dataSource.enableGroundTransportLocations = self.enableGroundTransportLocations;
    self.dataSource.invertData = self.invertData;
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    self.searchBar.delegate = self;
    self.searchBar.text = @"";
    
    (self.searchBar).backgroundImage = [UIImage new];

    [self.searchBar becomeFirstResponder];
    
    for (UIView *subview in self.searchBar.subviews)
    {
        for (UIView *subSubview in subview.subviews)
        {
            if ([subSubview conformsToProtocol:@protocol(UITextInputTraits)])
            {
                UITextField *textField = (UITextField *)subSubview;
                textField.returnKeyType = UIReturnKeyDone;
                textField.font = [UIFont fontWithName:[CTAppearance instance].fontName size:14];
                textField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
                break;
            }
        }
    }
    __weak typeof(self) weakSelf = self;
    
    self.dataSource.selectedLocation = ^(CTMatchedLocation *selectedLocation) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.selectedLocation != nil) {
                weakSelf.selectedLocation(selectedLocation);
                [weakSelf.view endEditing:YES];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }
        });
    };
}

- (IBAction)closeTapped:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.dataSource updateData:searchText completion:^(BOOL didSucceed) {
        if (didSucceed) {
            [self.tableView reloadData];
//            [UIView animateWithDuration:0.2 animations:^{
//                self.tableView.alpha = 1;
//            }];
        } else {
//            [UIView animateWithDuration:0.2 animations:^{
//                self.tableView.alpha = 0;
//            }];
        }
    }];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    return true;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}

@end
