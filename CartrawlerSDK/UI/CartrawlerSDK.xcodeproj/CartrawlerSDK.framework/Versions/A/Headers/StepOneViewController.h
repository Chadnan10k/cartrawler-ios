//
//  StepOneViewController.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTMatchedLocation.h>
#import <CartrawlerAPI/CTVehicleAvailability.h>
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "StepTwoViewController.h"

@interface StepOneViewController : UIViewController

//Theseproperties must be set

//cartrawlerAPI is set by the sdk, no touchy
@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;
@property (nonatomic, strong) CTMatchedLocation *pickupLocation;
@property (nonatomic, strong) CTMatchedLocation *dropoffLocation;
@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSDate *dropoffDate;
@property (nonatomic, strong) NSNumber *driverAge;
@property (nonatomic, strong) CTVehicleAvailability *vehicleAvailability;
@property (nonatomic, strong) StepTwoViewController *stepTwoViewController;

- (void)pushToStepTwo;

@end

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