//
//  CartrawlerSDK+WKWebView.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 10/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface WKWebView (CartrawlerSDK)

- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;

@end
