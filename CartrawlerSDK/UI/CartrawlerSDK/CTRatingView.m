//
//  CTRatingView.m
//  CartrawlerSDK
//
//  Created by Alan on 24/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTRatingView.h"
#import "CTAppearance.h"

@implementation CTRatingView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleLabel = [CTLabel new];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.titleLabel];
        
        UIView *containerView = [UIView new];
        containerView.translatesAutoresizingMaskIntoConstraints = NO;
        containerView.layer.cornerRadius = [CTAppearance instance].buttonCornerRadius;
        containerView.backgroundColor = [CTAppearance instance].supplierDetailSecondaryColor;
        [self addSubview:containerView];
        
        self.ratingLabel = [CTLabel new];
        self.ratingLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.ratingLabel.textColor = [UIColor whiteColor];
        [containerView addSubview:self.ratingLabel];
        
        NSDictionary *viewDictionary = @{@"titleLabel" : self.titleLabel, @"containerView" : containerView, @"ratingLabel" : self.ratingLabel};
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[titleLabel]-[containerView]-16-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewDictionary]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[ratingLabel]-10-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewDictionary]];
        [self.ratingLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.ratingLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewDictionary]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[containerView]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewDictionary]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[ratingLabel]-10-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewDictionary]];
    }
    return self;
}

@end
