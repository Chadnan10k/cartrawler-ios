//
//  CTSegmentedControl.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 27/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSegmentedControl.h"
#import "CTAppearance.h"

@implementation CTSegmentedControl

+ (void)forceLinkerLoad_
{
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIFont *font = [UIFont fontWithName:[CTAppearance instance].fontName size:12];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    [self setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
}


@end
