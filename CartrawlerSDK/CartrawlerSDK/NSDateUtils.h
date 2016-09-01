//
//  NSDateUtils.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 14/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateUtils : NSDate
//static framework doesnt like categories so I guess we're stuck creating extensions like this

+ (NSString *)stringFromDateWithFormat:(NSDate *)date format:(NSString *)format;

@end