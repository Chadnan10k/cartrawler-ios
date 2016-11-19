//
//  GTPaymentViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTPaymentViewController.h"
#import "CTPaymentView.h"
#import "CTCheckbox.h"
#import "CTLabel.h"
#import "HTMLParser.h"
#import "CTAppearance.h"
#import "CTButton.h"

@interface GTPaymentViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *webViewContainer;
@property (strong, nonatomic) CTPaymentView *paymentView;
@property (weak, nonatomic) IBOutlet UITextView *termsLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet CTButton *confirmButton;

@end

@implementation GTPaymentViewController




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.paymentView setForGTPayment:self.groundSearch];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _paymentView = [[CTPaymentView alloc] initWithFrame:CGRectZero];
    [self.paymentView presentInView:self.webViewContainer];
        //TODO: fix
//    self.paymentView.completion = ^(BOOL success){
//        [weakSelf enableControls:YES];
//        if (success) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf pushToDestination];
//            });
//        } else {
//            
//        }
//    };
    
//    NSString *link1 = @"<a href='https://ajaxgeo.cartrawler.com/webapp-gt-1.6.36-3//tc/services/booking-conditions_EN.html'><b>Transfer conditions</b></a>";
//    NSString *link2 = @"<a href='https://ajaxgeo.cartrawler.com/webapp-gt-1.6.36-3//tc/booking/booking-conditions_EN.html'><b>Booking Terms and Conditions</b></a>";
//
//    NSString *termsStr = [NSString stringWithFormat:@"I agree to the %@ and %@ <style>body { text-align: center; }</style>", link1, link2];
//    
    //seems lazy but efficient
//    self.termsLabel.attributedText = [HTMLParser htmlStringWithFontFamily:[CTAppearance instance].fontName
//                                                                pointSize:15.0
//                                                                     text:termsStr
//                                                            boldFontColor:@"#000000"];
    self.termsLabel.delegate = self;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    return YES;
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)confirmPayment:(id)sender {
    [self enableControls:NO];
    [self.paymentView confirmPayment];
}

- (void)enableControls:(BOOL)enabled
{
    if (enabled) {
        self.backButton.enabled = YES;
        self.backButton.alpha = 1;
        self.confirmButton.enabled = YES;
        self.confirmButton.alpha = 1;
        self.termsLabel.userInteractionEnabled = YES;
    } else {
        self.backButton.enabled = NO;
        self.backButton.alpha = 0.8;
        self.confirmButton.enabled = NO;
        self.confirmButton.alpha = 0.8;
        self.termsLabel.userInteractionEnabled = NO;
        
    }
}

@end
