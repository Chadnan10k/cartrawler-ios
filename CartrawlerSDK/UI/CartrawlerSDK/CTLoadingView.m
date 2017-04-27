//
//  CTLoadingView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 20/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTLoadingView.h"
#import "CartrawlerSDK+UIView.h"

@implementation CTLoadingView

- (instancetype)init
{
    self = [super init];
    
    [self setHeightConstraint:@100 priority:@1000];
    
    self.backgroundColor = [UIColor blueColor];
    
    return self;
}

@end
