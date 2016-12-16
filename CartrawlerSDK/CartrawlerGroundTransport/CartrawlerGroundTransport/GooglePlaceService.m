//
//  GooglePlaceService.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 01/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GooglePlaceService.h"
#import <CartrawlerAPI/CTMatchedLocation.h>

@implementation GooglePlaceService

+ (void)searchWithPartialString:(NSString *)partialString completion:(GooglePlaceCompletion)completion
{
    NSString *apiKey = @"AIzaSyAB0aBNFPW16YTrsjNyILOgIo39KzDdA3w";
    
    NSString *escapedStr = [partialString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=%@", escapedStr, apiKey]];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:Nil];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = url;
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    request.timeoutInterval = 30;
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                      completionHandler:
            ^(NSData *data, NSURLResponse *response, NSError *error) {
                NSError *serializationError;
                if (data != nil) {
                    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
                    if (responseDict) {
                        if ([responseDict[@"results"] isKindOfClass:[NSArray class]]) {
                            NSMutableArray <CTMatchedLocation *>*locs = [[NSMutableArray alloc] init];
                            NSArray <CTMatchedLocation *>*arr = responseDict[@"results"];
                            for (NSDictionary *d in arr) {
                                CTMatchedLocation *loc = [[CTMatchedLocation alloc] initWithGooglePlacesDictionary:d];
                                [locs addObject:loc];
                            }
                            completion(YES, locs);
                        }
                    } else {
                        completion(NO, @[]);
                    }
                } else {
                    completion(NO, @[]);
                }
            }];
    [task resume];
    [session finishTasksAndInvalidate];
}


@end
