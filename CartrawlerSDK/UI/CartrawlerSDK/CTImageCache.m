//
//  CTImageCache.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTImageCache.h"

@interface CTImageCache() <NSURLSessionDelegate>

@end

@implementation CTImageCache




+ (CTImageCache *)sharedInstance {
    static CTImageCache *sharedInstance = nil;
    
    if (sharedInstance == nil) {
        sharedInstance = [[CTImageCache alloc] init];
        sharedInstance.name = @"CTImageCache";
        sharedInstance.countLimit = 100;
        sharedInstance.totalCostLimit = 10*1024*1024;
    }
    
    return sharedInstance;
}

//once again categories wont be available in a static framework so better off making static funcs
- (void)cachedImage:(NSURL *)imageUrl completion:(ImageCacheCompletion)completion;
{
    if ([[CTImageCache sharedInstance] objectForKey: imageUrl.absoluteString] == nil) {
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:imageUrl
                                                             completionHandler:^(NSData * _Nullable data,
                                                                                 NSURLResponse * _Nullable response,
                                                                                 NSError * _Nullable error)
                                  {
                                      if (error == nil) {
                                          if (data != nil) {
                                              UIImage *image = [[UIImage alloc] initWithData:data];
                                              
                                              if (image != nil) {
                                                  [[CTImageCache sharedInstance] setObject:image
                                                                                    forKey:imageUrl.absoluteString
                                                                                      cost:data.length];
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      completion(image);
                                                  });
                                              }
                                          }
                                      }
                                  }];
        
        [task resume];
        
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion([[CTImageCache sharedInstance] objectForKey: imageUrl.absoluteString]);
        });
    }
}

@end
