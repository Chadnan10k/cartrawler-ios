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
@property (strong, nonatomic) CTPaymentView *paymentView;

@end

@implementation GTPaymentViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.paymentView setForGTPayment:self.groundSearch];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _paymentView = [[CTPaymentView alloc] initWithFrame:CGRectZero];
    [self.paymentView presentInView:self.webViewContainer];
    
    __weak typeof (self) weakSelf = self;
    
    self.paymentView.completion = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf pushToDestination];
        });
    };
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
