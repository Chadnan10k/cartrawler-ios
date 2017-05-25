//
//  CTInfoTip.m
//  CartrawlerSDK
//
//  Created by Alan on 07/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTInfoTip.h"

NSString * const kInfoTipInformationImage = @"information";

@interface CTInfoTip ()
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *infoButton;
@end

@implementation CTInfoTip

- (instancetype)initWithIcon:(UIImage *)icon text:(NSString *)text {
    self = [super init];
    if (self) {
        [self setupViewsWithIcon:icon text:text];
    }
    return self;
}

- (void)setupViewsWithIcon:(UIImage *)icon text:(NSString *)text {
    UIView *backgroundView = [self createBackgroundView];
    self.infoLabel = [self createLabelWithText:text];
    self.infoButton = [self createButton];
    UIView *alignmentView = [self createAlignmentView];
    self.circleView = [self createCircleView];
    self.imageView = [self createImageViewWithIcon:icon];
    
    [self addSubview:backgroundView];
    [self addSubview:self.infoLabel];
    [self addSubview:self.infoButton];
    [self addSubview:alignmentView];
    [self addSubview:self.circleView];
    [self.circleView addSubview:self.imageView];
    
    [self.infoButton addTarget:self action:@selector(didTapInfoButton:) forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *circleViewLeftConstraint = [NSLayoutConstraint constraintWithItem:self.circleView
                                                                                attribute:NSLayoutAttributeLeft
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeLeft
                                                                               multiplier:1.0
                                                                                 constant:0];
    
    NSLayoutConstraint *circleViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.circleView
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1.0
                                                                                constant:0];
    NSLayoutConstraint *circleViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.circleView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1.0
                                                                                  constant:70];
    NSLayoutConstraint *circleViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.circleView
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.circleView
                                                                                  attribute:NSLayoutAttributeWidth
                                                                                 multiplier:1.0
                                                                                   constant:0];
    [self addConstraints:@[circleViewLeftConstraint, circleViewTopConstraint, circleViewWidthConstraint, circleViewHeightConstraint]];
    
    NSLayoutConstraint *alignmentViewLeftConstraint = [NSLayoutConstraint constraintWithItem:alignmentView
                                                                                   attribute:NSLayoutAttributeLeft
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.circleView
                                                                                   attribute:NSLayoutAttributeLeft
                                                                                  multiplier:1.0
                                                                                    constant:0];
    NSLayoutConstraint *alignmentViewTopConstraint = [NSLayoutConstraint constraintWithItem:alignmentView
                                                                                  attribute:NSLayoutAttributeTop
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.circleView
                                                                                  attribute:NSLayoutAttributeTop
                                                                                 multiplier:1.0
                                                                                   constant:0];
    NSLayoutConstraint *alignmentViewBottomConstraint = [NSLayoutConstraint constraintWithItem:alignmentView
                                                                                     attribute:NSLayoutAttributeBottom
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self.circleView
                                                                                     attribute:NSLayoutAttributeBottom
                                                                                    multiplier:1.0
                                                                                      constant:0];
    NSLayoutConstraint *alignmentViewWidthConstraint = [NSLayoutConstraint constraintWithItem:alignmentView
                                                                                    attribute:NSLayoutAttributeWidth
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.circleView
                                                                                    attribute:NSLayoutAttributeWidth
                                                                                   multiplier:0.5
                                                                                     constant:0];
    [self addConstraints:@[alignmentViewLeftConstraint, alignmentViewTopConstraint, alignmentViewBottomConstraint, alignmentViewWidthConstraint]];
    
    NSLayoutConstraint *backgroundViewLeftConstraint = [NSLayoutConstraint constraintWithItem:backgroundView
                                                                                    attribute:NSLayoutAttributeLeft
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:alignmentView
                                                                                    attribute:NSLayoutAttributeRight
                                                                                   multiplier:1.0
                                                                                     constant:0];
    NSLayoutConstraint *backgroundViewRightConstraint = [NSLayoutConstraint constraintWithItem:backgroundView
                                                                                     attribute:NSLayoutAttributeRight
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self
                                                                                     attribute:NSLayoutAttributeRight
                                                                                    multiplier:1.0
                                                                                      constant:0];
    NSLayoutConstraint *backgroundViewTopConstraint = [NSLayoutConstraint constraintWithItem:backgroundView
                                                                                   attribute:NSLayoutAttributeTop
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self
                                                                                   attribute:NSLayoutAttributeTop
                                                                                  multiplier:1.0
                                                                                    constant:5];
    NSLayoutConstraint *backgroundViewHeightConstraint = [NSLayoutConstraint constraintWithItem:backgroundView
                                                                                      attribute:NSLayoutAttributeHeight
                                                                                      relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                         toItem:nil
                                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                                     multiplier:1.0
                                                                                       constant:60];
    NSLayoutConstraint *backgroundViewBottomConstraint = [NSLayoutConstraint constraintWithItem:backgroundView
                                                                                      attribute:NSLayoutAttributeBottom
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:self
                                                                                      attribute:NSLayoutAttributeBottom
                                                                                     multiplier:1.0
                                                                                       constant:-5];
    backgroundViewBottomConstraint.priority = 750;
    [self addConstraints:@[backgroundViewLeftConstraint, backgroundViewRightConstraint, backgroundViewTopConstraint, backgroundViewHeightConstraint, backgroundViewBottomConstraint]];
    
    NSLayoutConstraint *labelLeftConstraint = [NSLayoutConstraint constraintWithItem:self.infoLabel
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.circleView
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1.0
                                                                            constant:10];
    NSLayoutConstraint *labelRightConstraint = [NSLayoutConstraint constraintWithItem:self.infoLabel
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.infoButton
                                                                            attribute:NSLayoutAttributeLeft
                                                                           multiplier:1.0
                                                                             constant:-10];
    NSLayoutConstraint *labelTopConstraint = [NSLayoutConstraint constraintWithItem:self.infoLabel
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1.0
                                                                           constant:12];
    NSLayoutConstraint *labelHeightConstraint = [NSLayoutConstraint constraintWithItem:self.infoLabel
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1.0
                                                                              constant:60];
    NSLayoutConstraint *labelBottomConstraint = [NSLayoutConstraint constraintWithItem:self.infoLabel
                                                                             attribute:NSLayoutAttributeBottom
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:-12];
    labelBottomConstraint.priority = 750;
    [self addConstraints:@[labelLeftConstraint, labelRightConstraint, labelTopConstraint, labelHeightConstraint, labelBottomConstraint]];
    
    NSLayoutConstraint *buttonRightConstraint = [NSLayoutConstraint constraintWithItem:self.infoButton
                                                                             attribute:NSLayoutAttributeRight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1.0
                                                                              constant:-10];
    NSLayoutConstraint *buttonYConstraint = [NSLayoutConstraint constraintWithItem:self.infoButton
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:0];
    NSLayoutConstraint *buttonWidthConstraint = [NSLayoutConstraint constraintWithItem:self.infoButton
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1.0
                                                                              constant:24.0];
    NSLayoutConstraint *buttonHeightConstraint = [NSLayoutConstraint constraintWithItem:self.infoButton
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1.0
                                                                               constant:24.0];
    [self addConstraints:@[buttonRightConstraint, buttonYConstraint, buttonWidthConstraint, buttonHeightConstraint]];
    
    NSLayoutConstraint *imageXConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.circleView
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1.0
                                                                         constant:0];
    NSLayoutConstraint *imageYConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                        attribute:NSLayoutAttributeCenterY
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.circleView
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1.0
                                                                         constant:0];
    NSLayoutConstraint *imageWidthConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                            attribute:NSLayoutAttributeWidth
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.circleView
                                                                            attribute:NSLayoutAttributeWidth
                                                                           multiplier:1.0
                                                                             constant:0];
    NSLayoutConstraint *imageHeightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.circleView
                                                                             attribute:NSLayoutAttributeHeight
                                                                            multiplier:1.0
                                                                              constant:0];
    [self addConstraints:@[imageXConstraint, imageYConstraint, imageWidthConstraint, imageHeightConstraint]];
}

// MARK: View Creation

- (UIView *)createBackgroundView {
    UIView *backgroundView = [UIView new];
    backgroundView.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
    backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    backgroundView.layer.cornerRadius = 5.0;
    return backgroundView;
}

- (UILabel *)createLabelWithText:(NSString *)text {
    UILabel *infoLabel = [UILabel new];
    infoLabel.numberOfLines = 0;
    infoLabel.text = text;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.font = [UIFont systemFontOfSize:15];
    infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [infoLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    return infoLabel;
}

- (UIButton *)createButton {
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    UIImage *image = [UIImage imageNamed:kInfoTipInformationImage inBundle:bundle compatibleWithTraitCollection:nil];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [infoButton setImage:image forState:UIControlStateNormal];
    [infoButton setTintColor:[UIColor whiteColor]];
    infoButton.translatesAutoresizingMaskIntoConstraints = NO;
    return infoButton;
}

- (UIView *)createAlignmentView {
    UIView *alignmentView = [UIView new];
    alignmentView.translatesAutoresizingMaskIntoConstraints = NO;
    return alignmentView;
}

- (UIView *)createCircleView {
    UIView *circleView = [UIView new];
    circleView.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:244.0/255.0 blue:253.0/255.0 alpha:1.0];
    circleView.layer.masksToBounds = YES;
    circleView.layer.borderColor = [UIColor colorWithRed:42.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0].CGColor;
    circleView.layer.borderWidth = 2.0;
    circleView.translatesAutoresizingMaskIntoConstraints = NO;
    return circleView;
}

- (UIImageView *)createImageViewWithIcon:(UIImage *)icon {
    UIImageView *imageView = [UIImageView new];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    imageView.image = icon ?: [UIImage imageNamed:@"car_tick" inBundle:bundle compatibleWithTraitCollection:nil];
    return imageView;
}

- (void)setText:(NSString *)text {
    self.infoLabel.text = text;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

// MARK: Button Action

- (void)didTapInfoButton:(UIButton *)button {
    if (self.delegate) {
        [self.delegate infoTipWasTapped:self];
    }
}

// MARK: Image Rounding

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutIfNeeded];
    self.circleView.layer.cornerRadius = self.circleView.frame.size.width / 2;
}

@end
