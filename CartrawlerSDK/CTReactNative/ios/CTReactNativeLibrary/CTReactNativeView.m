//
//  CTReactNativeView.m
//  CTReactNative
//
//  Created by Alan on 07/04/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "CTReactNativeView.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

@implementation CTReactNativeView

- (instancetype)init
{
  self = [super init];
  if (self) {
    NSURL *jsCodeLocation;
    
    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"CTReactNative"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    
    [self addSubview:rootView];
    
    self addConstraints:<#(nonnull NSArray<__kindof NSLayoutConstraint *> *)#>
  }
  return self;
}

@end
