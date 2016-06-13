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
#import "NSDateUtils.h"

@interface CTCalendarViewController()

@property (weak, nonatomic) IBOutlet CTLabel *pickupDateLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dropOffDateLabel;
@property (weak, nonatomic) IBOutlet CTCalendarView *calendarView;

@end

@implementation CTCalendarViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.calendarView setupWithFrame:self.view.frame];
    
    self.calendarView.datesSelected = ^(NSDate *pickup, NSDate *dropoff){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (self.delegate != nil) {
                [self.delegate didPickDates:pickup dropoffDate:dropoff];
            }
            
            [self animateDateLabels:[NSDateUtils shortDescriptionFromDate:pickup]
                        dropoffText:[NSDateUtils shortDescriptionFromDate:dropoff]];
        });
    };
    
    self.calendarView.discard = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self animateDateLabels:NSLocalizedString(@"Select date", @"")
                        dropoffText:NSLocalizedString(@"Select date", @"")];
        });
    };
    
}

- (void)animateDateLabels:(NSString *)pickupText dropoffText:(NSString *)dropoffText
{
    self.pickupDateLabel.text = pickupText;
    self.dropOffDateLabel.text = dropoffText;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0.5 options:0 animations:^{
        self.pickupDateLabel.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.dropOffDateLabel.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            self.pickupDateLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.dropOffDateLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

- (IBAction)closeTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
