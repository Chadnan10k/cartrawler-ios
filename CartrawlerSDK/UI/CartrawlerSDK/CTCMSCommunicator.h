//
//  CTCMSCommunicator.h
//  CartrawlerSDK
//
//  Created by Alan on 06/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCMSCommunicator : NSObject

+ (void)fetchCMSIndexWithCompletionHandler:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completionHandler;

+ (void)fetchCMSLocalisation:(NSString *)filename withCompletionHandler:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completionHandler;

@end
