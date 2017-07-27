//
//  CTAPIResponse.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/24/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAPIResponse.h"

@interface CTAPIResponse ()
@property (nonatomic, readwrite) NSInteger requestID;
@property (nonatomic, readwrite) id response;
@end

@implementation CTAPIResponse

+ (instancetype)newWithRequestID:(NSInteger)requestID response:(id)response {
    CTAPIResponse *APIResponse = [CTAPIResponse new];
    APIResponse.requestID = requestID;
    APIResponse.response = response;
    return APIResponse;
}


@end
