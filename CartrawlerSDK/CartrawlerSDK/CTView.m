//
//  CTView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 20/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTView.h"
#import "CTAppearance.h"

@implementation CTView

+ (void)forceLinkerLoad_
{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    self.backgroundColor = [CTAppearance instance].viewBackgroundColor;
    
    return self;
}

@end
