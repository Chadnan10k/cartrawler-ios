//
//  CTImageCache.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CTImageCache : NSCache

typedef void (^ImageCacheCompletion)(UIImage *image);

+ (CTImageCache *)sharedInstance;
- (void)cachedImage:(NSURL *)imageUrl completion:(ImageCacheCompletion)completion;

@end
