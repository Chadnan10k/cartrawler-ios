//
//  CTReactNativeView.m
//  CartrawlerSDK
//
//  Created by Alan on 30/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTReactNativeView.h"
#import "RCTRootView.h"

@implementation CTReactNativeView

- (instancetype)init {
    NSURL *jsCodeLocation = [NSURL
                             URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
    self = [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
                                moduleName        : @"CarTrawler"
                                initialProperties : @{@"title" : @"This text was passed in from native code"}
                                 launchOptions    : nil];
    return self;
}

@end
