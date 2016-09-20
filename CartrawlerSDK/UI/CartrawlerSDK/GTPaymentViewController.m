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

@interface GTPaymentViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *webViewContainer;
@property (strong, nonatomic) CTPaymentView *paymentView;
@property (weak, nonatomic) IBOutlet CTCheckbox *termsCheckbox;
@property (weak, nonatomic) IBOutlet UITextView *termsLabel;

@end

@implementation GTPaymentViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.paymentView setForGTPayment:self.groundSearch];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _paymentView = [[CTPaymentView alloc] initWithFrame:CGRectZero];
    [self.paymentView presentInView:self.webViewContainer];
    
    __weak typeof (self) weakSelf = self;
    
    self.paymentView.completion = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf pushToDestination];
        });
    };
    
    self.termsCheckbox.viewTapped = ^(BOOL tapped){
        [weakSelf.paymentView termsAndConditionsChecked:tapped];
    };
    
    NSString *link1 = @"<a href='https://ajaxgeo.cartrawler.com/webapp-gt-1.6.36-3//tc/services/booking-conditions_EN.html'><b>Transfer conditions</b></a>";
    NSString *link2 = @"<a href='https://ajaxgeo.cartrawler.com/webapp-gt-1.6.36-3//tc/booking/booking-conditions_EN.html'><b>Booking Terms and Conditions</b></a>";

    NSString *termsStr = [NSString stringWithFormat:@"I agree to the %@ and %@ <style>body { text-align: center; }</style>", link1, link2];
    
    //seems lazy but efficient
    self.termsLabel.attributedText = [HTMLParser htmlStringWithFontFamily:[CTAppearance instance].fontName
                                                                pointSize:15.0
                                                                     text:termsStr
                                                            boldFontColor:@"#000000"];
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
    [self.paymentView confirmPayment];
}

@end
