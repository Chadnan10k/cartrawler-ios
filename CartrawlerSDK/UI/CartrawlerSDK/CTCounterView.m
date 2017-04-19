//
//  CTCounterView.m
//  CartrawlerSDK
//
//  Created by Alan on 13/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTCounterView.h"
#import <CartrawlerSDK/CTLabel.h>

@interface CTCounterView ()
@property (nonatomic, strong) UIButton *decrementButton;
@property (nonatomic, strong) UIButton *incrementButton;
@end

@implementation CTCounterView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addViews];
        [self addConstraints];
        [self addCommands];
    }
    return self;
}

- (void)addViews {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    self.decrementButton = [UIButton new];
    UIImage *decrementImage = [[UIImage imageNamed:@"minus" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.decrementButton setImage:decrementImage forState:UIControlStateNormal];
    [self.decrementButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentFill];
    [self.decrementButton setContentVerticalAlignment:UIControlContentVerticalAlignmentFill];
    self.decrementButton.tintColor = [UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.decrementButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.decrementButton];
    
    self.countLabel = [CTLabel new];
    self.countLabel.text = @"0";
    self.countLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.countLabel];
    
    self.incrementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *incrementImage = [[UIImage imageNamed:@"plus" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.incrementButton setImage:incrementImage forState:UIControlStateNormal];
    [self.incrementButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentFill];
    [self.incrementButton setContentVerticalAlignment:UIControlContentVerticalAlignmentFill];
    self.incrementButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.incrementButton];
}

- (void)addConstraints {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.decrementButton
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.countLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.incrementButton
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.decrementButton
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.countLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.incrementButton
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.decrementButton
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.9
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.incrementButton
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.9
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.decrementButton
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.decrementButton
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.incrementButton
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.incrementButton
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0
                                                      constant:0]];
}

- (void)addCommands {
    [self.decrementButton addTarget:self action:@selector(didTapDecrement:) forControlEvents:UIControlEventTouchUpInside];
    [self.incrementButton addTarget:self action:@selector(didTapIncrement:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didTapIncrement:(UIButton *)button {
    [self.delegate counterViewDidTapIncrement:self];
}

- (void)didTapDecrement:(UIButton *)button {
    [self.delegate counterViewDidTapDecrement:self];
}

- (void)setIncrementEnabled:(BOOL)incrementEnabled {
    [self setEnabled:incrementEnabled button:self.incrementButton];
}

- (void)setDecrementEnabled:(BOOL)decrementEnabled {
    [self setEnabled:decrementEnabled button:self.decrementButton];
}

- (void)setEnabled:(BOOL)enabled button:(UIButton *)button {
    button.tintColor = enabled ? [UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0] : [UIColor colorWithRed:207.0/255.0 green:207.0/255.0 blue:207.0/255.0 alpha:1.0];
}

@end
