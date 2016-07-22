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
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.barTintColor = [CTAppearance instance].navigationBarTint;
    self.translucent = NO;
    return self;
}

- (id)init
{
    self = [super init];
    
    return self;
}

+ (void)forceLinkerLoad_
{
    
}

@end
