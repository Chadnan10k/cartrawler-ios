//
//  GroundTransportViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 14/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GroundTransportViewController.h"
#import "JVFloatLabeledTextField.h"
#import "CTSelectView.h"
#import "CTTimePickerView.h"
#import "LocationSearchViewController.h"
#import <CartrawlerAPI/CTGroundLocation.h>
#import "CTCalendarViewController.h"
#import "DateUtils.h"
#import "CTCheckbox.h"
#import "CTTextField.h"
#import "CTSDKSettings.h"
#import "GroundServicesViewController.h"

@interface GroundTransportViewController () <CTCalendarDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *returnTripConstraint;
@property (weak, nonatomic) IBOutlet UIView *returnTripContainer;

@property (weak, nonatomic) IBOutlet CTCheckbox *sameLocationCheckBox;
@property (weak, nonatomic) IBOutlet CTTextField *passengersTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIView *activeView;

@property (strong, nonatomic) IBOutlet CTSelectView *pickupView;
@property (strong, nonatomic) IBOutlet CTSelectView *dropoffView;
@property (strong, nonatomic) IBOutlet CTSelectView *calendarView;
@property (strong, nonatomic) IBOutlet CTSelectView *pickupTimeView;
@property (strong, nonatomic) IBOutlet CTSelectView *dropoffCalendarView;
@property (strong, nonatomic) IBOutlet CTSelectView *dropoffTimeView;

@property (strong, nonatomic) CTTimePickerView *pickupTimePicker;
@property (strong, nonatomic) CTTimePickerView *dropoffTimePicker;

@property (nonatomic, strong) NSNumber *pickupLat;
@property (nonatomic, strong) NSNumber *pickupLong;
@property (nonatomic, strong) NSNumber *dropoffLat;
@property (nonatomic, strong) NSNumber *dropoffLong;

@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSDate *dropoffDate;
@property (nonatomic, strong) NSDate *pickupTime;
@property (nonatomic, strong) NSDate *dropoffTime;

@property (nonatomic) LocationType pickupLocType;
@property (nonatomic) LocationType dropoffLocType;
@property (nonatomic, strong) CTAirport *airport;
@end

@implementation GroundTransportViewController


+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];

    [self registerForKeyboardNotifications];
    
    self.returnTripConstraint.constant = 8;
    self.returnTripContainer.alpha = 0;
    
    self.passengersTextField.delegate = self;
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *initialTimeComp = [gregorianCalendar components:NSHourCalendarUnit
                                                             fromDate:[NSDate date]];
    
    initialTimeComp.hour = 10;
    
    _pickupTime = [gregorianCalendar dateFromComponents:initialTimeComp];
    
    _pickupTimePicker = [[CTTimePickerView alloc] initInView:self.view mininumDate:nil];
    _dropoffTimePicker = [[CTTimePickerView alloc] initInView:self.view mininumDate:nil];
    
    __weak typeof (self) weakSelf = self;
    
    self.pickupView.placeholder = @"Pick-up location";
    self.pickupView.viewTapped = ^{
        
        [weakSelf.view endEditing:YES];
        
        _activeView = self.pickupView;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepOne" bundle:bundle];
        LocationSearchViewController *locSearchVC = [storyboard instantiateViewControllerWithIdentifier:@"LocationSearchViewController"];
        locSearchVC.enableGroundTransportLocations = YES;
        
        [weakSelf presentViewController:locSearchVC animated:YES completion:nil];
        
        locSearchVC.selectedLocation = ^(__weak CTMatchedLocation *location){

            [weakSelf.pickupView setTextFieldText:location.name];
            
            weakSelf.pickupLocType = location.isAtAirport ?
            [CTGroundLocation locationType:LocationTypeAirport] :
            [CTGroundLocation locationType:LocationTypeVicinity];
            
            weakSelf.pickupLat = location.latitude;
            weakSelf.pickupLong = location.longitude;
            
            if (location.isAtAirport) {
                weakSelf.groundSearch.airportIsPickupLocation = YES;
                _airport = [[CTAirport alloc] initWithFlightType:FlightTypeArrival IATACode:location.airportCode terminalNumber:@"1"];
            }
        };
    };
    
    self.dropoffView.placeholder = @"Drop-off location";
    self.dropoffView.viewTapped = ^{
        
        [weakSelf.view endEditing:YES];
        
        _activeView = self.pickupView;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepOne" bundle:bundle];
        LocationSearchViewController *locSearchVC = [storyboard instantiateViewControllerWithIdentifier:@"LocationSearchViewController"];
        locSearchVC.enableGroundTransportLocations = YES;
        [weakSelf presentViewController:locSearchVC animated:YES completion:nil];
        
        locSearchVC.selectedLocation = ^(__weak CTMatchedLocation *location){
            [weakSelf.dropoffView setTextFieldText:location.name];
            
            weakSelf.dropoffLocType = location.isAtAirport ?
            [CTGroundLocation locationType:LocationTypeAirport] :
            [CTGroundLocation locationType:LocationTypeVicinity];
            
            weakSelf.dropoffLat = location.latitude;
            weakSelf.dropoffLong = location.longitude;
            
            if (location.isAtAirport) {
                weakSelf.groundSearch.airportIsPickupLocation = YES;
                _airport = [[CTAirport alloc] initWithFlightType:FlightTypeArrival IATACode:location.airportCode terminalNumber:@"1"];
            }
        };
    };
    
    _activeView = self.pickupView;
    
    self.pickupTimeView.placeholder = @"Time";
    [self.pickupTimeView setTextFieldText:[DateUtils stringFromDate:self.pickupTime withFormat:@"hh:mm a"]];
    self.pickupTimeView.viewTapped = ^{
        
        [weakSelf.view endEditing:YES];
        
        _activeView = self.pickupTimeView;
        [weakSelf.pickupTimePicker present];
        [weakSelf.dropoffTimePicker hide];
        weakSelf.pickupTimePicker.timeSelection = ^(NSDate *date){

            [weakSelf.pickupTimeView setTextFieldText:[DateUtils stringFromDate:date withFormat:@"hh:mm a"]];
            weakSelf.pickupTime = date;

        };
    };
    
    self.dropoffTimeView.placeholder = @"Time";
    self.dropoffTimeView.viewTapped = ^{
        
        [weakSelf.view endEditing:YES];
        
        _activeView = weakSelf.dropoffTimeView;
        [weakSelf.dropoffTimePicker present];
        [weakSelf.pickupTimePicker hide];
        weakSelf.dropoffTimePicker.timeSelection = ^(NSDate *date){

            [weakSelf.dropoffTimeView setTextFieldText:[DateUtils stringFromDate:date withFormat:@"hh:mm a"]];
            weakSelf.dropoffTime = date;
        };
    };
    
    self.calendarView.placeholder = @"Pick-up date";
    self.calendarView.viewTapped = ^{
        _activeView = self.calendarView;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepOne" bundle:bundle];
        CTCalendarViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CTCalendarViewController"];
        vc.singleDateSelection = YES;
        vc.delegate = weakSelf;
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };
    
    self.dropoffCalendarView.placeholder = @"Dropoff date";
    self.dropoffCalendarView.viewTapped = ^{
        _activeView = self.dropoffCalendarView;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepOne" bundle:bundle];
        CTCalendarViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CTCalendarViewController"];
        vc.singleDateSelection = YES;
        vc.delegate = weakSelf;
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };

    self.sameLocationCheckBox.viewTapped = ^(BOOL selection) {
        if (selection) {
            weakSelf.returnTripConstraint.constant = 8;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.returnTripContainer.alpha = 0;
                [weakSelf.view layoutIfNeeded];
            }];
        } else {
            weakSelf.returnTripConstraint.constant = 70;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.returnTripContainer.alpha = 1;
                [weakSelf.view layoutIfNeeded];
            }];
        }
        _activeView = weakSelf.sameLocationCheckBox;
    };
    
}

#pragma mark Calendar delegate

- (void)didPickDates:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate
{
    NSString *dateString = [NSString stringWithFormat:@"%@",
                            [DateUtils shortDescriptionFromDate:pickupDate]];
    
    if (self.activeView == self.calendarView) {
        [self.calendarView setTextFieldText:dateString];
        self.pickupDate = pickupDate;
    } else if (self.activeView == self.dropoffCalendarView) {
        [self.dropoffCalendarView setTextFieldText:dateString];
        self.dropoffDate = dropoffDate;
    }
}

- (void)combineDates
{
    NSDate *puDate = [DateUtils mergeTimeWithDateWithTime:self.pickupTime dateWithDay:self.pickupDate];
    self.pickupDate = puDate;

    if (self.dropoffDate && self.dropoffTime) {
        NSDate *doDate = [DateUtils mergeTimeWithDateWithTime:self.dropoffTime dateWithDay:self.dropoffDate];
        self.dropoffDate = doDate;
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
    viewFrame.size.height += (keyboardSize.height + 45);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    (self.scrollView).frame = viewFrame;
    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *)n
{
    
    NSDictionary* userInfo = n.userInfo;
    CGSize keyboardSize = [userInfo [UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.scrollView.frame;
    
    viewFrame.size.height -= (keyboardSize.height + 45);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    (self.scrollView).frame = viewFrame;
    [UIView commitAnimations];
}

- (IBAction)search:(id)sender
{
    CTGroundLocation *pickupLoc = [[CTGroundLocation alloc] initWithLatitude:self.pickupLat
                                                                   longitude:self.pickupLong
                                                                locationType:self.pickupLocType
                                                                    dateTime:self.pickupDate];
    
    CTGroundLocation *dropoffLoc = [[CTGroundLocation alloc] initWithLatitude:self.dropoffLat
                                                                    longitude:self.dropoffLong
                                                                 locationType:self.dropoffLocType
                                                                     dateTime:self.dropoffDate];
    self.groundSearch.airport = self.airport;
    self.groundSearch.pickupLocation = pickupLoc;
    self.groundSearch.dropoffLocation = dropoffLoc;
    self.groundSearch.adultQty = @1;
    self.groundSearch.childQty = @1;
    self.groundSearch.infantQty = @1;
    
    if ([self validate]) {
        [self pushToDestination];
    }
}

- (BOOL)validate
{
    BOOL validated = YES;
    
    if (self.pickupLat == nil || self.pickupLong == nil) {
        [self.pickupView shakeAnimation];
        validated = NO;
    }
    
    if (self.dropoffLat == nil || self.dropoffLong == nil) {
        [self.dropoffView shakeAnimation];
        validated = NO;
    }
    
    if (!self.pickupDate) {
        [self.calendarView shakeAnimation];
        [self.pickupTimeView shakeAnimation];
        validated = NO;
    }
    
    if (!self.groundSearch.adultQty) {
        [self.passengersTextField shakeAnimation];
        validated = NO;
    }
    
    if (validated) {
        [self combineDates];
    }
    
    return validated;
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
