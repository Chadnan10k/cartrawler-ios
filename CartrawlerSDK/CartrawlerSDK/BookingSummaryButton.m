//
//  BookingSummaryButton.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "BookingSummaryButton.h"
#import "BookingSummaryViewController.h"

@interface BookingSummaryButton()

@property (strong, nonatomic) NSLayoutConstraint *topConstraint;
@property (strong, nonatomic) NSLayoutConstraint *bottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *rightConstraint;
@property (strong, nonatomic) BookingSummaryViewController *bookingSummaryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryHeight;

@end

@implementation BookingSummaryButton
{
    BOOL summaryVisible;
}

+ (void)forceLinkerLoad_
{
    
}

- (void)setDataWithVehicle:(CTVehicle *)vehicle
                pickupDate:(NSDate *)pickupDate
               dropoffDate:(NSDate *)dropoffDate
         isBuyingInsurance:(BOOL)isBuyingInsurance
{
    if (!self.bookingSummaryView) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepFive" bundle:b];
        _bookingSummaryView = [storyboard instantiateViewControllerWithIdentifier:@"BookingSummaryView"];
    }
    [self.bookingSummaryView setDataWithVehicle:vehicle
                                     pickupDate:pickupDate
                                    dropoffDate:dropoffDate
                              isBuyingInsurance:isBuyingInsurance];
}

- (void)closeIfOpen
{
    if (summaryVisible) {
        self.summaryHeight.constant = 50;
        
        [self removeConstraints:@[self.topConstraint,
                                  self.bottomConstraint,
                                  self.leftConstraint,
                                  self.rightConstraint]];
        
        [self.bookingSummaryView.view removeFromSuperview];
        summaryVisible = NO;
    }
}

- (void)closeView
{
    if (summaryVisible) {
        self.summaryHeight.constant = 50;
        
        [self removeConstraints:@[self.topConstraint,
                                  self.bottomConstraint,
                                  self.leftConstraint,
                                  self.rightConstraint]];
        
        [self.bookingSummaryView.view removeFromSuperview];
        summaryVisible = NO;
    } else {
        self.summaryHeight.constant = 320;
        
        
        [self addSubview:self.bookingSummaryView.view];
        
        self.bookingSummaryView.view.translatesAutoresizingMaskIntoConstraints = false;
        self.translatesAutoresizingMaskIntoConstraints = false;
        
        self.topConstraint = [NSLayoutConstraint constraintWithItem:self.bookingSummaryView.view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:50];
        
        self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.bookingSummaryView.view
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0
                                                              constant:0];
        
        self.leftConstraint = [NSLayoutConstraint constraintWithItem:self.bookingSummaryView.view
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0
                                                            constant:5];
        
        self.rightConstraint = [NSLayoutConstraint constraintWithItem:self.bookingSummaryView.view
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1.0
                                                             constant:-5];
        [self addConstraints:@[self.topConstraint,
                               self.bottomConstraint,
                               self.leftConstraint,
                               self.rightConstraint]];
        
        summaryVisible = YES;
    }
}

- (IBAction)viewTapped:(id)sender
{
    [self closeView];
}

@end
