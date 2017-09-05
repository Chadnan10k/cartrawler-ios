//
//  CTSearchCalendarViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/20/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchCalendarViewController.h"
#import "CTAppController.h"
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

#import "CTAppController.h"
#import "CTSearchCalendarViewModel.h"

@interface CTSearchCalendarViewController ()
@property (weak, nonatomic) IBOutlet CTLabel *pickupDateLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dropOffDateLabel;
@property (weak, nonatomic) IBOutlet CTCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UIView *headerTopSection;

@property (weak, nonatomic) IBOutlet UIView *summaryView;
@property (weak, nonatomic) IBOutlet CTLabel *pickupTitleLabel;
@property (weak, nonatomic) IBOutlet CTLabel *returnTitleLabel;
@property (weak, nonatomic) IBOutlet CTLabel *calendarTitleLabel;
@property (weak, nonatomic) IBOutlet CTButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation CTSearchCalendarViewController

+ (Class)viewModelClass {
    return CTSearchCalendarViewModel.class;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.calendarTitleLabel.text = CTLocalizedString(CTSDKCalendarSelectDates);
    self.pickupTitleLabel.text = CTLocalizedString(CTSDKCalendarPickupDate);
    self.returnTitleLabel.text = CTLocalizedString(CTSDKCalendarReturnDate);
    self.pickupDateLabel.text = CTLocalizedString(CTSDKCalendarSelectDate);
    self.dropOffDateLabel.text = CTLocalizedString(CTSDKCalendarSelectDate);
    [self.cancelButton setTitle:CTLocalizedString(CTSDKCTACancel) forState:UIControlStateNormal];
    
    [self.calendarView setupWithFrame:self.view.frame];
    self.calendarView.dateSelected = ^(NSDate *date, BOOL headDate) {
        [CTAppController dispatchAction:CTActionSearchCalendarUserDidTapDate payload:date];
    };
    self.calendarView.discard = ^{
        [CTAppController dispatchAction:CTActionSearchCalendarUserDidDiscardDates payload:nil];
    };
}

- (void)updateWithViewModel:(CTSearchCalendarViewModel *)viewModel {
    self.headerTopSection.backgroundColor = viewModel.navigationBarColor;
    self.summaryView.backgroundColor = viewModel.navigationBarColor;
    self.nextButton.backgroundColor = viewModel.buttonColor;
    
    if (![self.pickupDateLabel.text isEqualToString:viewModel.displayedPickupDate]) {
        [self animateLabel:self.pickupDateLabel withText:viewModel.displayedPickupDate];
    }
    if (![self.dropOffDateLabel.text isEqualToString:viewModel.displayedDropoffDate]) {
        [self animateLabel:self.dropOffDateLabel withText:viewModel.displayedDropoffDate];
    }
    self.nextButton.enabled = viewModel.enableNextButton;
}

- (IBAction)cancel:(id)sender {
    [CTAppController dispatchAction:CTActionSearchCalendarUserDidTapCancel payload:nil];
}

- (IBAction)nextButtonTapped:(id)sender {
    [CTAppController dispatchAction:CTActionSearchCalendarUserDidTapNext payload:nil];
}

- (void)animateLabel:(UILabel *)label withText:(NSString *)text {
    label.text = text;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0.5 options:0 animations:^{
        label.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            label.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}

@end
