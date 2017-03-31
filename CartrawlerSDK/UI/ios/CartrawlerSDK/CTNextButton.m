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

@end

@implementation CTNextButton

- (void)setText:(NSString *)text
{
    self.backgroundColor = [CTAppearance instance].buttonTextColor;
    CTButton *button = [CTButton new];
    button.titleLabel.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:21];
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

- (instancetype)init
{
    self = [super init];
    
    return self;
}

- (void)tapped
{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareForInterfaceBuilder
{
    [self setText:@"Sample"];
}

@end
