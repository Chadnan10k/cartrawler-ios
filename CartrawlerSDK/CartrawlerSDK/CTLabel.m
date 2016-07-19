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
    
    _useBoldFont = NO;

    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    if (self.useBoldFont) {
        [self setFont:[UIFont fontWithName:[CTAppearance instance].boldFontName size:self.font.pointSize]];
    } else {
        [self setFont:[UIFont fontWithName:[CTAppearance instance].fontName size:self.font.pointSize]];
    }
}

@end
