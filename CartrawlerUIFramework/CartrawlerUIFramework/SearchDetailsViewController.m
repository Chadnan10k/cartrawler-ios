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
#import "NSDateUtils.h"
#import "CTTimePickerView.h"

@interface SearchDetailsViewController () <CTCalendarDelegate>

@property (weak, nonatomic) IBOutlet UIView *pickupContainer;
@property (weak, nonatomic) IBOutlet UIView *dropoffContainer;
@property (weak, nonatomic) IBOutlet UIView *pickupTimeContainer;
@property (weak, nonatomic) IBOutlet UIView *dropoffTimeContainer;
@property (weak, nonatomic) IBOutlet UIView *calendarContainer;
@property (weak, nonatomic) IBOutlet UIView *ageContainer;
@property (weak, nonatomic) IBOutlet UIView *sameLocationCheckBox;
@property (weak, nonatomic) IBOutlet UIView *ageCheckBoxContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropoffLocTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ageTopConstraint;

@property (strong, nonatomic) UIView *activeView;

@property (strong, nonatomic) CTSelectView *pickupView;
@property (strong, nonatomic) CTSelectView *calendarView;

@end

@implementation SearchDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof (self) weakSelf = self;
    
    self.pickupView = [[CTSelectView alloc] initWithView:self.pickupContainer placeholder:@"Pick-up location"];
    self.pickupView.viewTapped = ^{
        _activeView = self.pickupView;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LocationSearchViewController *locSearchVC = [storyboard instantiateViewControllerWithIdentifier:@"LocationSearchViewController"];
        [weakSelf presentViewController:locSearchVC animated:YES completion:nil];
        
        locSearchVC.selectedLocation = ^(__weak CTMatchedLocation *location){
            NSLog(@"%@", location.name);
            [weakSelf.pickupView setTextFieldText:location.name];
        };
    };
    
    _activeView = self.pickupView;
    
    CTSelectView *pickupTimeView = [[CTSelectView alloc] initWithView:self.pickupTimeContainer placeholder:@"Pick-up time"];
    pickupTimeView.viewTapped = ^{
        NSLog(@"Tapped");
        _activeView = pickupTimeView;
    };
    
    CTSelectView *dropoffTimeView = [[CTSelectView alloc] initWithView:self.dropoffTimeContainer placeholder:@"Drop-off time"];
    dropoffTimeView.viewTapped = ^{
        NSLog(@"Tapped");
        _activeView = dropoffTimeView;
    };
    
    _calendarView = [[CTSelectView alloc] initWithView:self.calendarContainer placeholder:@"Select dates"];
    self.calendarView.viewTapped = ^{
        NSLog(@"Tapped");
        _activeView = self.calendarView;
        CTCalendarViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CTCalendarViewController"];
        vc.delegate = weakSelf;
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };
    
    CTSelectView *ageView = [[CTSelectView alloc] initWithView:self.ageContainer placeholder:@"age"];
    ageView.viewTapped = ^{
        NSLog(@"Tapped");
        _activeView = ageView;
    };
    
    CTCheckbox *sameLoc = [[CTCheckbox alloc] initEnabled:YES containerView:self.sameLocationCheckBox ];
    sameLoc.viewTapped = ^(BOOL selection) {
        NSLog(@"selection %d", selection);
        _activeView = sameLoc;
    };
    
    
    CTCheckbox *ageCheckbox = [[CTCheckbox alloc] initEnabled:YES containerView:self.ageCheckBoxContainer];
    ageCheckbox.viewTapped = ^(BOOL selection) {
        NSLog(@"selection %d", selection);
        if (selection) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.ageTopConstraint.constant = 0;
                [UIView animateWithDuration:0.3 animations:^{
                    self.ageContainer.alpha = 0;
                    [self.view layoutIfNeeded];
                }];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.ageTopConstraint.constant = 50;
               [UIView animateWithDuration:0.3 animations:^{
                   self.ageContainer.alpha = 1;
                   [self.view layoutIfNeeded];
               }];
            });
        }
    };
    
    self.dropoffLocTopConstraint.constant = 30;
    self.dropoffContainer.alpha = 0;
    
    self.ageTopConstraint.constant = 0;
    self.ageContainer.alpha = 0;
    
    [self.view layoutIfNeeded];

}

#pragma marl Calendar delegate

- (void)didPickDates:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate
{
    NSString *dateString = [NSString stringWithFormat:@"%@ - %@",
                            [NSDateUtils shortDescriptionFromDate:pickupDate],
                            [NSDateUtils shortDescriptionFromDate:dropoffDate]];
    
    [self.calendarView setTextFieldText:dateString];
}

//- (void)registerForKeyboardNotifications
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//}
//
//- (void)deregisterForKeyboardNotifications
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//}
//
//
//- (void)keyboardWillHide:(NSNotification *)n
//{
//    NSDictionary* userInfo = [n userInfo];
//    
//    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    CGRect viewFrame = self.scrollView.frame;
//    viewFrame.size.height += (keyboardSize.height + 45);
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [self.scrollView setFrame:viewFrame];
//    [UIView commitAnimations];
//}
//
//- (void)keyboardWillShow:(NSNotification *)n
//{
//
//    NSDictionary* userInfo = [n userInfo];
//    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    CGRect viewFrame = self.scrollView.frame;
//
//    viewFrame.size.height -= (keyboardSize.height + 45);
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [self.scrollView setFrame:viewFrame];
//    [UIView commitAnimations];
//}

- (IBAction)searchTapped:(id)sender
{
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
