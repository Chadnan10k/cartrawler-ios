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




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self.useBoldFont) {
        self.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:self.font.pointSize];
    } else {
        self.font = [UIFont fontWithName:[CTAppearance instance].fontName size:self.font.pointSize];
    }
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
        self.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:self.font.pointSize];
    } else {
        self.font = [UIFont fontWithName:[CTAppearance instance].fontName size:self.font.pointSize];
    }
}

@end
