//
//  CTCMSCommunicator.h
//  CartrawlerSDK
//
//  Created by Alan on 06/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTCMSCommunicator : NSObject

+ (void)fetchFile:(NSString *)filename withCompletionHandler:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
