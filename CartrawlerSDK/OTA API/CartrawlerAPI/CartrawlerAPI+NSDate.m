//
//  NSDateUtils.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 14/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerAPI+NSDate.h"

@implementation NSDate (CartrawlerAPI)

- (NSString *)stringFromDateWithFormat:(NSString *)format;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

@end
