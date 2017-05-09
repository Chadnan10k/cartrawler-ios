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
#import <CartrawlerSDK/CTSDKSettings.h>

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
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Disable iOS 7 back gesture

    [self tagScreen];
    
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

    [self.scrollView setContentOffset:CGPointZero];

    self.bookingReferenceLabel.text = [NSString stringWithFormat:@"%@", self.search.booking.confID ?: CTLocalizedString(CTRentalErrorNoBookingRef)];
    self.emailLabel.text = [NSString stringWithFormat:CTLocalizedString(CTRentalReceiptEmailText), self.search.email];
    
    [self.doneButton setText:CTLocalizedString(CTRentalCTAToHomepage)];
    self.scrollView.backgroundColor = [CTAppearance instance].viewBackgroundColor;
    self.bookingReferenceTitleLabel.text = CTLocalizedString(CTRentalReceiptYourReference);
    self.scrollForSummaryLabel.text = CTLocalizedString(CTRentalReceiptScroll);
    self.paymentTitleLabel.text = CTLocalizedString(CTRentalReceiptCongratulations);
    self.paymentSubtitleLabel.text = CTLocalizedString(CTRentalReceiptSuccess);

}

- (IBAction)done:(id)sender
{
    [[CTAnalytics instance] tagScreen:@"exit" detail:@"9" step:@9];
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

#pragma mark Analytics

- (void)tagScreen
{

    [[CTAnalytics instance] tagScreen:@"step" detail:@"confirmati" step:@9];
    [self sendEvent:NO customParams:@{@"eventName" : @"Booking Confirmation Step",
                                      @"stepName" : @"Step9",
                                      } eventName:@"Step of search" eventType:@"Step"];

    NSString *vehName = [NSString stringWithFormat:@"%@ %@", self.search.selectedVehicle.vehicle.makeModelName,
                         self.search.selectedVehicle.vehicle.orSimilar];
    
//    [self sendEvent:NO customParams:@{@"eventName" : @"Booking",
//                                      @"reservationID" : self.search.booking.confID,
//                                      @"insuranceOffered" : self.search.insurance ? @"true" : @"false",
//                                      @"insurancePurchased" : self.search.isBuyingInsurance ? @"true" : @"false",
//                                      @"age" : self.search.driverAge.stringValue,
//                                      @"clientID" : [CTSDKSettings instance].clientId,
//                                      @"residenceID" : [CTSDKSettings instance].homeCountryCode,
//                                      @"pickupName" : self.search.pickupLocation.name,
//                                      @"pickupDate" : [self.search.pickupDate stringFromDateWithFormat:@"dd/MM/yyyy"],
//                                      @"returnName" : self.search.dropoffLocation.name,
//                                      @"returnDate" : [self.search.dropoffDate stringFromDateWithFormat:@"dd/MM/yyyy"],
//                                      @"carSelected" : vehName
//                                      } eventName:@"Booking" eventType:@"Booking"];
}

@end
