//
//  USState.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 25/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInsuranceSelectorItem.h"

@implementation CTInsuranceSelectorItem

- (instancetype)initWithName:(NSString *)name code:(NSString *)code
{
    self = [super init];
    
    _name = name;
    _code = code;
    
    return self;
}

@end
