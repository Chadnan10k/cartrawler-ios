//
//  CTTableView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 02/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTFilterTableView.h"
#import "CTFilterTableViewCell.h"

@implementation CTFilterTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self registerClass:[CTFilterTableViewCell self] forCellReuseIdentifier:@"cell"];
    
    self.scrollEnabled = NO;
    
//    self.layer.cornerRadius = 5;
//    self.layer.masksToBounds = YES;
    
    return self;
}

@end
