//
//  CTToastView.m
//  CartrawlerSDK
//
//  Created by Alan on 18/05/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTToastView.h"

@implementation CTToastView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:231.0/255.0 green:244.0/255.0 blue:253.0/255.0 alpha:1.0];
        [self createViews];
        [self createConstraints];
    }
    return self;
}

- (void)createViews {
    self.topBorder = [UIView new];
    self.topBorder.translatesAutoresizingMaskIntoConstraints = NO;
    self.topBorder.backgroundColor = [UIColor colorWithRed:72.0/255.0 green:162.0/255.0 blue:234.0/255.0 alpha:1.0];
    [self addSubview:self.topBorder];
    
    UIColor *textColor = [UIColor colorWithRed:38.0/255.0 green:144.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.titleLabel = [[CTLabel alloc] init:16 textColor:textColor textAlignment:NSTextAlignmentLeft boldFont:YES];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.titleLabel];
}

- (void)createConstraints {
    NSDictionary *views = @{ @"topBorder": self.topBorder, @"titleLabel": self.titleLabel };
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[topBorder]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[titleLabel]-15-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topBorder(2)]-[titleLabel]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
}



@end
