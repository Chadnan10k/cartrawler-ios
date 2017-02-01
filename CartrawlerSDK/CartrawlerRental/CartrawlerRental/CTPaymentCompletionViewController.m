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
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

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
@property (weak, nonatomic) IBOutlet CTLabel *bookingReferenceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scrollForSummaryLabel;

@end

@implementation CTPaymentCompletionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.doneButton setText:CTLocalizedString(CTRentalCTAToHomepage)];
    self.scrollView.backgroundColor = [CTAppearance instance].viewBackgroundColor;
    self.bookingReferenceTitleLabel = CTLocalizedString(CTRentalReceiptYourReference);
    self.scrollForSummaryLabel.text = CTLocalizedString(CTRentalReceiptScroll);
    self.paymentTitleLabel.text = CTLocalizedString(CTRentalReceiptCongratulations);
    self.paymentSubtitleLabel.text = CTLocalizedString(CTRentalReceiptSuccess);
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Disable iOS 7 back gesture
    [[CTAnalytics instance] tagScreen:@"Step" detail:@"confirmati" step:@9];
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

    self.bookingReferenceLabel.text = [NSString stringWithFormat:@"%@", self.search.booking.confID ?: CTLocalizedString(CTRentalErrorNoBookingRef)];
    self.emailLabel.text = [NSString stringWithFormat:@"%@ %@. %@", CTLocalizedString(CTRentalReceiptEmailText1), self.search.email, CTLocalizedString(CTRentalReceiptEmailText2)];

}

- (IBAction)done:(id)sender
{
    [[CTAnalytics instance] tagScreen:@"Exit" detail:@"9" step:@9];
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
