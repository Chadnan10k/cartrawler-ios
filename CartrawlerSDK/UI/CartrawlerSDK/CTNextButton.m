//
//  CTNextButton.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTNextButton.h"
#import "CTButton.h"
#import "CTAppearance.h"

@interface CTNextButton()

@property (nonatomic) CTToolTipButtonTapped didTap;

@end

@implementation CTNextButton

- (void)setText:(NSString *)text didTap:(CTToolTipButtonTapped)didTap
{
    _didTap = didTap;
    self.backgroundColor = [CTAppearance instance].buttonTextColor;
    CTButton *button = [CTButton new];
    button.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:21];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:button];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[view]-16-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : button}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[view]-16-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : button}]];
}

- (void)tapped
{
    self.didTap();
}

@end
