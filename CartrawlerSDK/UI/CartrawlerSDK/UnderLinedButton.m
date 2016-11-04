//
//  UnderLinedButton.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 05/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "UnderLinedButton.h"
#import "CTAppearance.h"

@implementation UnderLinedButton

{}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    self.titleLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:self.titleLabel.font.pointSize];

    
    NSDictionary *attrDict = @{NSFontAttributeName :
                                   [UIFont fontWithName:[CTAppearance instance].fontName size:self.titleLabel.font.pointSize]};
    
    NSMutableAttributedString *title =[[NSMutableAttributedString alloc]
                                       initWithString:self.titleLabel.text attributes: attrDict];
    
    [title addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle)
                  range:NSMakeRange(0,(self.titleLabel.text).length)];
    
    [self setAttributedTitle:title forState:UIControlStateNormal];
    
    self.titleLabel.minimumScaleFactor = 0.5f;
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    return self;
}

@end
