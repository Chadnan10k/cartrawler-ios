//
//  CSVItem.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CSVItem.h"

@implementation CSVItem

- (id)initWithName:(NSString *)name code:(NSString *)code
{
    self = [super init];
    _name = name;
    _code = code;
    return self;
}

@end
