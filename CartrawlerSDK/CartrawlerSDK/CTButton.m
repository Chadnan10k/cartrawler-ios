//
//  CTButton.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 07/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTButton.h"
#import "CTAppearance.h"

@implementation CTButton

+ (void)forceLinkerLoad_
{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    _overrideBackgroundColor = [CTAppearance instance].buttonColor;
    _overrideTextColor = [CTAppearance instance].buttonTextColor;
    
    self.backgroundColor = [CTAppearance instance].buttonColor;
    [self setTitleColor:[CTAppearance instance].buttonTextColor forState:UIControlStateNormal];
    
    self.titleLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:self.titleLabel.font.pointSize];
    
    self.layer.cornerRadius = [CTAppearance instance].buttonCornerRadius;
    self.layer.masksToBounds = YES;
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = self.overrideBackgroundColor;
    [self setTitleColor:self.overrideTextColor forState:UIControlStateNormal];
}

@end
