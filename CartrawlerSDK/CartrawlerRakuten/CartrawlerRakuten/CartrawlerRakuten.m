//
//  CartrawlerRakuten.m
//  CartrawlerRakuten
//
//  Created by Lee Maguire on 27/01/2017.
//  Copyright © 2017 Lee Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartrawlerRakuten.h"

@implementation CartrawlerRakuten

- (instancetype)init
{
    self = [super init];
    
    DCStorm* tracker = [DCStorm tracker];
    tracker.siteID = @"6957";// 5791
    tracker.appID = 55;
    tracker.trackingType = TrackingTypeAllEvents;
    tracker.dataConnectType = DataConnectTypeWiFi;
    [[DCStorm tracker] startTracking];
    
    return self;
}

- (void)didReceiveEvent:(CTAnalyticsEvent *)event
{
    NSDateFormatter *f = [NSDateFormatter new];
    f.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    
//    NSLog(@"event name %@", event.eventName);
//    NSLog(@"event type %@", event.eventType);
//    NSLog(@"params %@", event.params);
//    NSLog(@"time %@", [f stringFromDate:[NSDate date]]);

    NSError* error=nil;
    DCAppEvent* e = [[DCAppEvent alloc] initWithName:event.eventName type:event.eventType andParams:event.params];
    [e logWithError:&error];
}

- (void)didReceiveSaleEvent:(CTAnalyticsEvent *)event
{
//    NSLog(@"SALE: %@", event.orderID);
//    NSLog(@"SALE: %@", event.saleType);
//    NSLog(@"SALE: %@", event.quantity);
//    NSLog(@"SALE: %@", event.metricItem);
//    NSLog(@"SALE: %@", event.value);

    NSError* error=nil;
    DCSalesBasket *rentalBasket = [[DCSalesBasket alloc] initWithOrderID:event.orderID andSaleType:event.saleType];
    DCBasketItem *rentalItem = [[DCBasketItem alloc] initWithItemValue:event.value.floatValue andItemQuantity:event.quantity.intValue];
    [rentalItem.metrics setParamValueString:event.metricItem atIndex:1];
    [rentalBasket addItem: rentalItem];
    [rentalBasket logWithError:&error];
}

@end
