//
//  CTLogoImageView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTLogoImageView.h"
#import "CTAppearance.h"

@implementation CTLogoImageView

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
    if ([CTAppearance instance].navigationBarLogoImage) {
        self.image = [CTAppearance instance].navigationBarLogoImage;
    }
}

@end
