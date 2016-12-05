//
//  SearchDetailViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 03/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "SearchDetailsViewController.h"
#import "CTSelectView.h"
#import "CTCheckbox.h"
#import "CTLocationSearchViewController.h"
#import "CTCalendarViewController.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CTTimePickerView.h"
#import "CTTextField.h"
#import "CTInterstitialViewController.h"
#import "CTToolTip.h"
#import "CTNextButton.h"
#import "LocalisedStrings.h"
#import "CartrawlerSDK+UITextField.h"

#define kSearchViewStoryboard @"StepOne"

#define kDropoffLocationOpen 101.0
#define kDropoffLocationClosed 18.0

#define kAgeOpen 67.0
#define kAgeClosed 16.0

@interface SearchDetailsViewController () <CTCalendarDelegate>

@property (weak, nonatomic) IBOutlet CTNextButton *nextButton;
@property (weak, nonatomic) IBOutlet CTTextField *ageContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropoffLocTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ageTopConstraint;

@property (strong, nonatomic) UIView *activeView;

@property (strong, nonatomic) IBOutlet CTSelectView *pickupView;
@property (strong, nonatomic) IBOutlet CTSelectView *dropoffView;
@property (strong, nonatomic) IBOutlet CTSelectView *calendarView;
@property (strong, nonatomic) IBOutlet CTSelectView *dropoffTimeView;
@property (strong, nonatomic) IBOutlet CTSelectView *pickupTimeView;

@property (strong, nonatomic) CTTimePickerView *pickupTimePicker;
@property (strong, nonatomic) CTTimePickerView *dropoffTimePicker;

@property (nonatomic, strong) NSDate *pickupTime;
@property (nonatomic, strong) NSDate *dropoffTime;

@property (nonatomic, strong) CTLocationSearchViewController *locSearchVC;
@property (nonatomic, strong) CTCalendarViewController *calendar;

@property (readwrite, nonatomic) BOOL isReturningSameLocation;
@property (readwrite, nonatomic) BOOL driverUnderage;

@end

@implementation SearchDetailsViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;

    [self.nextButton setText:NSLocalizedString(@"Search for cars", @"Search for cars") didTap:^{
        [weakSelf searchTapped];
    }];
    
    [self.ageContainer addDoneButton];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:bundle];
    
    _locSearchVC = (CTLocationSearchViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LocationSearchViewController"];
    self.locSearchVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    _calendar = [storyboard instantiateViewControllerWithIdentifier:@"CTCalendarViewController"];
    self.calendar.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.calendar.delegate = self;
    
    [self registerForKeyboardNotifications];
    
    self.search.driverAge = @30;
    self.search.passengerQty = @1;
        
    _pickupTimePicker = [[CTTimePickerView alloc] initInView:self.view mininumDate:nil];
    _dropoffTimePicker = [[CTTimePickerView alloc] initInView:self.view mininumDate:nil];

    _isReturningSameLocation = YES;
    
    self.pickupView.placeholder = @"Pick-up location";
    self.pickupView.viewTapped = ^{
        
        [weakSelf.view endEditing:YES];
        _activeView = self.pickupView;

        [weakSelf presentViewController:weakSelf.locSearchVC animated:YES completion:nil];
        
        weakSelf.locSearchVC.selectedLocation = ^(__weak CTMatchedLocation *location){
            [weakSelf.pickupView setTextFieldText:location.name];
            weakSelf.search.pickupLocation = location;
            
            if (weakSelf.isReturningSameLocation || weakSelf.search.dropoffLocation == nil) {
                weakSelf.search.dropoffLocation = location;
            }
        };
    };
    
    self.dropoffView.placeholder = @"Drop-off location";
    self.dropoffView.viewTapped = ^{
        
        [weakSelf.view endEditing:YES];
        
        _activeView = self.pickupView;
        [weakSelf presentViewController:weakSelf.locSearchVC animated:YES completion:nil];

        weakSelf.locSearchVC.selectedLocation = ^(__weak CTMatchedLocation *location){
            [weakSelf.dropoffView setTextFieldText:location.name];
            (weakSelf.search).dropoffLocation = location;
        };
    };

    _activeView = self.pickupView;
    
    self.pickupTimeView.placeholder = @"Pick-up time";
    [self.pickupTimeView setTextFieldText:[self.pickupTime simpleTimeString]];

    self.pickupTimeView.viewTapped = ^{
        
        [weakSelf.view endEditing:YES];
        
        _activeView = self.pickupTimeView;
        [weakSelf.pickupTimePicker present];
        [weakSelf.dropoffTimePicker hide];
        weakSelf.pickupTimePicker.timeSelection = ^(NSDate *date){
            _pickupTime = date;
            [weakSelf.pickupTimeView setTextFieldText:[date simpleTimeString]];
        };
    };
    
    self.dropoffTimeView.placeholder = @"Drop-off time";
    [self.dropoffTimeView setTextFieldText:[self.dropoffTime simpleTimeString]];
    self.dropoffTimeView.viewTapped = ^{
        
        [weakSelf.view endEditing:YES];
        
        _activeView = weakSelf.dropoffTimeView;
        [weakSelf.dropoffTimePicker present];
        [weakSelf.pickupTimePicker hide];
        weakSelf.dropoffTimePicker.timeSelection = ^(NSDate *date){
            _dropoffTime = date;
            [weakSelf.dropoffTimeView setTextFieldText:[date simpleTimeString]];
        };
    };
    
    self.calendarView.placeholder = @"Select dates";
    self.calendarView.viewTapped = ^{
        _activeView = self.calendarView;
        [weakSelf presentViewController:weakSelf.calendar animated:YES completion:nil];
    };

    self.dropoffLocTopConstraint.constant = kDropoffLocationClosed;
    self.dropoffView.alpha = 0;
    
    self.ageTopConstraint.constant = kAgeClosed;
    self.ageContainer.alpha = 0;
    
    [self.view layoutIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.scrollView setContentOffset:
     CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
    
    if (!self.search.pickupLocation) {
        [self.pickupView setTextFieldText:@""];
    } else {
        [self.pickupView setTextFieldText:self.search.pickupLocation.name];
    }
    
    if (!self.search.pickupDate) {
        [self.calendarView setTextFieldText:@""];
        [self setDefaultPickupDropoffTimes];
    } else if (self.search.dropoffDate && self.search.pickupDate) {
        [self setDateString:self.search.pickupDate dropoffDate:self.search.dropoffDate];
        _pickupTime = self.search.pickupDate;
        _dropoffTime = self.search.dropoffDate;
        [self.pickupTimeView setTextFieldText:[self.search.pickupDate  simpleTimeString]];
        [self.dropoffTimeView setTextFieldText:[self.search.dropoffDate simpleTimeString]];
    }
    
    if (self.search.driverAge.intValue == 0) {
        self.ageContainer.text = @"";
        self.search.driverAge = @30;
    }
    
    [self.calendar reset];
}

- (IBAction)sameLocation:(id)sender {
    BOOL selection = ((UISwitch *)sender).isOn;
    if (selection) {
        _isReturningSameLocation = NO;
        (self.search).dropoffLocation = self.search.pickupLocation;
        self.dropoffLocTopConstraint.constant = kDropoffLocationClosed;
        [UIView animateWithDuration:0.3 animations:^{
            self.dropoffView.alpha = 0;
            [self.view layoutIfNeeded];
        }];
    } else {
        _isReturningSameLocation = YES;
        [self.search setDropoffLocation:nil];
        [self.dropoffView setTextFieldText:@""];
        self.dropoffLocTopConstraint.constant = kDropoffLocationOpen;
        [UIView animateWithDuration:0.3 animations:^{
            self.dropoffView.alpha = 1;
            [self.view layoutIfNeeded];
        }];
    }
}

- (IBAction)driverAge:(id)sender {
    BOOL selection = ((UISwitch *)sender).isOn;
    if (selection) {
        [self.view endEditing:YES];
        self.driverUnderage = NO;
        self.search.driverAge = @30;
        self.ageTopConstraint.constant = kAgeClosed;
        [UIView animateWithDuration:0.3 animations:^{
            self.ageContainer.alpha = 0;
            [self.view layoutIfNeeded];
        }];
    } else {
        self.driverUnderage = YES;
        self.ageTopConstraint.constant = kAgeOpen;
       [UIView animateWithDuration:0.3 animations:^{
           self.ageContainer.alpha = 1;
           [self.view layoutIfNeeded];
       }];
    }
}

#pragma mark Calendar delegate

- (void)didPickDates:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate
{
    self.search.pickupDate = pickupDate;
    self.search.dropoffDate = dropoffDate;
    [self setDateString:self.search.pickupDate dropoffDate:self.search.dropoffDate];
}

- (void)setDateString:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate
{
    if (pickupDate && dropoffDate) {
        NSString *dateString = [NSString stringWithFormat:@"%@ - %@",
                                [pickupDate shortDescriptionFromDate],
                                [dropoffDate shortDescriptionFromDate]];
        
        [self.calendarView setTextFieldText:dateString];
    } else {
        [self.calendarView setTextFieldText:@""];
    }
}

- (void)setDefaultPickupDropoffTimes
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *initialTimeComp = [gregorianCalendar components:NSCalendarUnitHour
                                                             fromDate:[NSDate date]];
    initialTimeComp.hour = 10;
    
    _pickupTime = [gregorianCalendar dateFromComponents:initialTimeComp];
    _dropoffTime = [gregorianCalendar dateFromComponents:initialTimeComp];
    [self.pickupTimeView setTextFieldText:[self.pickupTime simpleTimeString]];
    [self.dropoffTimeView setTextFieldText:[self.dropoffTime simpleTimeString]];
}

- (void)combineDates
{
    NSDate *puDate = [NSDate mergeTimeWithDateWithTime:self.pickupTime dateWithDay:self.search.pickupDate];
    NSDate *doDate = [NSDate mergeTimeWithDateWithTime:self.dropoffTime dateWithDay:self.search.dropoffDate];

    (self.search).pickupDate = puDate;
    (self.search).dropoffDate = doDate;
}

- (BOOL)validate
{
    
    BOOL validated = YES;
    
    if (self.search.pickupLocation == nil) {
        [self.pickupView shakeAnimation];
        validated = NO;
    }
    
    if (self.search.dropoffLocation == nil) {
        [self.dropoffView shakeAnimation];
        validated = NO;
    }
    
    if (self.search.pickupDate == nil || self.search.dropoffDate == nil) {
        [self.calendarView shakeAnimation];
        validated = NO;
    }
    
    if (self.driverUnderage) {
        NSNumberFormatter *d = [NSNumberFormatter new];
        self.search.driverAge = [d numberFromString:self.ageContainer.text];
    }
    
    if (self.search.driverAge == nil) {
        [self.ageContainer shakeAnimation];
        validated = NO;
    }
    
    return validated;
}

- (void)performSearch
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self searchTapped];
    });
}

- (void)searchTapped
{
    if([self validate]) {
        [self combineDates];
        self.nextButton.userInteractionEnabled = NO;
        self.nextButton.alpha = 0.8;
        
        __weak typeof (self) weakSelf = self;
        
        self.dataValidationCompletion = ^(BOOL success, NSString *errorMessage) {
            [CTInterstitialViewController dismiss];
            weakSelf.nextButton.userInteractionEnabled = YES;
            weakSelf.nextButton.alpha = 1.0;
            
            if (!success && errorMessage) {
                [weakSelf presentAlertWithError:errorMessage];
            }
        };
        
        [self pushToDestination];
        [CTInterstitialViewController present:self search:self.search];
    }
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)deregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = n.userInfo;

    CGSize keyboardSize = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    CGRect viewFrame = self.scrollView.frame;
    viewFrame.size.height += (keyboardSize.height);

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.scrollView.frame = viewFrame;
    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *)n
{

    NSDictionary* userInfo = n.userInfo;
    CGSize keyboardSize = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.scrollView.frame;

    viewFrame.size.height -= (keyboardSize.height);

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.scrollView.frame = viewFrame;
    [UIView commitAnimations];
}

- (IBAction)cancel:(id)sender
{
    if (self.delegate) {
        [self.delegate didDismissViewController];
    }
    
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)presentAlertWithError:(NSString *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:error
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
