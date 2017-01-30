//
//  SearchDetailViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 03/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSearchDetailsViewController.h"
#import <CartrawlerSDK/CTSelectView.h>
#import "CTLocationSearchViewController.h"
#import <CartrawlerSDK/CTCalendarViewController.h>
#import <CartrawlerSDK/CartrawlerSDK+NSDateUtils.h>
#import <CartrawlerSDK/CTTimePickerView.h>
#import <CartrawlerSDK/CTTextField.h>
#import "CTInterstitialViewController.h"
#import <CartrawlerSDK/CTToolTip.h>
#import <CartrawlerSDK/CTNextButton.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CartrawlerSDK+UITextField.h>
#import "CTRentalConstants.h"
#import "CTRentalLocalizationConstants.h"

#define kDropoffLocationOpen 101.0
#define kDropoffLocationClosed 18.0

#define kAgeOpen 67.0
#define kAgeClosed 16.0

@interface CTSearchDetailsViewController () <CTCalendarDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet CTNextButton *nextButton;
@property (weak, nonatomic) IBOutlet CTTextField *ageContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropoffLocTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ageTopConstraint;

@property (strong, nonatomic) UIView *activeView;

@property (strong, nonatomic) IBOutlet CTSelectView *pickupView;
@property (strong, nonatomic) IBOutlet CTSelectView *dropoffView;
@property (strong, nonatomic) IBOutlet CTSelectView *calendarView;
@property (strong, nonatomic) IBOutlet CTSelectView *dropoffTimeView;
@property (strong, nonatomic) IBOutlet CTSelectView *pickupTimeView;

@property (weak, nonatomic) IBOutlet CTLabel *returnToSameLocationLabel;
@property (weak, nonatomic) IBOutlet CTLabel *driverAgeDescriptionLabel;

@property (strong, nonatomic) CTTimePickerView *pickupTimePicker;
@property (strong, nonatomic) CTTimePickerView *dropoffTimePicker;

@property (nonatomic, strong) NSDate *pickupTime;
@property (nonatomic, strong) NSDate *dropoffTime;

@property (nonatomic, strong) CTLocationSearchViewController *locSearchVC;
@property (nonatomic, strong) CTCalendarViewController *calendar;

@property (readwrite, nonatomic) BOOL isReturningSameLocation;
@property (readwrite, nonatomic) BOOL driverUnderage;

@end

@implementation CTSearchDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:CTRentalSearchStoryboard bundle:bundle];
    
    [self.nextButton setText:CTLocalizedString(CTRentalCTASearch)];
    
    [self.ageContainer addDoneButton];
    self.ageContainer.delegate = self;
    
    self.titleLabel.text = CTLocalizedString(CTRentalTitleSearchRental);
    
    _locSearchVC = (CTLocationSearchViewController *)[storyboard instantiateViewControllerWithIdentifier:CTRentalLocationSearchViewIdentifier];
    self.locSearchVC.cartrawlerAPI = self.cartrawlerAPI;
    self.locSearchVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    _calendar = [storyboard instantiateViewControllerWithIdentifier:@"CTCalendarViewController"];
    self.calendar.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.calendar.delegate = self;
    
    [self registerForKeyboardNotifications];
    
    if (!self.search.driverAge) {
        self.search.driverAge = @30;
    }
    self.ageContainer.placeholder = CTLocalizedString(CTRentalSearchDriverAgeHint);
    self.ageContainer.text = self.search.driverAge.stringValue;
    self.search.passengerQty = @1;
        
    _pickupTimePicker = [[CTTimePickerView alloc] initInView:self.view mininumDate:nil];
    _dropoffTimePicker = [[CTTimePickerView alloc] initInView:self.view mininumDate:nil];

    _isReturningSameLocation = YES;
    _activeView = self.pickupView;

    self.pickupView.placeholder = CTLocalizedString(CTRentalSearchPickupLocationText);
    self.dropoffView.placeholder = CTLocalizedString(CTRentalSearchReturnLocationText);
    self.returnToSameLocationLabel.text = CTLocalizedString(CTRentalSearchReturnLocationButton);
    self.pickupTimeView.placeholder = CTLocalizedString(CTRentalSearchPickupTimeText);
    self.dropoffTimeView.placeholder = CTLocalizedString(CTRentalSearchReturnTimeText);
    self.calendarView.placeholder = CTLocalizedString(CTRentalSearchSelectDatesHint);
    [self.pickupTimeView setTextFieldText:[self.pickupTime simpleTimeString]];
    [self.dropoffTimeView setTextFieldText:[self.dropoffTime simpleTimeString]];
    
    self.driverAgeDescriptionLabel.text = CTLocalizedString(CTRentalSearchDriverAge);

    self.dropoffLocTopConstraint.constant = kDropoffLocationClosed;
    self.dropoffView.alpha = 0;
    
    self.ageTopConstraint.constant = kAgeClosed;
    self.ageContainer.alpha = 0;
    
    [self.view layoutIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self sendEvent:NO customParams:@{@"eventName" : @"Search Step",
                                      @"stepName" : @"Step1",
                                      @"clientID" : [CTSDKSettings instance].clientId,
                                      @"residenceID" : [CTSDKSettings instance].homeCountryCode
                                      } eventName:@"Step of search" eventType:@"Step"];

    [[CTAnalytics instance] tagScreen:@"Step" detail:@"searchcars" step:@1];
    
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
        self.search.driverAge = @30;
        self.ageContainer.text = self.search.driverAge.stringValue;
    }

    if ((self.search.driverAge.intValue < 25) || (self.search.driverAge.intValue > 70)) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self openDriverAgeField:YES];
        });
        
    }

    [self.calendar reset];
}

- (IBAction)pickupTapped:(id)sender
{
    [self.view endEditing:YES];
    _activeView = self.pickupView;
    __weak typeof(self) weakSelf = self;
    [self presentViewController:self.locSearchVC animated:YES completion:nil];
    self.locSearchVC.selectedLocation = ^(__weak CTMatchedLocation *location) {
        [weakSelf.pickupView setTextFieldText:location.name];
        weakSelf.search.pickupLocation = location;
        if (weakSelf.isReturningSameLocation || weakSelf.search.dropoffLocation == nil) {
            weakSelf.search.dropoffLocation = location;
        }
    };
}

- (IBAction)dropoffTapped:(id)sender
{
    [self.view endEditing:YES];
    _activeView = self.pickupView;
    [self presentViewController:self.locSearchVC animated:YES completion:nil];
    __weak typeof(self) weakSelf = self;
    self.locSearchVC.selectedLocation = ^(__weak CTMatchedLocation *location){
        [weakSelf.dropoffView setTextFieldText:location.name];
        (weakSelf.search).dropoffLocation = location;
    };
}

- (IBAction)pickupTimeTapped:(id)sender
{
    [self.view endEditing:YES];
    _activeView = self.pickupTimeView;
    [self.pickupTimePicker present];
    [self.dropoffTimePicker hide];
    __weak typeof(self) weakSelf = self;
    self.pickupTimePicker.timeSelection = ^(NSDate *date){
        _pickupTime = date;
        [weakSelf.pickupTimeView setTextFieldText:[date simpleTimeString]];
    };
}

- (IBAction)dropoffTimeTapped:(id)sender
{
    [self.view endEditing:YES];
    _activeView = self.dropoffTimeView;
    [self.dropoffTimePicker present];
    [self.pickupTimePicker hide];
    __weak typeof(self) weakSelf = self;
    self.dropoffTimePicker.timeSelection = ^(NSDate *date){
        _dropoffTime = date;
        [weakSelf.dropoffTimeView setTextFieldText:[date simpleTimeString]];
    };
}

- (IBAction)calendarTapped:(id)sender
{
    _activeView = self.calendarView;
    [self presentViewController:self.calendar animated:YES completion:nil];
}

- (IBAction)sameLocation:(id)sender
{
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

- (IBAction)driverAge:(id)sender
{
    BOOL selection = ((UISwitch *)sender).isOn;
    [self openDriverAgeField:!selection];
}

- (void)openDriverAgeField:(BOOL)open
{
    if (open) {
        self.driverUnderage = YES;
        self.ageTopConstraint.constant = kAgeOpen;
        [UIView animateWithDuration:0.3 animations:^{
            self.ageContainer.alpha = 1;
            [self.view layoutIfNeeded];
        }];
    } else {
        [self.view endEditing:YES];
        self.driverUnderage = NO;
        self.search.driverAge = @30;
        self.ageTopConstraint.constant = kAgeClosed;
        [UIView animateWithDuration:0.3 animations:^{
            self.ageContainer.alpha = 0;
            [self.view layoutIfNeeded];
        }];
    }
}

- (IBAction)next:(id)sender {
    [self sendEvent:NO customParams:@{@"buttonName" : @"Search for cars"} eventName:@"Button Click" eventType:@"UserAction"];
    self.search.vehicleAvailability = nil;
    [self searchTapped];
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

    self.search.pickupDate = puDate;
    self.search.dropoffDate = doDate;
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
        [d setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        self.search.driverAge = [d numberFromString:self.ageContainer.text];
    }
    
    if (self.search.driverAge == nil || self.search.driverAge.intValue > 99 || self.search.driverAge.intValue < 18) {
        [self.ageContainer shakeAnimation];
        validated = NO;
    }
    
    return validated;
}

- (void)performSearch
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self searchTapped];
    });
}

- (void)searchTapped
{
    
    if (self.navigationController) {
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
            if (!self.search.vehicleAvailability) {
                [CTInterstitialViewController present:self search:self.search];
            }
        }
    } else {
        [self dismiss];
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
    [[CTAnalytics instance] tagScreen:@"Exit" detail:@"1" step:@1];
 
    if (self.delegate) {
        [self.delegate didDismissViewController:self.restorationIdentifier];
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

#pragma mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [characterSet addCharactersInString:@" "];
    if ([NSString stringWithFormat:@"%@%@", self.ageContainer.text, string].length < 3) {
        return [self validatePhone:[NSString stringWithFormat:@"%@%@", self.ageContainer.text, string]];
    } else {
        return NO;
    }
}

- (BOOL)validatePhone:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"(^\\+|[0-9456])([0-9]{0,15}$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}


@end
