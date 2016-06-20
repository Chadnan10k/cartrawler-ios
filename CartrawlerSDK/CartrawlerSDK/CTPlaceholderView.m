//
//  CTPlaceholderView.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPlaceholderView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CTPlaceholderView

+ (void)forceLinkerLoad_
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor darkGrayColor]);
    self.layer.masksToBounds = NO;
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    self.layer.cornerRadius = 4.0;
    
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor darkGrayColor]);

    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
