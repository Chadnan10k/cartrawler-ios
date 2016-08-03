//
//  PaymentViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentViewController.h"

@interface PaymentViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PaymentViewController

+(void)forceLinkerLoad_
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *urlString = @"http://otatest.cartrawler.com:20002/cartrawlerpay/paymentform?mobile=true&type=OTA_VehResRQ";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    self.webView.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Web View

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *msgStr = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];

    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *b = [NSBundle bundleWithPath:bundlePath];
    NSString *filePath = [b pathForResource:@"samplePayment" ofType:@"json"];
    if (filePath) {
        NSString *samplePayment = [NSString stringWithContentsOfFile:filePath];
        if (samplePayment) {
            
            samplePayment = [samplePayment stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            msgStr = [msgStr stringByReplacingOccurrencesOfString:@"msg="
                                                       withString:@"[YOUR MSG]"];

        }
    }
    
    NSData* data = [msgStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *msgReq = [[NSMutableURLRequest alloc] initWithURL:request.URL];
    msgReq.HTTPMethod = @"POST";
    msgReq.HTTPBody = data;
    request = msgReq;
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    /* for overriding css
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [webView loadHTMLString:htmlString baseURL:baseURL];
     */
    
    [webView stringByEvaluatingJavaScriptFromString:@"validateForm();"];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

@end
