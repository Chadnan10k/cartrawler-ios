//
//  CTAPIResponse.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/24/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTAPIResponse : NSObject

@property (nonatomic, readonly) NSInteger requestID;
@property (nonatomic, readonly) id response;

+ (instancetype)newWithRequestID:(NSInteger)requestID response:(id)response;

@end
