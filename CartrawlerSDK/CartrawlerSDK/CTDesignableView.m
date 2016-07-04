//
//  CTDesignableView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTDesignableView.h"

@implementation CTDesignableView

+ (void)forceLinkerLoad_
{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    _borderColor = [UIColor groupTableViewBackgroundColor];
    _cornerRadius = 5;
    _borderWidth = 1;
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    return self;
}

- (void)awakeFromNib
{
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    self.layer.cornerRadius = self.cornerRadius;
}

@end
