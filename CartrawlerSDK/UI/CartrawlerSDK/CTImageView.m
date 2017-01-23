//
//  CTImageView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 14/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTImageView.h"
#import "CartrawlerSDK+UIImageView.h"

@implementation CTImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
  
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self applyTint];
}

@end
