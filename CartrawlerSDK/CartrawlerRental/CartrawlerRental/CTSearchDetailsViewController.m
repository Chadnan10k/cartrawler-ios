//
//  SearchDetailViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 03/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSearchDetailsViewController.h"
#import <CartrawlerSDK/CTLayoutManager.h>
#import <CartrawlerSDK/CTNextButton.h>
#import <CartrawlerSDK/CTAlertViewController.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CTSDKSettings.h>
#import "CTRentalLocalizationConstants.h"
#import "CTInterstitialViewController.h"
#import "CTSearchView.h"
#import "CTRentalConstants.h"
#import "CTSettingsViewController.h"
#import <CartrawlerSDK/CartrawlerSDK+NSDateUtils.h>

@interface CTSearchDetailsViewController () <CTSearchViewDelegate>

@property (nonatomic, strong) CTSearchView *searchView;
@property (nonatomic, strong) CTNextButton *nextButton;

/**
 For analytics tagging, the view needs to know if it is editing a previous search
 */
@property (nonatomic, assign) BOOL editMode;
@property (nonatomic, strong) CTRentalSearch *previousSearch;

@end

@implementation CTSearchDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _nextButton = [self setupNextButton];
    _searchView = [self setupSearchView];
    
    CTLayoutManager *layoutManager = [CTLayoutManager layoutManagerWithContainer:self.view];
    [layoutManager insertView:UIEdgeInsetsMake(70, 0, 0, 0) view:self.searchView];
    [layoutManager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:self.nextButton];
    [layoutManager layoutViews];
    
    __weak typeof(self) weakSelf = self;
    self.dataValidationCompletion = ^(BOOL success, NSString *errorMessage) {
        [CTInterstitialViewController dismiss];
        if (!success && errorMessage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf displayAlertWithMessage:errorMessage];
            });
        }
    };
}

- (void)setSearch:(CTRentalSearch *)search {
    [super setSearch:search];
    self.previousSearch = [search copy];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // TODO: This is calling an empty method
    [self.searchView updateDisplayWithSearch:self.search];
    self.searchView.editMode = self.editMode;
}

- (BOOL)editMode {
    // Check if date has been set on search to see if previous search has been completed. If so, the search is now being edited
    return (self.search.pickupDate != nil);
}

- (CTSearchView *)setupSearchView
{
    CTSearchView *view = [CTSearchView new];
    view.delegate = self;
    view.cartrawlerAPI = self.cartrawlerAPI;
    view.search = self.search;
    return view;
}

- (CTNextButton *)setupNextButton
{
    CTNextButton *button = [CTNextButton new];
    [button setText:CTLocalizedString(CTRentalCTASearch)];
    [button addTarget:self action:@selector(searchTapped) forControlEvents:UIControlEventTouchUpInside];
    [button addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(100)]" options:0 metrics:nil views:@{@"button" : button}]];
    return button;
}

- (void)searchTapped
{
    if ([self.searchView validateSearch] && self.validationController) {
        if (self.previousSearch) {
            [self tagSearchUpdates];
        }
        [self pushToDestination];
        [CTInterstitialViewController present:self search:self.search];
    } else if ([self.searchView validateSearch]) {
        if (self.editMode) {
            [self tagSearchUpdates];
        }
        [CTInterstitialViewController present:self search:self.search];
        [self requestVehicles];
    }
    if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
        [[CTAnalytics instance] tagScreen:@"SearchCars" detail:@"search" step:nil];
    }
}

- (void)tagSearchUpdates {
    BOOL updated = NO;
    
    BOOL differentPickUpLocation = ![self.previousSearch.pickupLocation.code isEqualToString:self.search.pickupLocation.code];
    BOOL differentDropOffLocation = ![self.previousSearch.dropoffLocation.code isEqualToString:self.search.dropoffLocation.code];
    
    if (differentPickUpLocation || differentDropOffLocation) {
        [[CTAnalytics instance] tagScreen:@"Update_loc" detail:@"updated" step:nil];
        updated = YES;
    }
    
    BOOL differentPickUpDay = ![NSDate isDate:self.previousSearch.pickupDate inSameDayAsDate:self.previousSearch.pickupDate];
    BOOL differentDropOffDay = ![NSDate isDate:self.previousSearch.dropoffDate inSameDayAsDate:self.previousSearch.dropoffDate];
    
    if (differentPickUpDay || differentDropOffDay) {
        [[CTAnalytics instance] tagScreen:@"Update_dat" detail:@"updated" step:nil];
        updated = YES;
    }
    
    BOOL differentPickUpTime = ![NSDate isDate:self.previousSearch.pickupDate atSameTimeAsDate:self.search.pickupDate];
    BOOL differentDropOffTime = ![NSDate isDate:self.previousSearch.dropoffDate atSameTimeAsDate:self.previousSearch.dropoffDate];
    
    if (differentPickUpTime || differentDropOffTime) {
        [[CTAnalytics instance] tagScreen:@"Update_tim" detail:@"updated" step:nil];
        updated = YES;
    }
    
    if (![self.previousSearch.driverAge isEqualToNumber:self.search.driverAge]) {
        [[CTAnalytics instance] tagScreen:@"Update_age" detail:@"updated" step:nil];
        updated = YES;
    }
    
    if (updated) {
        [[CTAnalytics instance] tagScreen:@"editSearch" detail:@"update" step:nil];
    } else {
        [[CTAnalytics instance] tagScreen:@"editSearch" detail:@"exit_U" step:nil];
        [[CTAnalytics instance] tagScreen:@"editSearch" detail:@"exit" step:nil];
    }
}

- (void)displayAlertWithMessage:(NSString *)message
{
    CTAlertViewController *viewController = [CTAlertViewController alertControllerWithTitle:@"Error" message:message];
    viewController.backgroundTapDismissalGestureEnabled = YES;
    CTAlertAction *okAction = [CTAlertAction actionWithTitle:CTLocalizedString(CTRentalErrorOk)
                                                     handler:^(CTAlertAction *action) {
                                                         [viewController dismissViewControllerAnimated:YES completion:nil];
                                                     }];
    [viewController addAction:okAction];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentModalViewController:viewController];
    });
}

- (void)performSearch
{
    [self searchTapped];
}

- (IBAction)settingsTapped:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:CTRentalSearchStoryboard bundle:[NSBundle bundleForClass:[self class]]];
    CTSettingsViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:CTRentalSettingsViewIdentifier];
    [self presentModalViewController:viewController];
}

- (IBAction)backTapped:(id)sender
{
    if (self.navigationController.viewControllers.firstObject == self || !self.navigationController) {
        [[CTAnalytics instance] tagScreen:@"editSearch" detail:@"exit_X" step:nil];
        [self dismiss];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)requestVehicles
{
    __weak typeof(self) weakSelf = self;
    [self requestVehicles:^(BOOL success, NSString *errorMessage) {
        if (success) {
            [CTInterstitialViewController dismiss];
            [weakSelf dismiss];
        } else {
            [CTInterstitialViewController dismiss];
            [weakSelf displayAlertWithMessage:errorMessage];
        }
    }];
}

//MARK: CTSearchViewDelegate

- (void)didTapPresentViewController:(UIViewController *)viewController
{
    [self presentModalViewController:viewController];
}


@end
