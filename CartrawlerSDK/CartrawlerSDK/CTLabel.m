//
//  CTLabel.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 08/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTLabel.h"
#import "CTAppearance.h"

@implementation CTLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)forceLinkerLoad_
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    //set font from theme file here
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    [self setFont:[UIFont fontWithName:[CTAppearance instance].fontName size:self.font.pointSize]];

    return self;
}

@end
