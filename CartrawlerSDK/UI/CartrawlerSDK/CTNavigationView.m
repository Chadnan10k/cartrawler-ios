//
//  CTNavigationView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 27/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTNavigationView.h"
#import "CTAppearance.h"

@implementation CTNavigationView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.backgroundColor = [CTAppearance instance].navigationBarColor;
    return self;
}

@end
