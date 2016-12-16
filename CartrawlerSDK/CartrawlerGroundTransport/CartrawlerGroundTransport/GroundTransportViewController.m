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
#import "CTLocationSearchViewController.h"
#import <CartrawlerAPI/CTGroundLocation.h>
#import "CTCalendarViewController.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CTCheckbox.h"
#import "CTTextField.h"
#import "CTSDKSettings.h"
#import "CTButton.h"
#import "PassengerSelectionViewController.h"
#import "CTInterstitialViewController.h"
#import "SettingsViewController.h"

@interface GroundTransportViewController () <CTCalendarDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *returnTripConstraint;
@property (weak, nonatomic) IBOutlet UIView *returnTripContainer;

@property (weak, nonatomic) IBOutlet CTButton *searchButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIView *activeView;

@property (weak, nonatomic) IBOutlet CTSelectView *pickupView;
@property (weak, nonatomic) IBOutlet CTSelectView *dropoffView;
@property (weak, nonatomic) IBOutlet CTSelectView *calendarView;
@property (weak, nonatomic) IBOutlet CTSelectView *pickupTimeView;
@property (weak, nonatomic) IBOutlet CTSelectView *dropoffCalendarView;
@property (weak, nonatomic) IBOutlet CTSelectView *dropoffTimeView;
@property (weak, nonatomic) IBOutlet CTSelectView *passengersView;
@property (weak, nonatomic) IBOutlet UISwitch *oneWaySwitch;

@property (strong, nonatomic) CTTimePickerView *pickupTimePicker;
@property (strong, nonatomic) CTTimePickerView *dropoffTimePicker;

@property (nonatomic, strong) NSString *pickupName;
@property (nonatomic, strong) NSString *dropoffName;
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
@property (nonatomic, strong) CTAirport *pickupAirport;
@property (nonatomic, strong) CTAirport *dropoffAirport;

@end

@implementation GroundTransportViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepOne" bundle:bundle];

    [self registerForKeyboardNotifications];
    
    self.returnTripConstraint.constant = 16;
    self.returnTripContainer.alpha = 0;
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *initialTimeComp = [gregorianCalendar components:NSCalendarUnitHour
                                                             fromDate:[NSDate date]];
    initialTimeComp.hour = 10;
    
    _pickupTime = [gregorianCalendar dateFromComponents:initialTimeComp];
    _pickupTimePicker = [[CTTimePickerView alloc] initInView:self.view mininumDate:nil];
    _dropoffTimePicker = [[CTTimePickerView alloc] initInView:self.view mininumDate:nil];
    
    _activeView = self.pickupView;

    __weak typeof (self) weakSelf = self;
    
    self.pickupView.placeholder = @"Pick-up location";
    self.pickupView.viewTapped = ^{
        [weakSelf.view endEditing:YES];
        _activeView = self.pickupView;
        CTLocationSearchViewController *locSearchVC = [storyboard instantiateViewControllerWithIdentifier:@"LocationSearchViewController"];
        locSearchVC.enableGroundTransportLocations = YES;
        locSearchVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [weakSelf presentViewController:locSearchVC animated:YES completion:nil];
        locSearchVC.selectedLocation = ^(CTMatchedLocation *location){
            [weakSelf.pickupView setTextFieldText:location.name];
            weakSelf.pickupLocType = location.isAtAirport ?
            [CTGroundLocation locationType:LocationTypeAirport] :
            [CTGroundLocation locationType:LocationTypeVicinity];
            weakSelf.pickupLat = location.latitude;
            weakSelf.pickupLong = location.longitude;
            weakSelf.pickupName = location.name;
            if (location.isAtAirport) {
                weakSelf.groundSearch.airportIsPickupLocation = YES;
                _pickupAirport = [[CTAirport alloc] initWithFlightType:FlightTypeArrival IATACode:location.airportCode terminalNumber:@"1"];
            } else {
                weakSelf.groundSearch.airportIsPickupLocation = NO;
            }
        };
    };
    
    self.dropoffView.placeholder = @"Drop-off location";
    self.dropoffView.viewTapped = ^{
        [weakSelf.view endEditing:YES];
        _activeView = self.pickupView;
        CTLocationSearchViewController *locSearchVC = [storyboard instantiateViewControllerWithIdentifier:@"LocationSearchViewController"];
        locSearchVC.invertData = YES;
        locSearchVC.enableGroundTransportLocations = YES;
        locSearchVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [weakSelf presentViewController:locSearchVC animated:YES completion:nil];
        locSearchVC.selectedLocation = ^(__weak CTMatchedLocation *location){
            [weakSelf.dropoffView setTextFieldText:location.name];
            weakSelf.dropoffLocType = location.isAtAirport ?
            [CTGroundLocation locationType:LocationTypeAirport] :
            [CTGroundLocation locationType:LocationTypeVicinity];
            weakSelf.dropoffLat = location.latitude;
            weakSelf.dropoffLong = location.longitude;
            weakSelf.dropoffName = location.name;
            if (location.isAtAirport) {
                weakSelf.groundSearch.airportIsPickupLocation = NO;
                _dropoffAirport = [[CTAirport alloc] initWithFlightType:FlightTypeArrival IATACode:location.airportCode terminalNumber:@"1"];
            } else {
                weakSelf.groundSearch.airportIsPickupLocation = YES;
            }
        };
    };
    
    self.pickupTimeView.placeholder = @"Time";
    [self.pickupTimeView setTextFieldText:[self.pickupTime stringFromDate:@"hh:mm a"]];
    self.pickupTimeView.viewTapped = ^{
        [weakSelf.view endEditing:YES];
        _activeView = self.pickupTimeView;
        [weakSelf.pickupTimePicker present];
        [weakSelf.dropoffTimePicker hide];
        weakSelf.pickupTimePicker.timeSelection = ^(NSDate *date){
            [weakSelf.pickupTimeView setTextFieldText:[date stringFromDate:@"hh:mm a"]];
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
            [weakSelf.dropoffTimeView setTextFieldText:[date stringFromDate:@"hh:mm a"]];
            weakSelf.dropoffTime = date;
        };
    };
    
    self.calendarView.placeholder = @"Pick-up date";
    self.calendarView.viewTapped = ^{
        _activeView = self.calendarView;
        CTCalendarViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CTCalendarViewController"];
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        vc.singleDateSelection = YES;
        vc.delegate = weakSelf;
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };
    
    self.passengersView.placeholder = @"Passengers";
    self.passengersView.viewTapped = ^{
        _activeView = self.passengersView;
        PassengerSelectionViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PassengerSelectionViewController"];
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        vc.groundSearch = weakSelf.groundSearch;
        [weakSelf presentViewController:vc animated:YES completion:nil];
        
        vc.updatedData = ^(NSString *text){
            [weakSelf.passengersView setTextFieldText:text];
        };
    };
    
    self.dropoffCalendarView.placeholder = @"Dropoff date";
    self.dropoffCalendarView.viewTapped = ^{
        if (weakSelf.pickupDate == nil) {
            [weakSelf.calendarView shakeAnimation];
            return;
        }
        _activeView = self.dropoffCalendarView;
        CTCalendarViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CTCalendarViewController"];
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        vc.mininumDate = weakSelf.pickupDate;
        vc.singleDateSelection = YES;
        vc.delegate = weakSelf;
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };
    
    self.dataValidationCompletion = ^(BOOL success, NSString *errorMessage) {
        [CTInterstitialViewController dismiss];
        weakSelf.searchButton.enabled = YES;
        weakSelf.searchButton.alpha = 1;
        if (errorMessage) {
            [weakSelf displayError:errorMessage];
        }
    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.groundSearch.pickupLocation) {
        _pickupLat = nil;
        _pickupLong = nil;
        [self.pickupView setTextFieldText:@""];
    }
    
    if (!self.groundSearch.dropoffLocation) {
        _dropoffLat = nil;
        _dropoffLong = nil;
        [self.dropoffView setTextFieldText:@""];
    }
    
    if (!self.groundSearch.pickupLocation.dateTime) {
        _pickupDate = nil;
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *initialTimeComp = [gregorianCalendar components:NSCalendarUnitHour
                                                                 fromDate:[NSDate date]];
        initialTimeComp.hour = 10;
        
        _pickupTime = [gregorianCalendar dateFromComponents:initialTimeComp];
        [self.calendarView setTextFieldText:@""];
    }
    
    if (!self.groundSearch.dropoffLocation.dateTime) {
        _dropoffDate = nil;
        _dropoffTime = nil;
        [self.dropoffCalendarView setTextFieldText:@""];
    }
    
    if (self.groundSearch.adultQty.intValue == 0) {
        [self.passengersView setTextFieldText:@""];
        self.passengersView.placeholder = @"Passengers";
    }
}

- (IBAction)oneWay:(id)sender
{
    BOOL selection = ((UISwitch *)sender).isOn;
    
    self.groundSearch.returnTrip = !selection;
    if (selection) {
        self.dropoffTime = nil;
        self.dropoffDate = nil;
        [self.dropoffTimeView setTextFieldText:@""];
        [self.dropoffCalendarView setTextFieldText:@""];
        
        self.returnTripConstraint.constant = 16;
        [UIView animateWithDuration:0.3 animations:^{
            self.returnTripContainer.alpha = 0;
            [self.view layoutIfNeeded];
        }];
    } else {
        self.returnTripConstraint.constant = 95;
        [UIView animateWithDuration:0.3 animations:^{
            self.returnTripContainer.alpha = 1;
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark Calendar delegate

- (void)didPickDates:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate
{
    NSString *dateString = [NSString stringWithFormat:@"%@",
                            [pickupDate shortDescriptionFromDate]];
    
    if (self.activeView == self.calendarView) {
        [self.calendarView setTextFieldText:dateString];
        _pickupDate = pickupDate;
    } else if (self.activeView == self.dropoffCalendarView) {
        [self.dropoffCalendarView setTextFieldText:dateString];
        _dropoffDate = pickupDate;
    }
}

- (void)combineDates
{
    NSDate *puDate = [NSDate mergeTimeWithDateWithTime:self.pickupTime dateWithDay:self.pickupDate];
    _pickupDate = puDate;

    if (self.dropoffDate != nil && self.dropoffTime != nil) {
        NSDate *doDate = [NSDate mergeTimeWithDateWithTime:self.dropoffTime dateWithDay:self.dropoffDate];
        _dropoffDate = doDate;
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
    (self.scrollView).frame = viewFrame;
    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *)n
{
    
    NSDictionary* userInfo = n.userInfo;
    CGSize keyboardSize = [userInfo [UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.scrollView.frame;
    
    viewFrame.size.height -= (keyboardSize.height);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    (self.scrollView).frame = viewFrame;
    [UIView commitAnimations];
}

- (IBAction)search:(id)sender
{
    UIButton *b = (UIButton *)sender;
    
    if (self.pickupDate != nil && self.pickupTime != nil) {
        [self combineDates];
    }
    
    CTGroundLocation *pickupLoc = [[CTGroundLocation alloc] initWithLatitude:self.pickupLat
                                                                   longitude:self.pickupLong
                                                                locationType:self.pickupLocType
                                                                     dateTime:self.pickupDate
                                                                         name:self.pickupName];
    
    CTGroundLocation *dropoffLoc = [[CTGroundLocation alloc] initWithLatitude:self.dropoffLat
                                                                    longitude:self.dropoffLong
                                                                 locationType:self.dropoffLocType
                                                                     dateTime:self.dropoffDate
                                                                         name:self.dropoffName];
    //if the two destinations are airports what do we do?
    if (pickupLoc.locationType == LocationTypeAirport && dropoffLoc.locationType == LocationTypeAirport) {
        self.groundSearch.airportIsPickupLocation = YES;
        self.groundSearch.airport = self.pickupAirport;
    } else if (self.groundSearch.airportIsPickupLocation) {
        self.groundSearch.airport = self.pickupAirport;
    } else {
        self.groundSearch.airport = self.dropoffAirport;
    }

    self.groundSearch.pickupLocation = pickupLoc;
    self.groundSearch.dropoffLocation = dropoffLoc;
    
    if ([self validate]) {
        b.enabled = NO;
        b.alpha = 0.8;
        [self pushToDestination];
        //[CTInterstitialViewController present:self];
    }
}

- (void)displayError:(NSString *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                    message:error
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
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
    
    if (!self.dropoffDate && !self.oneWaySwitch.isOn) {
        [self.dropoffTimeView shakeAnimation];
        [self.dropoffCalendarView shakeAnimation];
        validated = NO;
    }
    
    if (self.groundSearch.adultQty.intValue == 0) {
        [self.passengersView shakeAnimation];
        validated = NO;
    }

    return validated;
}

- (IBAction)openSettings:(id)sender
{
    NSBundle *b = [NSBundle bundleForClass:[self class]];
    SettingsViewController *vc = [[UIStoryboard storyboardWithName:@"StepOne" bundle:b] instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
