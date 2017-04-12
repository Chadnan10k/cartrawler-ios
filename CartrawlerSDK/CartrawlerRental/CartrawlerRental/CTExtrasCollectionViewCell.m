//
//  CTExtrasCollectionViewCell.m
//  CartrawlerSDK
//
//  Created by Alan on 10/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTExtrasCollectionViewCell.h"

@interface CTExtrasCollectionViewCell ()
@property (nonatomic, strong) UIView *leftBackgroundView;
@property (nonatomic, strong) UIView *separator;
@property (nonatomic, strong) UIView *rightBackgroundView;

@property (nonatomic, strong) UIButton *infoButton;

@property (nonatomic, strong) UIView *detailsView;
@property (nonatomic, strong) UIButton *decrementButton;
@property (nonatomic, strong) UIButton *incrementButton;

@end

@implementation CTExtrasCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self addConstraints];
        [self addCornerRadius];
        [self addCommands];
    }
    return self;
}

- (void)addViews {
    self.leftBackgroundView = [UIView new];
    self.leftBackgroundView.backgroundColor = [UIColor colorWithRed:233.0/255.0 green:244.0/255.0 blue:253.0/255.0 alpha:1.0];
    self.leftBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.leftBackgroundView];
    
    self.separator = [UIView new];
    self.separator.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.separator.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.separator];
    
    self.rightBackgroundView = [UIView new];
    self.rightBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.rightBackgroundView];
    
    self.infoButton = [UIButton new];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIImage *infoImage = [[UIImage imageNamed:@"information" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.infoButton.tintColor = [UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
    [self.infoButton setImage:infoImage forState:UIControlStateNormal];
    self.infoButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.infoButton];
    
    self.leftImageView = [UIImageView new];
    self.leftImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.leftBackgroundView addSubview:self.leftImageView];
    
    UIColor *textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    self.titleLabel = [[CTLabel alloc] init:17 textColor:textColor textAlignment:NSTextAlignmentCenter boldFont:NO];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightBackgroundView addSubview:self.titleLabel];
    
    self.detailLabel = [[CTLabel alloc] init:12 textColor:textColor textAlignment:NSTextAlignmentCenter boldFont:NO];
    self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightBackgroundView addSubview:self.detailLabel];
    
    self.decrementButton = [UIButton new];
    UIImage *decrementImage = [[UIImage imageNamed:@"minus" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.decrementButton setImage:decrementImage forState:UIControlStateNormal];
    self.decrementButton.tintColor = [UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.decrementButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightBackgroundView addSubview:self.decrementButton];
    
    self.countLabel = [CTLabel new];
    self.countLabel.text = @"0";
    self.countLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightBackgroundView addSubview:self.countLabel];
    
    self.incrementButton = [UIButton new];
    UIImage *incrementImage = [[UIImage imageNamed:@"plus" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.incrementButton setImage:incrementImage forState:UIControlStateNormal];
    self.incrementButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightBackgroundView addSubview:self.incrementButton];
    
    self.closeButton = [UIButton new];
    UIImage *closeImage = [[UIImage imageNamed:@"information" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.closeButton setImage:closeImage forState:UIControlStateNormal];
    self.closeButton.tintColor = [UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.closeButton.hidden = YES;
    [self.contentView addSubview:self.closeButton];
    
    self.infoTitleLabel = [[CTLabel alloc] init:17 textColor:textColor textAlignment:NSTextAlignmentCenter boldFont:NO];
    self.infoTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.infoTitleLabel.hidden = YES;
    [self.contentView addSubview:self.infoTitleLabel];
    
    self.infoDetailLabel = [[CTLabel alloc] init:12 textColor:textColor textAlignment:NSTextAlignmentCenter boldFont:NO];
    self.infoDetailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.infoDetailLabel.hidden = YES;
    [self.contentView addSubview:self.infoDetailLabel];
}

- (void)addConstraints {
    NSDictionary *views = @{@"leftBackgroundView": self.leftBackgroundView, @"separator": self.separator, @"rightBackgroundView" : self.rightBackgroundView, @"infoButton" : self.infoButton, @"leftImageView" : self.leftImageView, @"closeButton" : self.closeButton};
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[leftBackgroundView(66)][separator(1)][rightBackgroundView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[leftBackgroundView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[separator]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rightBackgroundView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[infoButton(20)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[infoButton(20)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.leftBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.leftBackgroundView
                                                                       attribute:NSLayoutAttributeCenterX
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.leftImageView
                                                                       attribute:NSLayoutAttributeCenterX
                                                                      multiplier:1.0
                                                                         constant:0]];
    [self.leftBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.leftBackgroundView
                                                                        attribute:NSLayoutAttributeCenterY
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.leftImageView
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1.0
                                                                         constant:-5]];
    [self.leftBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[leftImageView(40)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.leftBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[leftImageView(40)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBackgroundView
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.titleLabel
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1.0
                                                                         constant:0]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBackgroundView
                                                                        attribute:NSLayoutAttributeCenterY
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.titleLabel
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1.0
                                                                         constant:30]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBackgroundView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.detailLabel
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBackgroundView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.detailLabel
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:12]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBackgroundView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.decrementButton
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:30]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBackgroundView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.decrementButton
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:-23]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.decrementButton
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:28]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.decrementButton
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:28]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.incrementButton
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:28]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.incrementButton
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:28]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBackgroundView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.incrementButton
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:-30]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBackgroundView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.incrementButton
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:-23]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBackgroundView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.countLabel
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBackgroundView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.countLabel
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:-23]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[closeButton(20)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[closeButton(20)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.infoTitleLabel
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.infoTitleLabel
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:30]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.infoDetailLabel
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1.0
                                                                  constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.infoDetailLabel
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:0]];

}

- (void)addCornerRadius {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 5.0f;
    self.contentView.clipsToBounds = YES;
}

- (void)addCommands {
    [self.infoButton addTarget:self action:@selector(didTapInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.decrementButton addTarget:self action:@selector(didTapDecrement:) forControlEvents:UIControlEventTouchUpInside];
    [self.incrementButton addTarget:self action:@selector(didTapIncrement:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton addTarget:self action:@selector(didTapClose:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setFlippedState:(BOOL)flipped animated:(BOOL)animated {
    [UIView transitionWithView:self.contentView
                      duration:animated ? 0.4 : 0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        for (UIView *view in @[self.leftBackgroundView, self.separator, self.rightBackgroundView]) {
                            view.hidden = flipped;
                        }
                        for (UIView *view in @[self.closeButton, self.infoTitleLabel, self.infoDetailLabel]) {
                            view.hidden = !flipped;
                        }
                    } completion:nil];
}

- (void)setIncrementEnabled:(BOOL)incrementEnabled {
    [self setEnabled:incrementEnabled button:self.incrementButton];
}

- (void)setDecrementEnabled:(BOOL)decrementEnabled {
    [self setEnabled:decrementEnabled button:self.decrementButton];
}

- (void)setEnabled:(BOOL)enabled button:(UIButton *)button {
    button.enabled = enabled;
    button.tintColor = enabled ? [UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0] : [UIColor colorWithRed:227.0/255.0 green:238.0/255.0 blue:247.0/255.0 alpha:1.0];
}

- (void)didTapInfo:(UIButton *)button {
    [self.delegate cellDidTapInfo:self];
}

- (void)didTapDecrement:(UIButton *)button {
    [self.delegate cellDidTapDecrement:self];
}

- (void)didTapIncrement:(UIButton *)button {
    [self.delegate cellDidTapIncrement:self];
}

- (void)didTapClose:(UIButton *)button {
    [self.delegate cellDidTapClose:self];
}

@end
