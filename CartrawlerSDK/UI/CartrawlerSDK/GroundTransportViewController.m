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


@property (weak, nonatomic) IBOutlet UIView *pickupContainer;
@property (weak, nonatomic) IBOutlet UIView *dropoffContainer;
@property (weak, nonatomic) IBOutlet UIView *pickupTimeContainer;
@property (weak, nonatomic) IBOutlet UIView *dropoffTimeContainer;
@property (weak, nonatomic) IBOutlet UIView *calendarContainer;
@property (weak, nonatomic) IBOutlet UIView *sameLocationCheckBox;
@property (weak, nonatomic) IBOutlet CTTextField *passengersTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIView *activeView;

@property (strong, nonatomic) CTSelectView *pickupView;
@property (strong, nonatomic) CTSelectView *dropoffView;
@property (strong, nonatomic) CTSelectView *calendarView;
@property (strong, nonatomic) CTSelectView *dropoffTimeView;
@property (strong, nonatomic) CTSelectView *pickupTimeView;

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
{
    BOOL airportIsPickupLocation;
}


+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self registerForKeyboardNotifications];
    
    self.passengersTextField.delegate = self;
    
    _pickupDate = [NSDate date];
    _dropoffDate = [NSDate date];
    
    __weak typeof (self) weakSelf = self;
    
    _pickupTimePicker = [[CTTimePickerView alloc] initInView:self.view mininumDate:[NSDate date]];
    _dropoffTimePicker = [[CTTimePickerView alloc] initInView:self.view mininumDate:nil];
    
    self.pickupView = [[CTSelectView alloc] initWithView:self.pickupContainer placeholder:@"Pick-up location"];
    self.pickupView.viewTapped = ^{
        
        [weakSelf.view endEditing:YES];
        
        _activeView = self.pickupView;
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
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
                airportIsPickupLocation = YES;
                _airport = [[CTAirport alloc] initWithFlightType:FlightTypeArrival IATACode:location.airportCode terminalNumber:@"1"];
            }

        };
    };
    
    self.dropoffView = [[CTSelectView alloc] initWithView:self.dropoffContainer placeholder:@"Drop-off location"];
    self.dropoffView.viewTapped = ^{
        
        [weakSelf.view endEditing:YES];
        
        _activeView = self.pickupView;
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
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
                airportIsPickupLocation = NO;
                _airport = [[CTAirport alloc] initWithFlightType:FlightTypeArrival IATACode:location.airportCode terminalNumber:@"1"];
            }
        
        };
    };
    
    _activeView = self.pickupView;
    
    _pickupTimeView = [[CTSelectView alloc] initWithView:self.pickupTimeContainer placeholder:@"Pick-up time"];
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
    
    _dropoffTimeView = [[CTSelectView alloc] initWithView:self.dropoffTimeContainer placeholder:@"Drop-off time"];
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
    
    _calendarView = [[CTSelectView alloc] initWithView:self.calendarContainer placeholder:@"Select dates"];
    self.calendarView.viewTapped = ^{
        _activeView = self.calendarView;
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepOne" bundle:bundle];
        CTCalendarViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CTCalendarViewController"];
        vc.delegate = weakSelf;
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };

//    CTCheckbox *sameLoc = [[CTCheckbox alloc] initEnabled:YES containerView:self.sameLocationCheckBox ];
//    sameLoc.viewTapped = ^(BOOL selection) {
//        if (selection) {
//
//            
//        } else {
//
//            
//        }
//        _activeView = sameLoc;
//    };
    
}

#pragma mark Calendar delegate

- (void)didPickDates:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate
{
    NSString *dateString = [NSString stringWithFormat:@"%@ - %@",
                            [DateUtils shortDescriptionFromDate:pickupDate],
                            [DateUtils shortDescriptionFromDate:dropoffDate]];
    
    [self.calendarView setTextFieldText:dateString];
    
    self.pickupDate = pickupDate;
    self.dropoffDate = dropoffDate;

}

- (void)combineDates
{
    NSDate *puDate = [DateUtils mergeTimeWithDateWithTime:self.pickupTime dateWithDay:self.pickupDate];
    NSDate *doDate = [DateUtils mergeTimeWithDateWithTime:self.dropoffTime dateWithDay:self.dropoffDate];
    
    self.pickupDate = puDate;
    self.dropoffDate = doDate;
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
    CGSize keyboardSize = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.scrollView.frame;
    
    viewFrame.size.height -= (keyboardSize.height + 45);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    (self.scrollView).frame = viewFrame;
    [UIView commitAnimations];
}

- (IBAction)search:(id)sender
{
    
    CartrawlerAPI *api = [[CartrawlerAPI alloc] initWithClientKey:@"592248"
                                                       language:[CTSDKSettings instance].languageCode
                                                          debug:[CTSDKSettings instance].isDebug];
    
    CTGroundLocation *pickupLoc = [[CTGroundLocation alloc] initWithLatitude:self.pickupLat
                                                                   longitude:self.pickupLong
                                                                locationType:self.pickupLocType
                                                                    dateTime:self.pickupDate];
    
    CTGroundLocation *dropoffLoc = [[CTGroundLocation alloc] initWithLatitude:self.dropoffLat
                                                                    longitude:self.dropoffLong
                                                                 locationType:self.dropoffLocType
                                                                     dateTime:self.dropoffDate];
    
    [api groundTransportationAvail:self.airport
                  pickupLocation:pickupLoc
                 dropoffLocation:dropoffLoc
         airportIsPickupLocation:airportIsPickupLocation
                        adultQty:@1
                        childQty:@0
                       infantQty:@0
                    currencyCode:@"EUR"
                      completion:^(CTGroundAvailability *response, CTErrorResponse *error) {
                          if (response) {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  [self performSegueWithIdentifier:@"showServices" sender:response];
                              });
                          } else {
                              NSLog(@"%@", error);
                          }
                      }];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GroundServicesViewController *vc = segue.destinationViewController;
    [vc setAvailability:(CTGroundAvailability *)sender];
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
