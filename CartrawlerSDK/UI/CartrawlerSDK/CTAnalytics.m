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

@implementation CTAnalytics

static const NSString *CTTagEndpoint = @"";

+ (void)tagScreen:(nonnull NSString *)name
           detail:(nonnull NSString *)detail
        container:(nonnull NSNumber *)container
        timestamp:(nonnull NSString *)timestamp
     engineLoadID:(nonnull NSString *)engineLoadID
       customerID:(nonnull NSString *)customerID
          queryID:(nonnull NSString *)queryID
             step:(nonnull NSNumber *)step
{
    CTTag *tag = [[CTTag alloc] init:name
                              detail:detail
                           container:container
                           timestamp:timestamp
                        engineLoadID:engineLoadID
                          customerID:customerID
                             queryID:queryID
                                step:step];
    
    [self fireTag:tag.toDictionary];
    
}

+ (void)tagError:(nonnull NSString *)version
            step:(nonnull NSString *)step
           event:(nonnull NSString *)event
         message:(nonnull NSString *)message
    engineLoadID:(nonnull NSString *)engineLoadID
        clientId:(nonnull NSString *)clientId
          target:(nonnull NSString *)target
{
    //test
    CTErrorTag *errorTag = [[CTErrorTag alloc] init:@"2.0.3"
                                               step:@"step1"
                                              event:@"search"
                                            message:@"no results"
                                       engineLoadID:@"1234567890"
                                           clientId:@"123456"
                                             target:@"Test"];
    
    NSLog(@"%@", errorTag);
    
}

+ (void)fireTag:(NSDictionary *)tagDict
{
    
}

@end
