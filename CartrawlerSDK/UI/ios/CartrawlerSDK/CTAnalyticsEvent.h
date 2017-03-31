//
//  CTAnalyticsEvent.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTAnalyticsEvent : NSObject

//The object variables are based off the DC Storm implementation, these may change once we decide a common ground for more analytics providers.

//This header file should be shared to any external analytics frameworks

@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventType;
@property (nonatomic, strong) NSString *orderID;
@property (nonatomic, strong) NSString *saleType;
@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSString *metricItem;

@end
