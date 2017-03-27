//
//  CTListItemView.m
//  CartrawlerSDK
//
//  Created by Alan on 13/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTListItemView.h"

@interface CTListItemView ()
@property (nonatomic, strong) NSArray *horizontalConstraints;
@end

@implementation CTListItemView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleLabel = [CTLabel new];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self addSubview:self.titleLabel];
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        
        self.imageAlignment = CTListItemImageAlignmentLeft;
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"titleLabel": self.titleLabel}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[imageView(24)]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"imageView": self.imageView}]];
    }
    return self;
}

- (void)setImageAlignment:(CTListItemImageAlignment)imageAlignment {
    _imageAlignment = imageAlignment;
    
    [self removeConstraints:self.horizontalConstraints];
    
    NSString *visualFormat = imageAlignment == CTListItemImageAlignmentRight ? @"H:|[titleLabel]-16-[imageView(40)]|" : @"H:|[imageView(40)]-16-[titleLabel]|";
    self.horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                         options:0
                                                                         metrics:nil
                                                                           views:@{@"titleLabel" : self.titleLabel, @"imageView" : self.imageView}];
    [self addConstraints:self.horizontalConstraints];
}



@end
