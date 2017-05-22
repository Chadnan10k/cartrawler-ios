//
//  CTAnalyticsCache.m
//  CartrawlerSDK
//
//  Created by Alan on 22/05/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAnalyticsCache.h"
#import "CTTag.h"

static NSInteger cacheLimit = 10;

@interface CTAnalyticsCache ()
@property (nonatomic, strong) NSMutableArray *cache;
@end

@implementation CTAnalyticsCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cache = [NSMutableArray new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}

- (void)addTag:(CTTag *)tag
{
    [self.cache addObject:tag];
    
    if (self.cache.count >= cacheLimit) {
        [self flushCache];
    }
}

- (void)flushCache {
    [self.delegate analyticsCache:self flushTags:self.cache];
    [self.cache removeAllObjects];
}

- (void)appWillResignActive:(NSNotification*)note
{
    [self flushCache];
}

- (void)appWillTerminate:(NSNotification*)note
{
    [self flushCache];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
    
}

@end
