//
//  CTAnalytics.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 09/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAnalytics.h"
#import "CTSDKSettings.h"

@interface CTAnalytics()

@property (nonatomic, strong) NSURLSessionConfiguration *config;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) NSURLSessionDataTask *task;
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
    NSLog(@"Tagging Name: %@ Detail: %@ Step: %@", name, detail, step);
    double time = [[NSDate date] timeIntervalSince1970] * 1000;
    NSNumberFormatter *nf = [NSNumberFormatter new];
    NSString *timeString = [nf stringFromNumber:[NSNumber numberWithDouble:time]];
    
    CTTag *tag = [[CTTag alloc] init:name
                              detail:detail
                           container:@3
                           timestamp:timeString
                        engineLoadID:[CTSDKSettings instance].engineLoadID ?: @""
                          customerID:[CTSDKSettings instance].customerID ?: @""
                             queryID:[CTSDKSettings instance].queryID ?: @""
                                step:step];
    
    [self fireTag:tag.produceURL];
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

@end
