//
//  LocationSearchViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 08/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTLocationSearchViewController.h"
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "CTLocationSearchDataSource.h"
#import <CartrawlerSDK/CTAppearance.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CTButton.h>
#import <CartrawlerSDK/CTAnalytics.h>
#import <CartrawlerSDK/CTSDKSettings.h>

@interface CTLocationSearchViewController () <UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray <CTMatchedLocation *> *airportLocations;
@property (nonatomic, strong) NSArray <CTMatchedLocation *> *otherLocations;
@property (nonatomic, strong) CTLocationSearchDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet CTButton *cancelButton;

@end

@implementation CTLocationSearchViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //self.tableView.alpha = 0;
    
    self.headerView.backgroundColor = [CTAppearance instance].navigationBarColor;
    
    _dataSource = [[CTLocationSearchDataSource alloc] init];
    self.dataSource.cartrawlerAPI = self.cartrawlerAPI;
    self.dataSource.enableGroundTransportLocations = self.enableGroundTransportLocations;
    self.dataSource.invertData = self.invertData;
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    self.searchBar.delegate = self;
    self.searchBar.placeholder = CTLocalizedString(CTRentalSearchLocationsPlaceholder);
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
                if (self.searchContext == CTLocationSearchContextPickup) {
                    if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
                        [[CTAnalytics instance] tagScreen:@"ML_Pickup" detail:@"leave" step:nil];
                    }
                    [[CTAnalytics instance] tagScreen:@"E_Pickup" detail:@"leave" step:nil];
                }
                if (self.searchContext == CTLocationSearchContextDropoff) {
                    if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
                        [[CTAnalytics instance] tagScreen:@"ML_Dropoff" detail:@"leave" step:nil];
                    }
                    [[CTAnalytics instance] tagScreen:@"E_Dropoff" detail:@"leave" step:nil];
                }
                
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }
        });
    };
    
    [self.cancelButton setTitle:CTLocalizedString(CTRentalCTACancel) forState:UIControlStateNormal];
}

- (IBAction)closeTapped:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.searchContext == CTLocationSearchContextPickup) {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"ML_Pickup" detail:@"type" step:nil];
            [[CTAnalytics instance] tagScreen:@"v_ML_Picku" detail:searchText step:nil];
        }
        [[CTAnalytics instance] tagScreen:@"E_Pickup" detail:@"type" step:nil];
        [[CTAnalytics instance] tagScreen:@"v_E_Picku" detail:searchText step:nil];
    }
    
    if (self.searchContext == CTLocationSearchContextDropoff) {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"ML_Dropoff" detail:@"type" step:nil];
            [[CTAnalytics instance] tagScreen:@"v_ML_Dropo" detail:searchText step:nil];
        }
        [[CTAnalytics instance] tagScreen:@"E_Dropoff" detail:@"type" step:nil];
        [[CTAnalytics instance] tagScreen:@"v_E_Dropo" detail:searchText step:nil];
        
    }
    
    if (searchText.length > 2) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [self.dataSource updateData:searchText completion:^(BOOL didSucceed) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            if (didSucceed) {
                [self.tableView reloadData];
            }
        }];
    }
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
    if (self.searchContext == CTLocationSearchContextPickup) {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"l_ML_Picku" detail:@(searchBar.text.length).stringValue step:nil];
        }
        [[CTAnalytics instance] tagScreen:@"I_E_Picku" detail:@(searchBar.text.length).stringValue step:nil];
    }
    if (self.searchContext == CTLocationSearchContextDropoff) {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"l_ML_Dropo" detail:@(searchBar.text.length).stringValue step:nil];
        }
        [[CTAnalytics instance] tagScreen:@"I_E_Dropo" detail:@(searchBar.text.length).stringValue step:nil];
    }
    
    [self.view endEditing:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    if (self.searchContext == CTLocationSearchContextPickup) {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"ML_Pickup" detail:@"leave" step:nil];
        }
        [[CTAnalytics instance] tagScreen:@"E_Pickup" detail:@"leave" step:nil];
    }
    if (self.searchContext == CTLocationSearchContextDropoff) {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"ML_Dropoff" detail:@"leave" step:nil];
        }
        [[CTAnalytics instance] tagScreen:@"E_Dropoff" detail:@"leave" step:nil];
    }
    [self.view endEditing:YES];
}

@end
