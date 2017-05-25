//
//  CTAnalyticsTests.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 10/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CTErrorTag.h"
#import "CTAnalytics.h"
#import "CTSDKSettings.h"
#import "CTTag.h"

@interface CTAnalyticsTests : XCTestCase

@end

@implementation CTAnalyticsTests

- (void)test_errorTag_returnsURL
{
    CTErrorTag *errorTag = [[CTErrorTag alloc] init:@"2.0.3"
                                               step:@"step1"
                                              event:@"search"
                                            message:@"no results"
                                       engineLoadID:@"1234567890"
                                           clientId:@"123456"
                                             target:@"Test"];
    XCTAssertTrue([errorTag.produceURL.absoluteString isEqualToString:@"https://ct-errs.cartrawler.com/v5log?app=MO&ver=2.0.3&lvl=Info&dv=iOS&action=step1&subAction=search&desc=no%20results&elID=1234567890&clientID=123456&target=Test"]);
}

@end
