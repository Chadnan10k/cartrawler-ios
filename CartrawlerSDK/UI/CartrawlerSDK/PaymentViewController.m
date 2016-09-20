//
//  PaymentViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentRequest.h"
#import "CTSDKSettings.h"
#import "NSDateUtils.h"
#import "PaymentCompletionViewController.h"
#import "Reachability.h"
#import "CTPaymentView.h"
#import "CTCheckbox.h"
#import "HTMLParser.h"
#import "CTAppearance.h"
#import "TermsViewController.h"

@interface PaymentViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *webViewContainer;
@property (strong, nonatomic) CTPaymentView *paymentView;
@property (weak, nonatomic) IBOutlet CTCheckbox *termsCheckbox;
@property (weak, nonatomic) IBOutlet UITextView *termsLabel;

@end

@implementation PaymentViewController

+(void)forceLinkerLoad_
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.paymentView setForCarRentalPayment:self.search];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _paymentView = [[CTPaymentView alloc] initWithFrame:CGRectZero];
    [self.paymentView presentInView:self.webViewContainer];
    
    __weak typeof (self) weakSelf = self;
    
    self.paymentView.completion = ^(CTBooking *booking){
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.search.booking = booking;
            [weakSelf pushToDestination];
        });
    };
    self.termsCheckbox.viewTapped = ^(BOOL tapped){
        [weakSelf.paymentView termsAndConditionsChecked:tapped];
    };
    
    NSString *link1 = @"<a href='www.cartrawler.com'><b>Rental conditions</b></a>";
    
    NSString *termsStr = [NSString stringWithFormat:@"I agree to the %@ <style>body { text-align: center; }</style>", link1];
    
    //seems lazy but efficient
    self.termsLabel.attributedText = [HTMLParser htmlStringWithFontFamily:[CTAppearance instance].fontName
                                                                pointSize:15.0
                                                                     text:termsStr
                                                            boldFontColor:@"#000000"];
    self.termsLabel.delegate = self;
    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSBundle* bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle]URLForResource:@"CartrawlerResources" withExtension:@"bundle"]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepThree" bundle:bundle];
    UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"TermsViewControllerNav"];
    TermsViewController *vc = (TermsViewController *)nav.topViewController;
    [vc setData:self.search cartrawlerAPI:self.cartrawlerAPI];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:nav animated:YES completion:nil];
    });
    return NO;
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)confirmPayment:(id)sender {
    [self.paymentView confirmPayment];
}


@end
