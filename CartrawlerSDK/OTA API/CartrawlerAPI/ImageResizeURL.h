//
//  ImageResizeURL.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 19/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageResizeURL : NSURL

+ (NSURL *)vendor:(NSString *)urlString;
+ (NSURL *)vehicle:(NSString *)urlString;

@end
