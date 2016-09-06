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

@interface PaymentViewController ()

@property (weak, nonatomic) IBOutlet UIView *webViewContainer;

@end

@implementation PaymentViewController

+(void)forceLinkerLoad_
{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    CTPaymentView *paymentView = [[CTPaymentView alloc] initWithFrame:CGRectZero];
    [paymentView presentInView:self.webViewContainer];
    [paymentView setForCarRentalPayment:self.search];
    
    __weak typeof (self) weakSelf = self;
    
    paymentView.completion = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf pushToDestination];
        });
    };
}


@end
