//
//  CTSearch.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSearch.h"

@implementation CTSearch

+ (instancetype)instance
{
    static CTSearch *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CTSearch alloc] init];
    });
    return sharedInstance;
}


@end
