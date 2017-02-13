//
//  CTToolTipButton.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTToolTipButton.h"
#import "CTLabel.h"
#import "CTAppearance.h"
#import "CartrawlerSDK+UIImageView.h"
#import "CartrawlerSDK+UIView.h"

@interface CTToolTipButton()

@property (nonatomic, strong) CTLabel *textLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) CTToolTipButtonTapped didTap;
@end

@implementation CTToolTipButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:244.0f/255.0f alpha:1];
    self.layer.cornerRadius = [CTAppearance instance].buttonCornerRadius;
    _textLabel = [CTLabel new];
    self.textLabel.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:21];
    self.textLabel.numberOfLines = 0;
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.textLabel.textColor = [CTAppearance instance].iconTint;
    
    self.textLabel.text = @"Sample text";
    [self addSubview:self.textLabel];
    
    _imageView = [UIImageView new];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.imageView];
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    UIImage* image =[UIImage imageNamed:@"information" inBundle:bundle compatibleWithTraitCollection:nil];
    self.imageView.image = image;
    [self.imageView applyTint];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(22)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.imageView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(22)]-16-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.imageView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-32-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.textLabel}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.textLabel}]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0.0f]];
    
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel
//                                                     attribute:NSLayoutAttributeCenterY
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:self
//                                                     attribute:NSLayoutAttributeCenterY
//                                                    multiplier:1.0f
//                                                      constant:0.0f]];
//    
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel
//                                                     attribute:NSLayoutAttributeCenterX
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:self
//                                                     attribute:NSLayoutAttributeCenterX
//                                                    multiplier:1.0f
//                                                      constant:0.0f]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(showToolTip)];
    [self addGestureRecognizer:tap];
}

- (void)setText:(NSString *)text didTap:(CTToolTipButtonTapped)didTap;
{
    self.textLabel.text = text;
    _didTap = didTap;
}

- (void)showToolTip
{
    self.didTap();
}

@end
