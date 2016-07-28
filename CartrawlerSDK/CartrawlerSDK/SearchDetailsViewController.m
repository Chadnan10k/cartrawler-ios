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
#import "LocationSearchViewController.h"
#import "CTCalendarViewController.h"
#import "DateUtils.h"
#import "CTTimePickerView.h"
#import "CTTextField.h"
#import "CTViewManager.h"

#define kSearchViewStoryboard @"StepOne"

@interface SearchDetailsViewController () <CTCalendarDelegate>

@property (weak, nonatomic) IBOutlet UIView *pickupContainer;
@property (weak, nonatomic) IBOutlet UIView *dropoffContainer;
@property (weak, nonatomic) IBOutlet UIView *pickupTimeContainer;
@property (weak, nonatomic) IBOutlet UIView *dropoffTimeContainer;
@property (weak, nonatomic) IBOutlet UIView *calendarContainer;
@property (weak, nonatomic) IBOutlet CTTextField *ageContainer;
@property (weak, nonatomic) IBOutlet UIView *sameLocationCheckBox;
@property (weak, nonatomic) IBOutlet UIView *ageCheckBoxContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropoffLocTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ageTopConstraint;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property (strong, nonatomic) UIView *activeView;

@property (strong, nonatomic) CTSelectView *pickupView;
@property (strong, nonatomic) CTSelectView *dropoffView;
@property (strong, nonatomic) CTSelectView *calendarView;
@property (strong, nonatomic) CTSelectView *dropoffTimeView;
@property (strong, nonatomic) CTSelectView *pickupTimeView;

@property (strong, nonatomic) CTTimePickerView *pickupTimePicker;
@property (strong, nonatomic) CTTimePickerView *dropoffTimePicker;

@property (nonatomic, strong) NSDate *pickupTime;
@property (nonatomic, strong) NSDate *dropoffTime;

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
    
    [self registerForKeyboardNotifications];
    
    [self.search setDriverAge:@30];
    [self.search setPassengerQty:@3];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *initialTimeComp = [gregorianCalendar components:NSHourCalendarUnit
                                                             fromDate:[NSDate date]];
    
    [initialTimeComp setHour:10];
    
    _pickupTime = [gregorianCalendar dateFromComponents:initialTimeComp];
    _dropoffTime = [gregorianCalendar dateFromComponents:initialTimeComp];
    
    _pickupTimePicker = [[CTTimePickerView alloc] initInView:self.view mininumDate:nil];
    _dropoffTimePicker = [[CTTimePickerView alloc] initInView:self.view mininumDate:nil];

    _isReturningSameLocation = YES;
    
    __weak typeof (self) weakSelf = self;
    
    self.pickupView = [[CTSelectView alloc] initWithView:self.pickupContainer placeholder:@"Pick-up location"];
    self.pickupView.viewTapped = ^{
        
        [weakSelf.view endEditing:YES];
        
        _activeView = self.pickupView;

        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:bundle];
        LocationSearchViewController *locSearchVC = [storyboard instantiateViewControllerWithIdentifier:@"LocationSearchViewController"];
        locSearchVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [weakSelf presentViewController:locSearchVC animated:YES completion:nil];
        
        locSearchVC.selectedLocation = ^(__weak CTMatchedLocation *location){
            [weakSelf.pickupView setTextFieldText:location.name];
            [weakSelf.search setPickupLocation:location];
            
            if (weakSelf.isReturningSameLocation) {
                [weakSelf.search setDropoffLocation:location];
            }
        };
    };
    
    self.dropoffView = [[CTSelectView alloc] initWithView:self.dropoffContainer placeholder:@"Drop-off location"];
    self.dropoffView.viewTapped = ^{
        
        [weakSelf.view endEditing:YES];
        
        _activeView = self.pickupView;

        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:bundle];
        LocationSearchViewController *locSearchVC = [storyboard instantiateViewControllerWithIdentifier:@"LocationSearchViewController"];
        [weakSelf presentViewController:locSearchVC animated:YES completion:nil];
        
        locSearchVC.selectedLocation = ^(__weak CTMatchedLocation *location){
            [weakSelf.dropoffView setTextFieldText:location.name];
            [weakSelf.search setDropoffLocation:location];
        };
    };

    _activeView = self.pickupView;
    
    
    
    _pickupTimeView = [[CTSelectView alloc] initWithView:self.pickupTimeContainer placeholder:@"Pick-up time"];
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
    
    _dropoffTimeView = [[CTSelectView alloc] initWithView:self.dropoffTimeContainer placeholder:@"Drop-off time"];
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
    
    _calendarView = [[CTSelectView alloc] initWithView:self.calendarContainer placeholder:@"Select dates"];
    self.calendarView.viewTapped = ^{
        _activeView = self.calendarView;

        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:bundle];
        CTCalendarViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CTCalendarViewController"];
        vc.delegate = weakSelf;
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };
    
    CTCheckbox *sameLoc = [[CTCheckbox alloc] initEnabled:YES containerView:self.sameLocationCheckBox ];
    sameLoc.viewTapped = ^(BOOL selection) {
        if (selection) {
            _isReturningSameLocation = NO;
            [weakSelf.search setDropoffLocation:self.search.pickupLocation];
            self.dropoffLocTopConstraint.constant = 15;
            [UIView animateWithDuration:0.3 animations:^{
                self.dropoffContainer.alpha = 0;
                [self.view layoutIfNeeded];
            }];
        } else {
            _isReturningSameLocation = YES;
            [weakSelf.search setDropoffLocation:nil];
            [weakSelf.dropoffView setTextFieldText:@""];
            self.dropoffLocTopConstraint.constant = 80;
            [UIView animateWithDuration:0.3 animations:^{
                self.dropoffContainer.alpha = 1;
                [self.view layoutIfNeeded];
            }];
        }
        _activeView = sameLoc;
    };
    
    
    CTCheckbox *ageCheckbox = [[CTCheckbox alloc] initEnabled:YES containerView:self.ageCheckBoxContainer];
    ageCheckbox.viewTapped = ^(BOOL selection) {
        if (selection) {
            
            [weakSelf.view endEditing:YES];
            weakSelf.driverUnderage = NO;
            weakSelf.search.driverAge = @30;
            self.ageTopConstraint.constant = 0;
            [UIView animateWithDuration:0.3 animations:^{
                self.ageContainer.alpha = 0;
                [self.view layoutIfNeeded];
            }];
        } else {
            weakSelf.driverUnderage = YES;
            self.ageTopConstraint.constant = 50;
           [UIView animateWithDuration:0.3 animations:^{
               self.ageContainer.alpha = 1;
               [self.view layoutIfNeeded];
           }];
        }
    };
    
    self.dropoffLocTopConstraint.constant = 15;
    self.dropoffContainer.alpha = 0;
    
    self.ageTopConstraint.constant = 0;
    self.ageContainer.alpha = 0;
    
    [self.view layoutIfNeeded];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.scrollView setContentOffset:
     CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
}

#pragma mark Calendar delegate

- (void)didPickDates:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate
{
    NSString *dateString = [NSString stringWithFormat:@"%@ - %@",
                            [DateUtils shortDescriptionFromDate:pickupDate],
                            [DateUtils shortDescriptionFromDate:dropoffDate]];
    
    [self.calendarView setTextFieldText:dateString];
    
    [self.search setPickupDate:pickupDate];
    [self.search setDropoffDate:dropoffDate];
}

- (void)combineDates
{
    NSDate *puDate = [DateUtils mergeTimeWithDateWithTime:self.pickupTime dateWithDay:self.search.pickupDate];
    NSDate *doDate = [DateUtils mergeTimeWithDateWithTime:self.dropoffTime dateWithDay:self.search.dropoffDate];

    [self.search setPickupDate:puDate];
    [self.search setDropoffDate:doDate];
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
        
        self.searchDetailsCompletion = ^(BOOL success, NSString *errorMessage)
        {
            if (success) {
                [weakSelf.activityView stopAnimating];
                button.enabled = YES;
                button.alpha = 1.0;
            } else {
                [weakSelf.activityView stopAnimating];
                button.enabled = YES;
                button.alpha = 1.0;
                if (errorMessage) {
                    [weakSelf presentAlertWithError:errorMessage];
                }
            }
        };
        
        [self pushToDestination];
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
    NSDictionary* userInfo = [n userInfo];

    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    CGRect viewFrame = self.scrollView.frame;
    viewFrame.size.height += (keyboardSize.height + 45);

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *)n
{

    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.scrollView.frame;

    viewFrame.size.height -= (keyboardSize.height + 45);

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
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

- (void)pushToDestination
{
    [CTViewManager canTransitionToVehicleSelection:self.cartrawlerAPI completion:^(BOOL success, NSString *errorMessage) {
        if (success && errorMessage == nil) {
            if (self.searchDetailsCompletion) {
                self.searchDetailsCompletion(YES, nil);
            }
            [self.navigationController pushViewController:self.destinationViewController animated:YES];
            [self.destinationViewController refresh];
        } else {
            if (self.searchDetailsCompletion) {
                self.searchDetailsCompletion(NO, errorMessage);
            }
        }
    }];
}

@end
