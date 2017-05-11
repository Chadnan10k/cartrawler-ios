//
//  CTSearchView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 29/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchView.h"
#import "CartrawlerSDK/CTLayoutManager.h"
#import "CartrawlerSDK/CTCalendarViewController.h"
#import "CartrawlerSDK/CartrawlerSDK+NSDateUtils.h"
#import "CartrawlerSDK/CartrawlerSDK+UIView.h"
#import "CartrawlerSDK/CTAlertViewController.h"
#import "CartrawlerSDK/CartrawlerSDK+NSNumber.h"
#import "CartrawlerSDK/CTLocalisedStrings.h"
#import "CTRentalLocalizationConstants.h"
#import "CTSelectionView.h"
#import "CTLocationSearchViewController.h"
#import "CTRentalConstants.h"
#import <CartrawlerSDK/CTAnalytics.h>
#import <CartrawlerSDK/CTSDKSettings.h>

@interface CTSearchView() <CTSelectionViewDelegate, CTCalendarDelegate>

@property (nonatomic, strong) CTLayoutManager *layoutManager;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *scrollViewContentView;

@property (nonatomic, strong) CTSelectionView *pickupLocationSearch;
@property (nonatomic, strong) CTSelectionView *dropoffLocationSearch;
@property (nonatomic, strong) UIView *sameLocationSwitchContainer;
@property (nonatomic, strong) CTSelectionView *datesContainer;
@property (nonatomic, strong) UIView *timesContainer;
@property (nonatomic, strong) UIView *ageSwitchContainer;
@property (nonatomic, strong) CTSelectionView *ageContainer;
@property (nonatomic, strong) CTSelectionView *pickupTimeContainer;
@property (nonatomic, strong) CTSelectionView *dropoffTimeContainer;

@property (nonatomic, strong) UISwitch *ageSwitch;
@property (nonatomic, strong) UISwitch *locationSwitch;

@property (nonatomic, strong) NSDate *temporaryPickupTime;
@property (nonatomic, strong) NSDate *temporaryDropoffTime;
@property (nonatomic, strong) NSDate *temporaryPickupDate;
@property (nonatomic, strong) NSDate *temporaryDropoffDate;


@end

@implementation CTSearchView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)init
{
    self = [super init];
    
    [self setup];
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)setup
{
    _temporaryPickupTime = [NSDate dateWithHour:10 minute:0];
    _temporaryDropoffTime = [NSDate dateWithHour:10 minute:0];

    _locationSwitch = [UISwitch new];
    _ageSwitch = [UISwitch new];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.contentSize = self.bounds.size;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.scrollView];
    
    _scrollViewContentView = [UIView new];
    self.scrollViewContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.scrollViewContentView];
    
    _pickupLocationSearch = [[CTSelectionView alloc] initWithPlaceholder:CTLocalizedString(CTRentalSearchPickupLocationText)];
    self.pickupLocationSearch.useAsButton = YES;
    self.pickupLocationSearch.delegate = self;
    
    _dropoffLocationSearch = [[CTSelectionView alloc] initWithPlaceholder:CTLocalizedString(CTRentalSearchReturnLocationText)];
    self.dropoffLocationSearch.useAsButton = YES;
    self.dropoffLocationSearch.delegate = self;
    
    _sameLocationSwitchContainer = [self generateSwitchView:CTLocalizedString(CTRentalSearchReturnLocationButton)
                                            switchReference:self.locationSwitch];
    self.sameLocationSwitchContainer.translatesAutoresizingMaskIntoConstraints = NO;
    
    _datesContainer = [[CTSelectionView alloc] initWithPlaceholder:CTLocalizedString(CTRentalSearchSelectDatesHint)];
    self.datesContainer.useAsButton = YES;
    self.datesContainer.delegate = self;
    
    _timesContainer = [self generateTimeSelectionView];
    self.timesContainer.translatesAutoresizingMaskIntoConstraints = NO;
    
    _ageSwitchContainer = [self generateSwitchView:CTLocalizedString(CTRentalSearchDriverAge)
                                   switchReference:self.ageSwitch];
    self.ageSwitchContainer.translatesAutoresizingMaskIntoConstraints = NO;
    
    _ageContainer = [[CTSelectionView alloc] initWithPlaceholder:CTLocalizedString(CTRentalSearchDriverAgeHint)];
    self.ageContainer.keyboardType = UIKeyboardTypeNumberPad;
    self.ageContainer.regex = @"^[0-9]{0,2}$";
    self.ageContainer.useAsButton = NO;
    self.ageContainer.delegate = self;
    
    //Scrollview
    [CTLayoutManager pinView:self.scrollView toSuperView:self padding:UIEdgeInsetsMake(0, 0, 0, 0)];
    [CTLayoutManager pinView:self.scrollViewContentView toSuperView:self.scrollView padding:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.scrollViewContentView  setHeightConstraint:@1 priority:@100];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollViewContentView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:0]];
    
    [self.pickupLocationSearch setHeightConstraint:@60 priority:@1000];
    [self.dropoffLocationSearch setHeightConstraint:@60 priority:@1000];
    [self.sameLocationSwitchContainer setHeightConstraint:@60 priority:@1000];
    [self.datesContainer setHeightConstraint:@60 priority:@1000];
    [self.timesContainer setHeightConstraint:@60 priority:@1000];
    [self.ageSwitchContainer setHeightConstraint:@60 priority:@100];
    [self.ageContainer setHeightConstraint:@60 priority:@1000];

    [self layout];
}

- (void)addKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (UIView *)generateSwitchView:(NSString *)text switchReference:(UISwitch *)switchReference
{
    switchReference.on = YES;
    [switchReference addTarget:self action:@selector(ageSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    switchReference.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel *detailLabel = [UILabel new];
    detailLabel.text = text;
    detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    detailLabel.numberOfLines = 0;
    UIView *container = [UIView new];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *viewDict = @{@"label" : detailLabel,
                               @"switch" : switchReference};
    
    [container addSubview:detailLabel];
    [container addSubview:switchReference];
    
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[label]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDict]];
    
    [container addConstraint:[NSLayoutConstraint constraintWithItem:switchReference
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:0
                                                             toItem:container
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
    
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[label]-(>=8)-[switch]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDict]];
    return container;
}

- (UIView *)generateTimeSelectionView
{
    UIView *container = [UIView new];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    
    _pickupTimeContainer = [[CTSelectionView alloc] initWithPlaceholder:CTLocalizedString(CTRentalSearchPickupTimeText)];
    self.pickupTimeContainer.delegate = self;
    self.pickupTimeContainer.useAsButton = YES;
    [self.pickupTimeContainer setDetailText:[self.temporaryPickupTime simpleTimeString]];
    _dropoffTimeContainer = [[CTSelectionView alloc] initWithPlaceholder:CTLocalizedString(CTRentalSearchReturnTimeText)];
    self.dropoffTimeContainer.delegate = self;
    self.dropoffTimeContainer.useAsButton = YES;
    [self.dropoffTimeContainer setDetailText:[self.temporaryDropoffTime simpleTimeString]];
    
    CTLayoutManager *manager = [CTLayoutManager layoutManagerWithContainer:container];
    manager.justify = YES;
    manager.orientation = CTLayoutManagerOrientationLeftToRight;
    [manager insertView:UIEdgeInsetsMake(0, 0, 0, 8) view:self.pickupTimeContainer];
    [manager insertView:UIEdgeInsetsMake(0, 8, 0, 0) view:self.dropoffTimeContainer];
    [manager layoutViews];
    
    return container;
}

- (void)layout
{
    _layoutManager = [CTLayoutManager layoutManagerWithContainer:self.scrollViewContentView];
    self.layoutManager.justify = NO;
    self.layoutManager.orientation = CTLayoutManagerOrientationTopToBottom;

    [self.layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.pickupLocationSearch];
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.sameLocationSwitchContainer];
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.datesContainer];
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.timesContainer];
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.ageSwitchContainer];

    [self.layoutManager layoutViews];
}

- (void)presentLocationSelection:(BOOL)isPickupView
{
    if (isPickupView) {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"ML_Pickup" detail:@"click" step:@-1];
        }
        [[CTAnalytics instance] tagScreen:@"E_Pickup" detail:@"click" step:@-1];
    } else {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"ML_Dropoff" detail:@"click" step:@-1];
        }
        [[CTAnalytics instance] tagScreen:@"E_Dropoff" detail:@"click" step:@-1];
    }
    
    __weak typeof(self) weakSelf = self;
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:CTRentalSearchStoryboard bundle:bundle];
    CTLocationSearchViewController *locationViewController = [storyboard instantiateViewControllerWithIdentifier:CTRentalLocationSearchViewIdentifier];
    locationViewController.cartrawlerAPI = self.cartrawlerAPI;
    
    locationViewController.selectedLocation = ^(CTMatchedLocation *location) {
        if (isPickupView) {
            [weakSelf.pickupLocationSearch setDetailText:location.name];
            weakSelf.search.pickupLocation = location;
            if (weakSelf.locationSwitch.isOn) {
                weakSelf.search.dropoffLocation = location;
            }
        } else {
            [weakSelf.dropoffLocationSearch setDetailText:location.name];
            weakSelf.search.dropoffLocation = location;
        }
    };
    
    if (self.delegate) {
        [self.delegate didTapPresentViewController:locationViewController];
    }
}


- (void)presentCalendar
{
    NSBundle *bundle = [NSBundle bundleForClass:[CTCalendarViewController class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:CTCalendarStoryboard bundle:bundle];
    CTCalendarViewController *calendarViewController = [storyboard instantiateViewControllerWithIdentifier:CTCalendarViewIdentifier];
    calendarViewController.delegate = self;
    if (self.delegate) {
        [self.delegate didTapPresentViewController:calendarViewController];
    }
}

- (void)presentTimePicker:(BOOL)isPickupTime
{
    NSString *title = @"";
    if (isPickupTime) {
        title = CTLocalizedString(CTRentalSearchPickupTimeText);
    } else {
        title = CTLocalizedString(CTRentalSearchReturnTimeText);
    }
    __weak typeof (self) weakSelf = self;
    CTAlertViewController *alertController = [CTAlertViewController alertControllerWithTitle:title message:nil];
    alertController.backgroundTapDismissalGestureEnabled = YES;
    
    UIDatePicker *datePicker = [UIDatePicker new];
    datePicker.datePickerMode = UIDatePickerModeTime;
    datePicker.minuteInterval = 15;
    datePicker.locale = [NSLocale currentLocale];
    datePicker.date = [NSDate dateWithHour:10 minute:0];
    alertController.customView = datePicker;
    
    CTAlertAction *cancelAction = [CTAlertAction actionWithTitle:CTLocalizedString(CTRentalCTACancel)
                                                         handler:^(CTAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    CTAlertAction *okAction = [CTAlertAction actionWithTitle:CTLocalizedString(CTRentalCTADone)
                                                     handler:^(CTAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
        
        if ((datePicker.date.minute % 15) != 0) {
            [weakSelf.dropoffTimeContainer setDetailText: [self.temporaryDropoffTime simpleTimeString]];
            [weakSelf.pickupTimeContainer setDetailText: [self.temporaryPickupTime simpleTimeString]];
            return;
        }
        
        if (isPickupTime) {
            _temporaryPickupTime = datePicker.date;
            [weakSelf.pickupTimeContainer setDetailText: [datePicker.date simpleTimeString]];
        } else {
            _temporaryDropoffTime = datePicker.date;
            [weakSelf.dropoffTimeContainer setDetailText: [datePicker.date simpleTimeString]];
        }
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];

    if (self.delegate) {
        [self.delegate didTapPresentViewController:alertController];
    }
}

- (void)combineTimes
{
    NSDate *pickupDate = [NSDate mergeTimeWithDateWithTime:self.temporaryPickupTime dateWithDay:self.temporaryPickupDate];
    NSDate *dropoffDate = [NSDate mergeTimeWithDateWithTime:self.temporaryDropoffTime dateWithDay:self.temporaryDropoffDate];

    self.search.pickupDate = pickupDate;
    self.search.dropoffDate = dropoffDate;
}

- (void)setAge
{
    if (self.ageSwitch.isOn) {
        self.search.driverAge = @30;
    } else {
        self.search.driverAge = [NSNumber numberFromString:self.ageContainer.textFieldText];
    }
}

- (void)updateDisplayWithSearch:(NSObject *)search
{
    
}

- (BOOL)validateSearch
{
    BOOL valid = YES;
    [self setAge];
    [self combineTimes];
    
    if (!self.search.pickupLocation) {
        [self.pickupLocationSearch animate];
        valid = NO;
    }
    
    if (!self.search.dropoffLocation && !self.locationSwitch.isOn) {
        [self.dropoffLocationSearch animate];
        valid = NO;
    }

    if (!self.search.driverAge && !self.ageSwitch.isOn) {
        [self.ageContainer animate];
        valid = NO;
    }
    
    if (!self.temporaryPickupDate || !self.temporaryDropoffDate) {
        [self.datesContainer animate];
        valid = NO;
    }
    
    return valid;
}

//MARK: Keyboard Notifications

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [self.scrollView setContentOffset:CGPointMake(0, keyboardSize.height - self.scrollView.contentOffset.y)];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [self.scrollView setContentOffset:CGPointMake(0, keyboardSize.height + self.scrollView.contentOffset.y)];
}

//MARK: Age Switch
- (void)ageSwitchChanged:(UISwitch *)sender
{
    if (sender == self.ageSwitch) {
        if (sender.isOn) {
            if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
                [[CTAnalytics instance] tagScreen:@"ageCheckbo" detail:@"1" step:@-1];
            }
            [[CTAnalytics instance] tagScreen:@"E_ageCheck" detail:@"1" step:@-1];
            self.search.driverAge = @30;
            NSUInteger idx = [self.layoutManager indexOfObject:self.ageContainer].integerValue;
            [self.layoutManager removeAtIndex:idx];
        } else {
            if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
                [[CTAnalytics instance] tagScreen:@"ageCheckbo" detail:@"0" step:@-1];
            }
            [[CTAnalytics instance] tagScreen:@"E_ageCheck" detail:@"0" step:@-1];
            self.search.driverAge = nil;
            NSUInteger idx = [self.layoutManager indexOfObject:self.ageSwitchContainer].integerValue;
            [self.layoutManager insertViewAtIndex:idx padding:UIEdgeInsetsMake(8, 8, 8, 8) view:self.ageContainer];
        }
    }
    
    if (sender == self.locationSwitch) {
        if (sender.isOn) {
            if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
                [[CTAnalytics instance] tagScreen:@"returnLoca" detail:@"1" step:@-1];
            }
            [[CTAnalytics instance] tagScreen:@"E_returnL" detail:@"1" step:@-1];
            self.search.dropoffLocation = self.search.pickupLocation;
            [self.layoutManager removeAtIndex:1];
        } else {
            if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
                [[CTAnalytics instance] tagScreen:@"returnLoca" detail:@"0" step:@-1];
            }
            [[CTAnalytics instance] tagScreen:@"E_returnL" detail:@"0" step:@-1];
            self.search.dropoffLocation = nil;
            [self.layoutManager insertViewAtIndex:1 padding:UIEdgeInsetsMake(8, 8, 8, 8) view:self.dropoffLocationSearch];
        }
    }
}

//MARK: Selection view delegate
- (void)selectionViewWasTapped:(CTSelectionView *)selectionView
{
    if (selectionView == self.pickupLocationSearch) {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"ML_Pickup" detail:@"click" step:@-1];
        }
        [[CTAnalytics instance] tagScreen:@"E_Pickup" detail:@"click" step:@-1];
        [self presentLocationSelection:YES];
    }
    
    if (selectionView == self.dropoffLocationSearch) {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"ML_Dropoff" detail:@"click" step:@-1];
        }
        [[CTAnalytics instance] tagScreen:@"E_Dropoff" detail:@"click" step:@-1];
        [self presentLocationSelection:NO];
    }
    
    if (selectionView == self.datesContainer) {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"calendar_d" detail:@"click" step:@-1];
        }
        [[CTAnalytics instance] tagScreen:@"E_calend_d" detail:@"click" step:@-1];
        [self presentCalendar];
    }
    
    if (selectionView == self.pickupTimeContainer) {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"calendar_t" detail:@"click" step:@-1];
            [[CTAnalytics instance] tagScreen:@"E_calend_t" detail:@"click" step:@-1];
        }
        [self presentTimePicker:YES];
    }
    
    if (selectionView == self.dropoffTimeContainer) {
        [self presentTimePicker:NO];
    }
}

- (void)selectionViewShouldBeginEditing:(CTSelectionView *)selectionView
{
    if (selectionView == self.ageContainer) {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"driverAgeC" detail:@"enter" step:@-1];
        }
        [[CTAnalytics instance] tagScreen:@"E_driverAgeC" detail:@"enter" step:@-1];
    }
    
    [self addKeyboardNotifications];
}

- (void)selectionViewChangedCharacters:(CTSelectionView *)selectionView {
    if (selectionView == self.ageContainer) {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"driverAgeC" detail:@"type" step:@-1];
        }
        [[CTAnalytics instance] tagScreen:@"E_driverAgeC" detail:@"type" step:@-1];
    }
}

- (void)selectionViewDidEndEditing:(CTSelectionView *)selectionView {
    if (selectionView == self.ageContainer) {
        if ([CTSDKSettings instance].journey == CTSDKJourneyStandalone) {
            [[CTAnalytics instance] tagScreen:@"driverAgeC" detail:@"leave" step:@-1];
        }
        [[CTAnalytics instance] tagScreen:@"E_driverAgeC" detail:@"leave" step:@-1];
    }
}

//MARK: CTCalendarDelegate
- (void)didPickDates:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate
{
    _temporaryPickupDate = pickupDate;
    _temporaryDropoffDate = dropoffDate;
    NSString *dateStr = [NSString stringWithFormat:@"%@ - %@", [pickupDate shortDescriptionFromDate], [dropoffDate shortDescriptionFromDate]];
    [self.datesContainer setDetailText:dateStr];
}

@end
