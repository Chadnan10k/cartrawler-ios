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
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self addSubview:_titleLabel];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        [self setImageAlignment:CTListItemImageAlignmentLeft];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_titleLabel)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_imageView(24)]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_imageView)]];
    }
    return self;
}

- (void)setImageAlignment:(CTListItemImageAlignment *)imageAlignment {
    _imageAlignment = imageAlignment;
    
    [self removeConstraints:self.horizontalConstraints];
    
    NSString *visualFormat = imageAlignment == CTListItemImageAlignmentLeft ? @"H:|[titleLabel]-10-[imageView(24)]|" : @"H:|[imageView(24)]-10-[titleLabel]|";
    self.horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                         options:0
                                                                         metrics:nil
                                                                           views:@{@"titleLabel" : self.titleLabel, @"imageView" : self.imageView}];
    [self addConstraints:self.horizontalConstraints];
}



@end
