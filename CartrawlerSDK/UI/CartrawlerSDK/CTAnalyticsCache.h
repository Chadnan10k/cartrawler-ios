//
//  CTAnalyticsCache.h
//  CartrawlerSDK
//
//  Created by Alan on 22/05/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTTag.h"

@class CTAnalyticsCache;

/**
 Delegate which informs when the cache is being flushed
 */
@protocol CTAnalyticsCacheDelegate <NSObject>

/**
 Cache is being flushed

 @param cache the cache
 @param tags the tags
 */
- (void)analyticsCache:(CTAnalyticsCache *)cache flushTags:(NSArray *)tags;

@end

/**
 Stores analytics tags, so they can be fired in batches
 */
@interface CTAnalyticsCache : NSObject

/**
 A delegate
 */
@property (nonatomic, weak) id <CTAnalyticsCacheDelegate> delegate;

/**
 Add tag to cache

 @param tag the tag
 */
- (void)addTag:(CTTag *)tag;

@end
