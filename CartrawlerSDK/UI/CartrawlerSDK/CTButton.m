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

- (id)init
{
    self = [super init];
    _overrideBackgroundColor = [CTAppearance instance].buttonColor;
    _overrideTextColor = [CTAppearance instance].buttonTextColor;
    
    self.backgroundColor = [CTAppearance instance].buttonColor;
    [self setTitleColor:[CTAppearance instance].buttonTextColor forState:UIControlStateNormal];
    
    self.titleLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:self.titleLabel.font.pointSize];
    
    self.layer.cornerRadius = [CTAppearance instance].buttonCornerRadius;
    self.layer.masksToBounds = YES;
    
    self.titleLabel.minimumScaleFactor = 0.5f;
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    _overrideBackgroundColor = [CTAppearance instance].buttonColor;
    _overrideTextColor = [CTAppearance instance].buttonTextColor;
    _overrideCornerRadius = [CTAppearance instance].buttonCornerRadius;
    
    _disableShadow = NO;
    self.backgroundColor = [CTAppearance instance].buttonColor;
    [self setTitleColor:[CTAppearance instance].buttonTextColor forState:UIControlStateNormal];
    
    self.titleLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:self.titleLabel.font.pointSize];
    
    self.layer.cornerRadius = [CTAppearance instance].buttonCornerRadius;
    self.layer.masksToBounds = YES;
    
    self.titleLabel.minimumScaleFactor = 0.5f;
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = self.overrideBackgroundColor;
    [self setTitleColor:self.overrideTextColor forState:UIControlStateNormal];
    self.layer.cornerRadius = self.overrideCornerRadius;
    
    self.titleLabel.minimumScaleFactor = 0.5f;
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    /*
    if (!self.disableShadow) {
        if ([CTAppearance instance].enableShadows) {
            self.layer.masksToBounds = NO;
            self.layer.shadowColor = [UIColor blackColor].CGColor;
            self.layer.shadowOffset = CGSizeMake(0, 3);
            self.layer.shadowOpacity = 0.2;
            self.layer.shadowRadius = 3;
        }
    }
     */
    
    if (self.useBoldFont) {
        self.titleLabel.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:self.titleLabel.font.pointSize];
    } else {
        self.titleLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:self.titleLabel.font.pointSize];
    }
    
    if (self.transparent) {
        self.layer.borderColor = [CTAppearance instance].iconTint.CGColor;
        [self setTitleColor:[CTAppearance instance].iconTint forState:UIControlStateNormal];
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderWidth = 0.5;
    }
}

- (void)shake
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0.5 options:0 animations:^{
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

@end
