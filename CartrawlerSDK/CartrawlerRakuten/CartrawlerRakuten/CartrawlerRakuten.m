//
//  CartrawlerRakuten.m
//  CartrawlerRakuten
//
//  Created by Lee Maguire on 27/01/2017.
//  Copyright © 2017 Lee Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartrawlerRakuten.h"
#import "headers/Tracker.h"

@implementation CartrawlerRakuten 

- (instancetype)init
{
    self = [super init];
    
    DCStorm* tracker = [DCStorm tracker];
    tracker.siteID = @"5791";
    tracker.appID = 1;
    tracker.trackingType = TrackingTypeAllEvents;
    tracker.dataConnectType = DataConnectTypeWiFi;
    [[DCStorm tracker] startTracking];
    
    return self;
}

- (void)didReceiveEvent:(CTAnalyticsEvent *)event
{
    NSLog(@"%@", event.eventName);
//    NSError* error=nil;
//    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys: @"Add to Basket", @"Target", @"Jane Doe", @"User", nil];
//    DCAppEvent* e = [[DCAppEvent alloc] initWithName:@"Tap" type:@"UserAction" andParams:params];
//    [e logWithError:&error];
}

- (void)didReceiveSaleEvent:(CTAnalyticsEvent *)event
{
    NSLog(@"%@", event.eventName);
}

@end
