//
//  GTPaymentViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTPaymentViewController.h"
#import "CTPaymentView.h"

@interface GTPaymentViewController ()
@property (weak, nonatomic) IBOutlet UIView *webViewContainer;

@end

@implementation GTPaymentViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CTPaymentView *paymentView = [[CTPaymentView alloc] initWithFrame:CGRectZero];
    [paymentView presentInView:self.webViewContainer];
    [paymentView setForGTPayment:self.groundSearch];
    
    __weak typeof (self) weakSelf = self;
    
    paymentView.completion = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf pushToDestination];
        });
    };
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
