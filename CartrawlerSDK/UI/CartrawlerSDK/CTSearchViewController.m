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
#import "CTAlertViewController.h"
#import "CTAppController.h"

@interface CTSearchViewController ()
@property (nonatomic, weak) CTSearchSplashViewController *searchSplashVC;
@property (weak, nonatomic) IBOutlet UIView *searchSplashContainerView;
@property (nonatomic, weak) CTSearchFormViewController *searchFormVC;
@property (weak, nonatomic) IBOutlet UIView *searchFormContainerView;
@property (nonatomic, weak) CTSearchLocationsViewController *searchLocationsVC;
@property (nonatomic, weak) CTSearchCalendarViewController *searchCalendarVC;
@property (nonatomic, weak) CTAlertViewController *timePickerController;
@end

@implementation CTSearchViewController

- (void)updateWithViewModel:(CTSearchViewModel *)viewModel {
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
        case CTSearchSupplementaryViewTimePicker:
            if (!self.timePickerController) {
                [self presentTimePickerForViewModel:viewModel];
            }
        default:
            break;
    }
    
    [self.searchFormVC updateWithViewModel:viewModel.searchFormViewModel];
    [self.searchLocationsVC updateWithViewModel:viewModel.searchLocationsViewModel];
    [self.searchCalendarVC updateWithViewModel:viewModel.searchCalendarViewModel];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SearchSplash"]) {
        self.searchSplashVC = segue.destinationViewController;
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
}

- (void)presentTimePickerForViewModel:(CTSearchViewModel *)viewModel {
    UIDatePicker *datePicker = [UIDatePicker new];
    datePicker.datePickerMode = UIDatePickerModeTime;
    datePicker.minuteInterval = 15;
    datePicker.locale = [NSLocale currentLocale];
    datePicker.date = viewModel.defaultPickerTime;
    
    self.timePickerController = [CTAlertViewController alertControllerWithTitle:@"" message:nil];
    self.timePickerController.backgroundTapDismissalGestureEnabled = YES;
    self.timePickerController.customView = datePicker;
    
    CTAlertAction *cancelAction = [CTAlertAction actionWithTitle:@"Cancel"
                                                         handler:^(CTAlertAction *action) {
                                                             [CTAppController dispatchAction:CTActionSearchTimePickerUserDidSelectCancel payload:nil];
                                                         }];
    
    CTAlertAction *okAction = [CTAlertAction actionWithTitle:@"Done"
                                                     handler:^(CTAlertAction *action) {
                                                         [CTAppController dispatchAction:CTActionSearchTimePickerUserDidSelectTime payload:datePicker.date];
                                                     }];
    
    [self.timePickerController addAction:cancelAction];
    [self.timePickerController addAction:okAction];
    
    [self presentViewController:self.timePickerController animated:YES completion:nil];
}

@end
