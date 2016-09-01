//
//  InsuranceLink.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 25/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "InsuranceLink.h"

@implementation InsuranceLink

- (instancetype)initWithLink:(NSString *)link title:(NSString *)title code:(NSString *)code
{
    self = [super init];
    
    _link = [NSURL URLWithString:link];
    _title = title;
    _code = code;
    
    return self;
}

@end
