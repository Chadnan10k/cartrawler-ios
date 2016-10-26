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
#import "DateUtils.h"
#import "CTTimePickerView.h"
#import "CTTextField.h"
#import "CTInterstitialViewController.h"
#import "CTToolTip.h"

#define kSearchViewStoryboard @"StepOne"

#define kDropoffLocationOpen 94.0
#define kDropoffLocationClosed 18.0

#define kAgeOpen 67.0
#define kAgeClosed 16.0

@interface SearchDetailsViewController () <CTCalendarDelegate>

@property (weak, nonatomic) IBOutlet CTTextField *ageContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropoffLocTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ageTopConstraint;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

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

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
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
    
    __weak typeof (self) weakSelf = self;
    
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
    [self.pickupTimeView setTextFieldText:[DateUtils stringFromDate:self.pickupTime withFormat:@"hh:mm a"]];

    self.pickupTimeView.viewTapped = ^{
        
        [weakSelf.view endEditing:YES];
        
        _activeView = self.pickupTimeView;
        [weakSelf.pickupTimePicker present];
        [weakSelf.dropoffTimePicker hide];
        weakSelf.pickupTimePicker.timeSelection = ^(NSDate *date){
            _pickupTime = date;
            [weakSelf.pickupTimeView setTextFieldText:[DateUtils stringFromDate:date withFormat:@"hh:mm a"]];
        };
    };
    
    self.dropoffTimeView.placeholder = @"Drop-off time";
    [self.dropoffTimeView setTextFieldText:[DateUtils stringFromDate:self.dropoffTime withFormat:@"hh:mm a"]];
    self.dropoffTimeView.viewTapped = ^{
        
        [weakSelf.view endEditing:YES];
        
        _activeView = weakSelf.dropoffTimeView;
        [weakSelf.dropoffTimePicker present];
        [weakSelf.pickupTimePicker hide];
        weakSelf.dropoffTimePicker.timeSelection = ^(NSDate *date){
            _dropoffTime = date;
            [weakSelf.dropoffTimeView setTextFieldText:[DateUtils stringFromDate:date withFormat:@"hh:mm a"]];
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
        [self.pickupTimeView setTextFieldText:[DateUtils stringFromDate:self.search.pickupDate withFormat:@"hh:mm a"]];
        [self.dropoffTimeView setTextFieldText:[DateUtils stringFromDate:self.search.dropoffDate withFormat:@"hh:mm a"]];
    }
    
    if (self.search.driverAge.intValue == 0) {
        self.ageContainer.text = @"";
        self.search.driverAge = @30;
    }
    
    [self.calendar reset];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CTToolTip *tt = [[CTToolTip alloc] initWithFrame:self.view.frame];
    [tt presentForView:self.pickupTimeView text:@"This is a tool tip and it is very snazzy, dismiss it by tapping anywhere" presentFrom:CTToolTipPresentationLeft];
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
                                [DateUtils shortDescriptionFromDate:pickupDate],
                                [DateUtils shortDescriptionFromDate:dropoffDate]];
        
        [self.calendarView setTextFieldText:dateString];
    } else {
        [self.calendarView setTextFieldText:@""];
    }
}

- (void)setDefaultPickupDropoffTimes
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *initialTimeComp = [gregorianCalendar components:NSHourCalendarUnit
                                                             fromDate:[NSDate date]];
    initialTimeComp.hour = 10;
    
    _pickupTime = [gregorianCalendar dateFromComponents:initialTimeComp];
    _dropoffTime = [gregorianCalendar dateFromComponents:initialTimeComp];
    [self.pickupTimeView setTextFieldText:[DateUtils stringFromDate:self.pickupTime withFormat:@"hh:mm a"]];
    [self.dropoffTimeView setTextFieldText:[DateUtils stringFromDate:self.dropoffTime withFormat:@"hh:mm a"]];
}

- (void)combineDates
{
    NSDate *puDate = [DateUtils mergeTimeWithDateWithTime:self.pickupTime dateWithDay:self.search.pickupDate];
    NSDate *doDate = [DateUtils mergeTimeWithDateWithTime:self.dropoffTime dateWithDay:self.search.dropoffDate];

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

- (IBAction)searchTapped:(id)sender
{
    
    if([self validate]) {
        [self.activityView startAnimating];
        [self combineDates];
        UIButton *button = (UIButton *)sender;
        button.enabled = NO;
        button.alpha = 0.8;
        
        __weak typeof (self) weakSelf = self;
        
        self.dataValidationCompletion = ^(BOOL success, NSString *errorMessage) {
            [CTInterstitialViewController dismiss];
            [weakSelf.activityView stopAnimating];
            button.enabled = YES;
            button.alpha = 1.0;
            
            if (!success && errorMessage) {
                [weakSelf presentAlertWithError:errorMessage];
            }
        };
        
        [self pushToDestination];
        [CTInterstitialViewController present:self];
        
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
    [self dismissViewControllerAnimated:YES completion:nil];
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
