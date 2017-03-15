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

- (instancetype)init:(CGFloat)textSize
           textColor:(UIColor *)textColor
       textAlignment:(NSTextAlignment)textAlignment
            boldFont:(BOOL)boldFont
{
    self = [super init];
    
    self.font = [UIFont fontWithName:(boldFont ? [CTAppearance instance].boldFontName : [CTAppearance instance].fontName) size:textSize];
    if (textAlignment) {
        self.textAlignment = textAlignment;
    }
    self.textColor = textColor;
    
    return self;
}

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
    
    if (self.isHeaderTitle) {
        self.textColor = [CTAppearance instance].headerTitleColor;
    }
    
    if (self.isSubheaderTitle) {
        self.textColor = [CTAppearance instance].subheaderTitleColor;
    }
}

@end
