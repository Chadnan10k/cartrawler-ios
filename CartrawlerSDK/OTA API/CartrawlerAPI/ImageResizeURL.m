//
//  ImageResizeURL.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 19/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ImageResizeURL.h"

@implementation ImageResizeURL

+ (NSURL *)vendor:(NSString *)urlString
{
    NSRange range = [urlString rangeOfString:@"/vendor/"];
    
    if (range.location == NSNotFound) {
        return [[NSURL alloc] initWithString:urlString ?: @""];
    }
    else {
        NSMutableString *newURLString = [NSMutableString stringWithString:urlString];
        [newURLString insertString:@"large/" atIndex: range.location + range.length];
        return [[NSURL alloc] initWithString:newURLString];
    }
}

+ (NSURL *)vehicle:(NSString *)urlString
{
    //TODO: get resizing url
    return [[NSURL alloc] initWithString:urlString ?: @""];
}

@end
