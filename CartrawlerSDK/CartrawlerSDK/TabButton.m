//
//  TabButton.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 05/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "TabButton.h"
#import "CTAppearance.h"

@implementation TabButton

+ (void)forceLinkerLoad_
{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, 43.0f, self.frame.size.width, 1.0f);
    
    bottomBorder.backgroundColor = [UIColor colorWithWhite:1.0f
                                                     alpha:1.0f].CGColor;
    (self.titleLabel).font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:self.titleLabel.font.pointSize];
    
    [self.layer addSublayer:bottomBorder];
    
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;

    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    return self;
}

- (void)focus:(BOOL)willFocus
{
    if (willFocus) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
}

@end
