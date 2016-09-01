//
//  PostRequest.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 11/04/2016.
//  Copyright © 2016 Lee Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTErrorResponse.h"

@interface PostRequest : NSObject <NSURLSessionDelegate>

typedef void (^PostCompletion)(NSDictionary *response, CTErrorResponse *error);

- (void)performRequestWithData:(NSString *)endPoint
                      jsonBody:(NSString *)jsonBody
                loggingEnabled:(BOOL)loggingEnabled
                    completion:(PostCompletion)completion;

- (void)cancel;

@end
