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
    NSString *endpoint = @"https://ct-images.imgix.net";
    NSURL *baseURL = [NSURL URLWithString:urlString];
    NSMutableString *path = [[NSMutableString alloc] initWithString:[baseURL path]];
    
    if (![path containsString:@"v5"] || ![path containsString:@"V5"]) {
        NSRange range = [path rangeOfString:@"/otaimages/"];
        if (range.location != NSNotFound && (![path containsString:@"v5"] && ![path containsString:@"V5"])) {
            [path insertString:@"v5/" atIndex:range.length];
        }
    }
    
    [path insertString:endpoint atIndex:0];
    [path appendString:@"?w=180&dpr=2"];

    return [[NSURL alloc] initWithString:path];
}

+ (NSURL *)gtVehicle:(NSString *)urlString
{
    NSString *endpoint = @"https://ct-images.imgix.net";
    NSURL *baseURL = [NSURL URLWithString:urlString];
    NSMutableString *path = [[NSMutableString alloc] initWithString:[baseURL path]];
    
    [path insertString:endpoint atIndex:0];
    [path appendString:@"?w=180&dpr=2"];
    
    return [[NSURL alloc] initWithString:path];
}

@end
