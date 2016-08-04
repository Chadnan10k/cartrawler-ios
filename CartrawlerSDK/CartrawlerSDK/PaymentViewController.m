//
//  PaymentViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentRequest.h"

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
    self.webView.delegate = self;
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *b = [NSBundle bundleWithPath:bundlePath];
    
    NSString *htmlFile = [b pathForResource:@"CTPCI" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL: [b bundleURL]];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(currentState)
                                   userInfo:nil
                                    repeats:YES];
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
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    /* for overriding css
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [webView loadHTMLString:htmlString baseURL:baseURL];
     */

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

- (void)currentState
{
    
    
    NSString *currentState = [self.webView stringByEvaluatingJavaScriptFromString:@"getCurrentState()"];
    NSString *msg = [self.webView stringByEvaluatingJavaScriptFromString:@"securePaymentWin.postMessage(\"msg=blah\" , \"*\");"];
    
    NSString *s = [NSString stringWithFormat:@"generateMessage(%@)",[PaymentRequest payload]];
    
    NSString *test = [self.webView stringByEvaluatingJavaScriptFromString:s];
    
    

    /*
    if (![currentState isEqualToString:@"Loaded"]) {
        //inject msg
        NSString *msg = [self.webView stringByEvaluatingJavaScriptFromString:@"securePaymentWin.postMessage(\"msg=blah\" , \"*\");"];

    }
    
    */
}

@end
