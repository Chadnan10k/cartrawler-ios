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
#import <CartrawlerSDK/CTLabel.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import "CTRentalLocalizationConstants.h"

@interface CTBookingSummaryViewController ()

@property (weak, nonatomic) IBOutlet CTNextButton *continueButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerBottomSpace;
@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;

@end

@implementation CTBookingSummaryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.continueButton setText:CTLocalizedString(CTRentalCTAContinue)];
    self.titleLabel.text = CTLocalizedString(CTRentalTitleSummary);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self tagScreen];
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

#pragma mark Analytics

- (void)tagScreen
{
    [[CTAnalytics instance] tagScreen:@"Step" detail:@"vehicles-p" step:@7];
    [self sendEvent:NO customParams:@{@"eventName" : @"Booking Summary Step",
                                      @"stepName" : @"Step7",
                                      } eventName:@"Step of search" eventType:@"Step"];
}

@end
