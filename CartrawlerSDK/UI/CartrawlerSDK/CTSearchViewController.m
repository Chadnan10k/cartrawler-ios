//
//  CTSearchViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchViewController.h"
#import "CTSearchViewModel.h"
#import "CTSearchSplashViewController.h"
#import "CTSearchFormViewController.h"
#import "CTSearchLocationsViewController.h"
#import "CTSearchCalendarViewController.h"
#import "CTSearchSettingsViewController.h"
#import "CTAppController.h"

@interface CTSearchViewController ()
@property (nonatomic, strong) CTSearchViewModel *viewModel;
@property (nonatomic, weak) CTSearchSplashViewController *searchSplashVC;
@property (weak, nonatomic) IBOutlet UIView *searchSplashContainerView;
@property (nonatomic, weak) CTSearchFormViewController *searchFormVC;
@property (weak, nonatomic) IBOutlet UIView *searchFormContainerView;
@property (nonatomic, weak) CTSearchLocationsViewController *searchLocationsVC;
@property (nonatomic, weak) CTSearchCalendarViewController *searchCalendarVC;
@property (nonatomic, weak) CTSearchSettingsViewController *searchSettingsVC;
@end

@implementation CTSearchViewController

- (void)updateWithViewModel:(CTSearchViewModel *)viewModel {
    self.viewModel = viewModel;
    
    switch (viewModel.contentView) {
        case CTSearchContentViewSplash:
            self.searchSplashContainerView.hidden = NO;
            self.searchFormContainerView.hidden = YES;
            break;
        case CTSearchContentViewForm:
            self.searchSplashContainerView.hidden = YES;
            self.searchFormContainerView.hidden = NO;
            break;
        default:
            break;
    }
    
    switch (viewModel.supplementaryView) {
        case CTSearchSupplementaryViewNone:
            if (self.presentedViewController) {
                [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
            }
            break;
        case CTSearchSupplementaryViewSettings:
            if (!self.searchSettingsVC) {
                [self performSegueWithIdentifier:@"SearchSettings" sender:self];
            }
            break;
        case CTSearchSupplementaryViewSearchLocations:
            if (!self.searchLocationsVC) {
                [self performSegueWithIdentifier:@"SearchLocations" sender:self];
            }
            break;
        case CTSearchSupplementaryViewCalendar:
            if (!self.searchCalendarVC) {
                [self performSegueWithIdentifier:@"Calendar" sender:self];
            }
            break;
        default:
            break;
    }
    
    [self.searchSplashVC updateWithViewModel:viewModel.searchSplashViewModel];
    [self.searchFormVC updateWithViewModel:viewModel.searchFormViewModel];
    [self.searchLocationsVC updateWithViewModel:viewModel.searchLocationsViewModel];
    [self.searchCalendarVC updateWithViewModel:viewModel.searchCalendarViewModel];
    [self.searchSettingsVC updateWithViewModel:viewModel.searchSettingsViewModel];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SearchSplash"]) {
        self.searchSplashVC = segue.destinationViewController;
        [self.searchSplashVC updateWithViewModel:self.viewModel.searchSplashViewModel];
    }
    if ([segue.identifier isEqualToString:@"SearchForm"]) {
        self.searchFormVC = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"SearchLocations"]) {
        self.searchLocationsVC = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"Calendar"]) {
        self.searchCalendarVC = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"SearchSettings"]) {
        self.searchSettingsVC = segue.destinationViewController;
    }
}

- (IBAction)settingsButtonTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionSearchUserDidTapSettingsButton payload:nil];
}

@end
