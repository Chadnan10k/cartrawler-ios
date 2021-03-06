//
//  CTCalendarManagerViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 13/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTCalendarViewController.h"
#import "CTLabel.h"
#import "CTCalendarView.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CTAppearance.h"
#import "CTView.h"
#import "CartrawlerSDK+UIColor.h"
#import "CTNextButton.h"
#import "CTSDKLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CTButton.h>

NSString * const CTCalendarViewIdentifier = @"CTCalendarViewController";
NSString * const CTCalendarStoryboard = @"CTCalendar";

@interface CTCalendarViewController()

@property (weak, nonatomic) IBOutlet CTNextButton *nextButton;
@property (weak, nonatomic) IBOutlet CTLabel *pickupDateLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dropOffDateLabel;
@property (weak, nonatomic) IBOutlet CTCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UIView *headerTopSection;
@property (weak, nonatomic) IBOutlet CTView *summaryContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weekDayTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomSpace;

@property (weak, nonatomic) IBOutlet CTLabel *pickupTitleLabel;
@property (weak, nonatomic) IBOutlet CTLabel *returnTitleLabel;
@property (weak, nonatomic) IBOutlet CTLabel *calendarTitleLabel;
@property (weak, nonatomic) IBOutlet CTButton *cancelButton;

@property (strong, nonatomic) NSDate *pickupDate;
@property (strong, nonatomic) NSDate *dropoffDate;

@end

@implementation CTCalendarViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.calendarTitleLabel.text = self.singleDateSelection ? CTLocalizedString(CTSDKCalendarSelectDate) : CTLocalizedString(CTSDKCalendarSelectDates);
    
    if (self.singleDateSelection) {
        self.weekDayTopSpace.constant = 0;
        self.summaryContainerView.hidden = YES;
    } else {
        self.weekDayTopSpace.constant = 60;
        self.summaryContainerView.hidden = NO;
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nextButton setText:CTLocalizedString(CTSDKCalendarContinue)];

    [self showCloseButton:NO];
    
    self.summaryContainerView.backgroundColor = [CTAppearance instance].calendarSummaryViewColor;
    self.headerTopSection.backgroundColor = [CTAppearance instance].navigationBarColor;
    self.pickupTitleLabel.textColor = [CTAppearance instance].calendarSummaryTitleLabelColor;
    self.pickupTitleLabel.text = CTLocalizedString(CTSDKCalendarPickupDate);
    self.returnTitleLabel.textColor = [CTAppearance instance].calendarSummaryTitleLabelColor;
    self.returnTitleLabel.text = CTLocalizedString(CTSDKCalendarReturnDate);

    if (self.mininumDate) {
        self.calendarView.mininumDate = self.mininumDate;
    }
    [self.calendarView setupWithFrame:self.view.frame];
    
    self.calendarView.datesSelected = ^(NSDate *pickup, NSDate *dropoff){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.delegate != nil) {
                if (pickup && !dropoff && self.singleDateSelection) {
                    [self.delegate didPickDates:pickup dropoffDate:dropoff];
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else if (!self.singleDateSelection && pickup && dropoff) {
                    //[self.delegate didPickDates:pickup dropoffDate:dropoff];
                    _pickupDate = pickup;
                    _dropoffDate = dropoff;
                }
            }
            [self showCloseButton:YES];
        });
    };
    
    self.calendarView.dateSelected = ^(NSDate *date, BOOL headDate) {
        if (self.singleDateSelection) {
            [self.delegate didPickDates:date dropoffDate:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            if (headDate) {
                [self animatePickupLabel:[date shortDescriptionFromDate]];
            } else {
                [self animateDropoffLabel:[date shortDescriptionFromDate]];
            }
        }
    };
    
    self.pickupDateLabel.text = CTLocalizedString(CTSDKCalendarSelectDate);
    self.dropOffDateLabel.text = CTLocalizedString(CTSDKCalendarSelectDate);
    self.calendarView.discard = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self animatePickupLabel:CTLocalizedString(CTSDKCalendarSelectDate)];
            [self animateDropoffLabel:CTLocalizedString(CTSDKCalendarSelectDate)];
            [self showCloseButton:NO];
        });
    };
    
    [self.cancelButton setTitle:CTLocalizedString(CTSDKCTACancel) forState:UIControlStateNormal];
}

- (void)showCloseButton:(BOOL)show
{
    if (show) {
        self.tableViewBottomSpace.constant = 60;
    } else {
        self.tableViewBottomSpace.constant = 0;
    }

    [UIView animateWithDuration:0.3 animations:^{
        self.nextButton.alpha = show;
    }];
}

- (void)reset
{
    [self.calendarView reset];
}

- (void)animatePickupLabel:(NSString *)text
{
    self.pickupDateLabel.text = text;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0.5 options:0 animations:^{
        self.pickupDateLabel.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            self.pickupDateLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

- (void)animateDropoffLabel:(NSString *)text
{
    self.dropOffDateLabel.text = text;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0.5 options:0 animations:^{
        self.dropOffDateLabel.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            self.dropOffDateLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

- (IBAction)cancel:(id)sender
{
    [self reset];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)continueTapped:(id)sender {
    if (self.delegate) {
        [self.delegate didPickDates:self.pickupDate dropoffDate:self.dropoffDate];
    }
    [self reset];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
