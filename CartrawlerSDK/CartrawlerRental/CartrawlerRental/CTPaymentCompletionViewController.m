//
//  CTPaymentCompletionViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 08/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentCompletionViewController.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTRentalSearch.h>
#import <CartrawlerSDK/CTImageCache.h>
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CartrawlerSDK+NSDateUtils.h>
#import <CartrawlerSDK/CTNextButton.h>
#import <CartrawlerSDK/CTView.h>
#import <CartrawlerSDK/CartrawlerSDK+UIView.h>
#import "CTBookingSummaryView.h"

@interface CTPaymentCompletionViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet CTLabel *paymentTitleLabel;
@property (weak, nonatomic) IBOutlet CTLabel *paymentSubtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImage;
@property (weak, nonatomic) IBOutlet CTLabel *bookingReferenceLabel;
@property (weak, nonatomic) IBOutlet CTLabel *emailLabel;
@property (weak, nonatomic) IBOutlet CTNextButton *doneButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet CTView *completionView;
@property (weak, nonatomic) IBOutlet CTView *summaryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryHeight;

@end

@implementation CTPaymentCompletionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    [self.doneButton setText:@"Back to homepage"];
    self.scrollView.backgroundColor = [CTAppearance instance].viewBackgroundColor;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Disable iOS 7 back gesture
    [CTAnalytics tagScreen:@"Step" detail:@"confirmati" step:@9];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view.
    [self.scrollView setContentOffset:CGPointZero];

    self.bookingReferenceLabel.text = [NSString stringWithFormat:@"%@", self.search.booking.confID ?: @"No Booking Ref"];
    self.emailLabel.text = [NSString stringWithFormat:@"We have sent a confirmation email to %@. This may take up to 15 minutes to arrive. Please review your voucher before picking up your car.", self.search.email];

}

- (IBAction)done:(id)sender
{
    [CTAnalytics tagScreen:@"Exit" detail:@"9" step:@9];
    [[CTImageCache sharedInstance] removeAllObjects];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"setSummary"]) {
        CTBookingSummaryView *vc = segue.destinationViewController;
        vc.search = self.search;
        [vc enableScroll:NO];
        __weak typeof (self) weakSelf = self;
        vc.heightChanged = ^(CGFloat height) {
            weakSelf.summaryHeight.constant = height;
        };
        segue.destinationViewController.view.translatesAutoresizingMaskIntoConstraints = NO;

    }
}

@end
