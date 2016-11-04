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




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.layer.masksToBounds = NO;
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    self.layer.cornerRadius = 4.0;
    
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;

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
