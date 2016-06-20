//
//  CTNavigationBar.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 20/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTNavigationBar.h"
#import "CTAppearance.h"

@implementation CTNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    NSLog(@"33");

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    self.barTintColor = [CTAppearance instance].navigationBarTint;
    
    self.translucent = NO;
    NSLog(@"ee");

    return self;
}

- (id)init
{
    self = [super init];
    
    NSLog(@"dd");
    
    return self;
}

+ (void)forceLinkerLoad_
{
    
}

@end
