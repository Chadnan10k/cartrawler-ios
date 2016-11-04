//
//  PostRequest.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 11/04/2016.
//  Copyright © 2016 Lee Maguire. All rights reserved.
//

#import "CTPostRequest.h"

@implementation CTPostRequest {
    BOOL performingRequest;
    NSURLSessionDataTask *task;
    NSDictionary *responseDict;
    NSURLSession *session;
}

- (void)performRequestWithData:(NSString *)endPoint
                      jsonBody:(NSString *)jsonBody
                loggingEnabled:(BOOL)loggingEnabled
                    completion:(PostCompletion)completion
{
        //[self cancel];//cancel anything in progress
        NSURL *url = [NSURL URLWithString: endPoint];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:Nil];
        
        if (jsonBody != nil && endPoint != nil && ![jsonBody isEqualToString:@""]) {
            
            NSData *processedData = [jsonBody dataUsingEncoding:NSUTF8StringEncoding];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            request.URL = url;
            request.HTTPMethod = @"POST";
            [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
            request.HTTPBody = processedData;
            request.timeoutInterval = 30;
            
            if (loggingEnabled)
                NSLog(@"\n*************REQUEST***************\n\nEND POINT: %@\n\n%@\n\n******************************", endPoint, jsonBody);
            
           task = [session dataTaskWithRequest:request
                                                    completionHandler:
                                          ^(NSData *data, NSURLResponse *response, NSError *error) {
                                              NSError *serializationError;
                                              if (data != nil) {
                                                  responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
                                                  if (responseDict[@"Errors"] != nil || responseDict[@"@ErrorCode"] != nil || responseDict == nil) {
                                                      completion(nil, [[CTErrorResponse alloc]initWithDictionary: responseDict]);
                                                  } else {
                                                      completion(responseDict, nil);
                                                  }
                                                  if (loggingEnabled)
                                                      NSLog(@"\n*************RESPONSE***************\n\n%@\n\n*****************************", responseDict);

                                              } else {
                                                  if (loggingEnabled)
                                                      NSLog(@"\n*************RESPONSE***************\n\nNO JSON RESPONSE\n\n*****************************");
                                                  completion(nil, [[CTErrorResponse alloc]initWithDictionary: nil]);
                                              }
                                          }];
            [task resume];
            [session finishTasksAndInvalidate];
        } else {
            completion(nil, [[CTErrorResponse alloc]initWithDictionary: nil]);
        }
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
        completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}

- (void)cancel {
    if (task.state == NSURLSessionTaskStateRunning) {
        [task cancel];
        [session finishTasksAndInvalidate];
    }
}

@end
