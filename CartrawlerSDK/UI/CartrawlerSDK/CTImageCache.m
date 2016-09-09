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

+ (void)forceLinkerLoad_
{
    
}

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

- (void)cachedImage:(NSURL *)imageUrl completion:(ImageCacheCompletion)completion;
{
    if ([[CTImageCache sharedInstance] objectForKey: imageUrl.absoluteString] == nil) {
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURLSessionTask *task = [defaultSession dataTaskWithURL:imageUrl
                                                             completionHandler:^(NSData * _Nullable data,
                                                                                 NSURLResponse * _Nullable response,
                                                                                 NSError * _Nullable error)
        {
            if (error == nil) {
                if (data != nil) {
                    UIImage *image = [[UIImage alloc] initWithData:data];
                    [[CTImageCache sharedInstance] setObject:image
                                                      forKey:imageUrl.absoluteString
                                                        cost:data.length];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(image);
                    });
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

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}



@end
