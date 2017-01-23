//
//  CTBookingSummaryViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 21/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTBookingSummaryViewController.h"
#import "CTBookingSummaryView.h"
#import <CartrawlerSDK/CTNextButton.h>

@interface CTBookingSummaryViewController ()

@property (weak, nonatomic) IBOutlet CTNextButton *continueButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerBottomSpace;

@end

@implementation CTBookingSummaryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.continueButton setText:@"Continue"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[CTAnalytics instance] tagScreen:@"Step" detail:@"vehicles-p" step:@7];
}

- (IBAction)next:(id)sender
{
    if (!self.destinationViewController) {
        [self dismiss];
    } else {
        [self pushToDestination];
    }
}

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CTBookingSummaryView *summaryView = segue.destinationViewController;
    summaryView.search = self.search;
}

@end
