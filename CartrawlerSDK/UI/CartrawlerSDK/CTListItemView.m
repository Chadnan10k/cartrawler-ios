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
        self.titleLabel = [[CTLabel alloc] init:14 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft boldFont:NO];
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
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[imageView]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"imageView": self.imageView}]];
    }
    return self;
}

- (void)setImageAlignment:(CTListItemImageAlignment)imageAlignment {
    _imageAlignment = imageAlignment;
    
    [self removeConstraints:self.horizontalConstraints];
    
    NSString *visualFormat = imageAlignment == CTListItemImageAlignmentRight ? @"H:|-0-[titleLabel]-8-[imageView(20)]-8-|" : @"H:|-8-[imageView(20)]-8-[titleLabel]-4-|";
    self.horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                         options:0
                                                                         metrics:nil
                                                                           views:@{@"titleLabel" : self.titleLabel, @"imageView" : self.imageView}];
    [self addConstraints:self.horizontalConstraints];
}



@end
