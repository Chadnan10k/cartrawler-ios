//
//  CTTabView.m
//  CartrawlerSDK
//
//  Created by Alan on 22/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTTabView.h"

@interface CTTabView ()
@property (nonatomic, strong) UIView *lineView;
@end

@implementation CTTabView

- (instancetype)init {
    self = [super init];
    if (self) {
        _titleLabel = [UILabel new];
        
        self.selectedTextColor = [UIColor colorWithRed:42.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
        self.deselectedTextColor = [UIColor blackColor];
        self.selectedLineColor = self.selectedTextColor;
        self.deselectedLineColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:18.0];
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.minimumFontSize = 10;

        [self addSubview:self.titleLabel];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"titleLabel" : self.titleLabel}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"titleLabel" : self.titleLabel}]];
        
        self.lineView = [UIView new];
        self.lineView.translatesAutoresizingMaskIntoConstraints = NO;
        self.lineView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
        
        [self addSubview:self.lineView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[lineView]-2-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"lineView" : self.lineView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lineView(4)]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"lineView" : self.lineView}]];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    CGFloat fontSize = self.titleLabel.font.pointSize;
    self.titleLabel.font = selected ? [UIFont boldSystemFontOfSize:fontSize] : [UIFont systemFontOfSize:fontSize];
    self.titleLabel.textColor = selected ? self.selectedTextColor : self.deselectedTextColor;
    self.lineView.backgroundColor = selected ? self.selectedLineColor : self.deselectedLineColor;
}

@end
