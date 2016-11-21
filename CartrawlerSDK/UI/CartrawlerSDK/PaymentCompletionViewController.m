//
//  PaymentCompletionViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 08/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentCompletionViewController.h"
#import "CTLabel.h"
#import "CarRentalSearch.h"
#import "CTImageCache.h"
#import "CTAppearance.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CTNextButton.h"
#import "CTView.h"
#import "CartrawlerSDK+UIView.h"
#import "CTBookingSummaryView.h"

@interface PaymentCompletionViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet CTLabel *paymentTitleLabel;
@property (weak, nonatomic) IBOutlet CTLabel *paymentSubtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImage;
@property (weak, nonatomic) IBOutlet CTLabel *bookingReferenceLabel;
@property (weak, nonatomic) IBOutlet CTLabel *emailLabel;
@property (weak, nonatomic) IBOutlet CTNextButton *doneButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet CTView *completionView;
@property (weak, nonatomic) IBOutlet UIView *summaryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryHeight;

@end

@implementation PaymentCompletionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    [self.doneButton setText:@"Back to homepage" didTap:^{
        [weakSelf done];
    }];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Disable iOS 7 back gesture
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

    self.bookingReferenceLabel.text = [NSString stringWithFormat:@"%@", self.search.booking.confID ?: @"CTTest123456789"];
    self.emailLabel.text = [NSString stringWithFormat:@"We have sent a confirmation email to %@. This may take up to 15 minutes to arrive. Please review your voucher before picking up your car.", self.search.email];

}

- (void)done {
    
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
    }
}

@end
