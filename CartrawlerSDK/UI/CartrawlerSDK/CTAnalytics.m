//
//  CTAnalytics.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 09/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAnalytics.h"
#import "CTAnalyticsCache.h"
#import "CTSDKSettings.h"

@interface CTAnalytics() <CTAnalyticsCacheDelegate>

@property (nonatomic, strong) NSURLSessionConfiguration *config;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) CTAnalyticsCache *cache;
@end

@implementation CTAnalytics

+ (instancetype)instance
{
    static CTAnalytics *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CTAnalytics alloc] init];
        sharedInstance.config = [NSURLSessionConfiguration defaultSessionConfiguration];
        sharedInstance.request = [[NSMutableURLRequest alloc] init];
        sharedInstance.cache = [CTAnalyticsCache new];
        sharedInstance.cache.delegate = sharedInstance;
    });
    return sharedInstance;
}

- (void)tagScreen:(nonnull NSString *)name
           detail:(nonnull NSString *)detail
             step:(nullable NSNumber *)step
{
    if (!step) {
        step = @(self.analyticsStep);
    }

    double time = [[NSDate date] timeIntervalSince1970] * 1000;
    NSNumberFormatter *nf = [NSNumberFormatter new];
    NSString *timeString = [nf stringFromNumber:[NSNumber numberWithDouble:time]];
    
    CTTag *tag = [[CTTag alloc] init:name
                              detail:detail
                           container:@3
                           timestamp:timeString
                        engineLoadID:[CTSDKSettings instance].engineLoadID ?: @"1"
                          customerID:[CTSDKSettings instance].customerID ?: @"1"
                             queryID:[CTSDKSettings instance].queryID ?: @"1"
                                step:step];
    [self.cache addTag:tag];
}

- (void)setAnalyticsStep:(CTAnalyticsStep)analyticsStep {
    _analyticsStep = analyticsStep;
}

- (void)tagError:(nonnull NSString *)step
           event:(nonnull NSString *)event
         message:(nonnull NSString *)message
{
    CTErrorTag *errorTag = [[CTErrorTag alloc] init:[CTSDKSettings instance].version
                                               step:step
                                              event:event
                                            message:message
                                       engineLoadID:[CTSDKSettings instance].engineLoadID
                                           clientId:[CTSDKSettings instance].clientId
                                             target:[CTSDKSettings instance].target];
    [self fireTag:errorTag.produceURL];
}

- (void)fireTag:(NSURL *)url
{
    NSURLSession *session = [NSURLSession sharedSession];
    self.request.URL = url;
    self.request.HTTPMethod = @"GET";
    self.request.timeoutInterval = 10;
    NSURLSessionDataTask *task = [session dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [task resume];
    [session finishTasksAndInvalidate];
}

// MARK: CTAnalyticsCacheDelegate

- (void)analyticsCache:(CTAnalyticsCache *)cache flushTags:(NSArray *)tags {
    [self fireTag:[CTTag produceURLForTags:tags]];
}



@end
