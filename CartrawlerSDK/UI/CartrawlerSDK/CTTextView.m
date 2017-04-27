//
//  CTTextView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 25/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTTextView.h"
#import "CTAppearance.h"

@implementation CTTextView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.font = [UIFont fontWithName:[CTAppearance instance].fontName size:14];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.font = [UIFont fontWithName:[CTAppearance instance].fontName size:14];

    return self;
}

@end
