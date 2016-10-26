//
//  CTToolTip.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTToolTip.h"
#import "CTLabel.h"

@interface CTToolTip()

@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation CTToolTip

+ (void)forceLinkerLoad_ { }

- (void)presentForView:(UIView *)anchorView text:(NSString *)text
{
//    self.frame = anchorView.superview.frame;
//    _backgroundView = [[UIView alloc] initWithFrame:anchorView.superview.frame];
//    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.4];
//    [self addSubview:self.backgroundView];
//    [anchorView.superview addSubview:self];
//    
//    //create the tool tip box
//    UIView *tipBox = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    tipBox.backgroundColor = [UIColor whiteColor];
//    
//    CTLabel *tipLabel = [[CTLabel alloc] initWithFrame:CGRectZero];
//    tipLabel.text = text;
//    tipLabel.backgroundColor = [UIColor redColor];
//    
//    tipBox.translatesAutoresizingMaskIntoConstraints = NO;
//    tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    self.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addSubview:tipBox];
//    
//    //[tipBox addSubview:tipLabel];
//
//    
////    CGRect labelRect = [text
////                        boundingRectWithSize:tipBox.frame.size
////                        options:NSStringDrawingUsesLineFragmentOrigin
////                        attributes:@{
////                                     NSFontAttributeName : [UIFont systemFontOfSize:14]
////                                     }
////                        context:nil];
//    
//    //create constraints
//    
//    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tipBox(400)]|" options:0 metrics:nil views:@{ @"view" : self, @"tipBox" : tipBox }]];
//    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tipBox(400)]|" options:0 metrics:nil views:@{ @"view" : self, @"tipBox" : tipBox }]];
    
}

@end
