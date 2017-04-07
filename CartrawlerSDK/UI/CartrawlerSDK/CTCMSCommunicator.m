//
//  CTCMSCommunicator.m
//  CartrawlerSDK
//
//  Created by Alan on 06/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTCMSCommunicator.h"

@implementation CTCMSCommunicator

+ (void)fetchCMSIndexWithCompletionHandler:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completionHandler {
    [self fetchFile:@"http://localhost:8080/languages/version4.json" withCompletionHandler:completionHandler];
}

+ (void)fetchCMSLocalisation:(NSString *)filename withCompletionHandler:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completionHandler {
    NSString *path = [NSString stringWithFormat:@"http://localhost:8080/languages/%@", filename];
    [self fetchFile:path withCompletionHandler:completionHandler];
}


+ (void)fetchFile:(NSString *)path withCompletionHandler:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completionHandler {
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completionHandler(data, error);
    }];
    [task resume];
}

@end
