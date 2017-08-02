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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchSplashBottomConstraint;
@property (nonatomic, weak) CTSearchFormViewController *searchFormVC;
@property (weak, nonatomic) IBOutlet UIView *searchFormContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchFormHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchFormBottomConstraint;
@property (nonatomic, weak) CTSearchLocationsViewController *searchLocationsVC;
@property (nonatomic, weak) CTSearchCalendarViewController *searchCalendarVC;
@property (nonatomic, weak) CTSearchSettingsViewController *searchSettingsVC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraintUSP;
@end

@implementation CTSearchViewController

+ (Class)viewModelClass {
    return CTSearchViewModel.class;
}

- (void)updateWithViewModel:(CTSearchViewModel *)viewModel {
    self.viewModel = viewModel;
    
    self.navigationController.navigationBar.barTintColor = viewModel.navigationBarColor;
    
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
    
    switch (viewModel.contentView) {
        case CTSearchContentViewSplash:
            self.searchSplashContainerView.hidden = NO;
            self.searchFormContainerView.hidden = YES;
            //self.searchSplashBottomConstraint.priority = 1000;
            //self.searchFormBottomConstraint.priority = 250;
            self.topConstraintUSP.constant = [self.searchSplashContainerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            break;
        case CTSearchContentViewForm:
            self.searchSplashContainerView.hidden = YES;
            self.searchFormContainerView.hidden = NO;
            //self.searchFormBottomConstraint.priority = 1000;
            //self.searchSplashBottomConstraint.priority = 250;
            self.searchFormHeightConstraint.constant = [self.searchFormVC.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            self.topConstraintUSP.constant = [self.searchFormVC.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
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

- (IBAction)closeButtonTapped:(id)sender {
    [CTAppController dispatchAction:CTActionSearchUserDidTapCloseButton payload:nil];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}

@end
