//
//  CTTimePickerView.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 13/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTTimePickerView.h"

@interface CTTimePickerView()

@property (nonatomic, strong) UIDatePicker *pickerView;
@property (nonatomic, strong) UIView *superview;
@property (nonatomic, strong) UIView *view;

@end

@implementation CTTimePickerView




- (id)initInView:(UIView *)superview mininumDate:(NSDate *)mininumDate
{
    self = [super init];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    _pickerView = [[UIDatePicker alloc] init];
    self.pickerView.datePickerMode = UIDatePickerModeTime;
    self.pickerView.minuteInterval = 15;
    if (mininumDate) {
        self.pickerView.minimumDate = mininumDate;
    }
    [superview addSubview: view];
    _superview = superview;
    
    view.translatesAutoresizingMaskIntoConstraints = false;
    

    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.superview
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:0];

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.superview
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0];

    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.superview
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:0];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeHeight
                                                                      multiplier:1.0
                                                                        constant:200];
    [self.superview addConstraints:@[heightConstraint,
                                     bottomConstraint,
                                     leftConstraint,
                                     rightConstraint]];

    [view addSubview:self.pickerView];
    self.pickerView.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint *xCenterConstraint = [NSLayoutConstraint constraintWithItem:self.pickerView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:view
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0];
    [superview addConstraint:xCenterConstraint];
    
    NSLayoutConstraint *yCenterConstraint = [NSLayoutConstraint constraintWithItem:self.pickerView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:view
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:0];
    [superview addConstraint:yCenterConstraint];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectZero];
    toolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hide)];
    
    toolBar.items = @[btn];
    [view addSubview:toolBar];
    
    toolBar.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint *toolbarBottomConstraint = [NSLayoutConstraint constraintWithItem:toolBar
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:view
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1.0
                                                                         constant:0];
    
    NSLayoutConstraint *toolbarLeftConstraint = [NSLayoutConstraint constraintWithItem:toolBar
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:view
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0];
    
    NSLayoutConstraint *toolbarRightConstraint = [NSLayoutConstraint constraintWithItem:toolBar
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:view
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:0];
    
    NSLayoutConstraint *toolbarHeightConstraint = [NSLayoutConstraint constraintWithItem:toolBar
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1.0
                                                                         constant:35];
    [self.superview addConstraints:@[toolbarBottomConstraint,
                                     toolbarLeftConstraint,
                                     toolbarRightConstraint,
                                     toolbarHeightConstraint]];
    
    [self.pickerView addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];

    view.backgroundColor = [UIColor whiteColor];
    
    view.alpha = 0;
    _view = view;
    return self;
}

- (BOOL)validateDate:(NSDate *)date
{
    NSDateComponents *comp = [[NSCalendar currentCalendar]
                              components:NSCalendarUnitMinute
                              fromDate:date];
    
    NSInteger dateMinute = comp.minute;
    
    return (dateMinute%15 == 0);
    
}

//From: http://stackoverflow.com/questions/6948297/uidatepicker-odd-behavior-when-setting-minuteinterval
- (NSDate *)roundedDate:(NSDate *)inDate{
    
    NSDate *returnDate;
    NSInteger minuteInterval = 15;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:inDate];
    NSInteger minutes = dateComponents.minute;
    NSInteger minutesRounded = ( (NSInteger)(minutes / minuteInterval) ) * minuteInterval;
    NSDate *roundedDate = [[NSDate alloc] initWithTimeInterval:60.0 * (minutesRounded - minutes) sinceDate:inDate];
    returnDate = roundedDate;
    return returnDate;
}

- (void)present
{
    [UIView animateWithDuration:0.1 animations:^{
        self.view.alpha = 1;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.1 animations:^{
        self.view.alpha = 0;
    }];
    
    if (self.timeSelection) {
        if ([self validateDate:self.pickerView.date]) {
            self.timeSelection(self.pickerView.date);
        } else {
            self.timeSelection([self roundedDate:self.pickerView.date]);
        }
    }
}

- (void)dateChanged
{
    if (self.timeSelection) {
        self.timeSelection(self.pickerView.date);
    }
}

@end
