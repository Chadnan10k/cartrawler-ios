//
//  LocationSearchViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 08/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTLocationSearchViewController.h"
#import "CartrawlerAPI.h"
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
            [weakSelf onLocationSelection:selectedLocation];
        });
    };
    
    [self.cancelButton setTitle:CTLocalizedString(CTRentalCTACancel) forState:UIControlStateNormal];
}

- (void)onLocationSelection:(CTMatchedLocation *)selectedLocation {
    if (self.selectedLocation != nil) {
        self.selectedLocation(selectedLocation);
        [self.view endEditing:YES];
        if (self.searchContext == CTLocationSearchContextPickup) {
            [self didLeavePickupField];
            [self didEnterPickupFieldText:self.searchBar.text];
            [self didEnterPickupFieldTextLength:self.searchBar.text.length];
        }
        if (self.searchContext == CTLocationSearchContextDropoff) {
            [self didLeaveDropOffField];
            [self didEnterDropOffFieldText:self.searchBar.text];
            [self didEnterDropOffFieldTextLength:self.searchBar.text.length];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

- (IBAction)closeTapped:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.searchContext == CTLocationSearchContextPickup) {
        if (searchText.length == 1) {
            [self didTypeInPickUpSearchBar];
        }
    }
    
    if (self.searchContext == CTLocationSearchContextDropoff) {
        if (searchText.length == 1) {
            [self didTypeInDropOffSearchBar];
        }
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
    if (self.searchContext == CTLocationSearchContextPickup && self.editMode) {
        [self didLeavePickUpSearchBar];
    }
    if (self.searchContext == CTLocationSearchContextDropoff && self.editMode) {
        [self didLeaveDropOffSearchBar];
    }
    
    [self.view endEditing:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    if (self.searchContext == CTLocationSearchContextPickup) {
        [self didLeavePickUpSearchBar];
    }
    if (self.searchContext == CTLocationSearchContextDropoff) {
        [self didLeaveDropOffSearchBar];
    }
    [self.view endEditing:YES];
}

// MARK: Analytics

- (void)didLeavePickupField {
    NSString *tag = self.editMode ? @"E_Pickup" : @"ML_Pickup";
    [[CTAnalytics instance] tagScreen:tag detail:@"leave" step:nil];
}

- (void)didLeaveDropOffField {
    NSString *tag = self.editMode ? @"E_Dropoff" : @"ML_Dropoff";
    [[CTAnalytics instance] tagScreen:tag detail:@"leave" step:nil];
}

- (void)didEnterPickupFieldText:(NSString *)text {
    NSString *tag = self.editMode ? @"v_E_Picku" : @"v_ML_Picku";
    [[CTAnalytics instance] tagScreen:tag detail:text step:nil];
}

- (void)didEnterPickupFieldTextLength:(NSInteger)length {
    NSString *tag = self.editMode ? @"l_E_Picku" : @"l_ML_Picku";
    [[CTAnalytics instance] tagScreen:tag detail:@(length).stringValue step:nil];
}

- (void)didEnterDropOffFieldText:(NSString *)text {
    NSString *tag = self.editMode ? @"v_E_Dropo" : @"v_ML_Dropo";
    [[CTAnalytics instance] tagScreen:tag detail:text step:nil];
}

- (void)didEnterDropOffFieldTextLength:(NSInteger)length {
    NSString *tag = self.editMode ? @"l_E_Dropo" : @"l_ML_Dropo";
    [[CTAnalytics instance] tagScreen:tag detail:@(length).stringValue step:nil];
}

- (void)didTypeInPickUpSearchBar {
    NSString *tag = self.editMode ? @"E_Pickup" : @"ML_Pickup";
    [[CTAnalytics instance] tagScreen:tag detail:@"type" step:nil];
}

- (void)didTypeInDropOffSearchBar {
    NSString *tag = self.editMode ? @"E_Dropoff" : @"ML_Dropoff";
    [[CTAnalytics instance] tagScreen:tag detail:@"type" step:nil];
}

- (void)didEnterSearchInPickupSearchBar {
    NSString *tag = self.editMode ? @"E_Pickup" : @"ML_Pickup";
    [[CTAnalytics instance] tagScreen:tag detail:@"leave" step:nil];
}

- (void)didLeavePickUpSearchBar {
    [[CTAnalytics instance] tagScreen:@"I_E_Picku" detail:@"leave" step:nil];
}

- (void)didLeaveDropOffSearchBar {
    [[CTAnalytics instance] tagScreen:@"I_E_Dropo" detail:@"leave" step:nil];
}

@end
