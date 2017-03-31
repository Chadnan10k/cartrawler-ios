//
//  CartrawlerSDK+WKWebView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 10/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerSDK+WKWebView.h"

@implementation WKWebView(CartrawlerSDK)

- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script
{
    __block NSString *resultString = nil;
    __block BOOL finished = NO;
    
    [self evaluateJavaScript:script completionHandler:^(id result, NSError *error) {
        if (error == nil) {
            if (result != nil) {
                resultString = [NSString stringWithFormat:@"%@", result];
            }
        } else {
            NSLog(@"evaluateJavaScript error : %@", error.localizedDescription);
        }
        finished = YES;
    }];
    
    while (!finished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    return resultString;
}
@end
