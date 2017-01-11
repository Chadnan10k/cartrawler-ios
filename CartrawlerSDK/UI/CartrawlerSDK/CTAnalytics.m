//
//  CTAnalytics.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 09/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAnalytics.h"
#import "CTTag.h"
#import "CTErrorTag.h"
#import "CTSDKSettings.h"

@implementation CTAnalytics

+ (void)tagScreen:(nonnull NSString *)name
           detail:(nonnull NSString *)detail
             step:(nonnull NSNumber *)step
{
    
    double time = [[NSDate date] timeIntervalSince1970];
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
    
    [self fireTag:tag.toDictionary];
}

+ (void)tagError:(nonnull NSString *)step
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
    [self fireErrorTag:errorTag.produceURL];
}

+ (void)fireTag:(NSDictionary *)tagDict
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:Nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:@"https://tag.cartrawler.com/"];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 10;
    NSError *error;
    NSData *processedData = [NSJSONSerialization dataWithJSONObject:tagDict
                                                            options:NSJSONWritingPrettyPrinted
                                                              error:&error];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    request.HTTPBody = processedData;
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (error) {
                                          NSLog(@"CartrawlerSDK: Can't push tag");
                                      } 
                                  }];
    [task resume];
    [session finishTasksAndInvalidate];
}

+ (void)fireErrorTag:(NSURL *)url
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:Nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = url;
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 10;

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                      completionHandler:
            ^(NSData *data, NSURLResponse *response, NSError *error) {
                if (error) {
                    NSLog(@"CartrawlerSDK: Can't push error tag");
                }
            }];
    [task resume];
    [session finishTasksAndInvalidate];
}

@end
