//
//  GroundTransportSearch.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GroundTransportSearch.h"

@implementation GroundTransportSearch


+ (instancetype)instance
{
    static GroundTransportSearch *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GroundTransportSearch alloc] init];
    });
    return sharedInstance;
}

- (void)reset
{
}

@end
