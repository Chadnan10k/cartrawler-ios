//
//  CTCMSCommunicator.m
//  CartrawlerSDK
//
//  Created by Alan on 06/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTCMSCommunicator.h"

NSString * const CTCMSTestEndpoint = @"http://ajaxgeo.cartrawler.com/translations/%@.json";

@implementation CTCMSCommunicator

+ (void)fetchFile:(NSString *)filename withCompletionHandler:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completionHandler {
    NSString *path = [NSString stringWithFormat:CTCMSTestEndpoint, filename];
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"%@", request);
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completionHandler(data, error);
    }];
    [task resume];
}

@end
