//
//  CTExtrasCarouselViewCell.m
//  CartrawlerSDK
//
//  Created by Alan on 10/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTExtrasCarouselViewCell.h"
#import <CartrawlerSDK/CTCounterView.h>
#import <CartrawlerSDK/CTAnalytics.h>

@interface CTExtrasCarouselViewCell () <CTCounterViewDelegate>

@property (nonatomic, strong) UIButton *infoButton;

@property (nonatomic, strong) UIView *leftBackgroundView;
@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UIView *separator;

@property (nonatomic, strong) UIView *rightBackgroundView;
@property (nonatomic, strong) CTLabel *titleLabel;
@property (nonatomic, strong) CTLabel *detailLabel;
@property (nonatomic, strong) CTCounterView *counter;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) CTLabel *infoTitleLabel;
@property (nonatomic, strong) CTLabel *infoDetailLabel;
@end

@implementation CTExtrasCarouselViewCell
@synthesize delegate = _delegate;

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
    self.leftImageView.tintColor = [UIColor colorWithRed:202.0/255.0 green:226.0/255.0 blue:243.0/255.0 alpha:1.0];
    [self.leftBackgroundView addSubview:self.leftImageView];
    
    UIColor *textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    self.titleLabel = [[CTLabel alloc] init:15 textColor:textColor textAlignment:NSTextAlignmentCenter boldFont:YES];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.rightBackgroundView addSubview:self.titleLabel];
    
    self.detailLabel = [[CTLabel alloc] init:13 textColor:textColor textAlignment:NSTextAlignmentCenter boldFont:NO];
    self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightBackgroundView addSubview:self.detailLabel];
    
    self.counter = [CTCounterView new];
    self.counter.translatesAutoresizingMaskIntoConstraints = NO;
    self.counter.delegate = self;
    [self.rightBackgroundView addSubview:self.counter];
    
    self.closeButton = [UIButton new];
    UIImage *closeImage = [[UIImage imageNamed:@"information" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.closeButton setImage:closeImage forState:UIControlStateNormal];
    self.closeButton.tintColor = [UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.closeButton.hidden = YES;
    [self.contentView addSubview:self.closeButton];
    
    self.infoTitleLabel = [[CTLabel alloc] init:15 textColor:textColor textAlignment:NSTextAlignmentCenter boldFont:YES];
    self.infoTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.infoTitleLabel.hidden = YES;
    self.infoTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.infoTitleLabel.numberOfLines = 2;
    [self.contentView addSubview:self.infoTitleLabel];
    
    self.infoDetailLabel = [[CTLabel alloc] init:13 textColor:textColor textAlignment:NSTextAlignmentCenter boldFont:NO];
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
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.titleLabel
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:0.9
                                                                          constant:0]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBackgroundView
                                                                        attribute:NSLayoutAttributeCenterY
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.titleLabel
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1.0
                                                                         constant:32]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBackgroundView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.detailLabel
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.detailLabel
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:1.0
                                                                          constant:0]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                         attribute:NSLayoutAttributeBottom
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.detailLabel
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0
                                                                          constant:-2]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBackgroundView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.counter
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0]];
    [self.rightBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBackgroundView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.counter
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:-24]];
    [self.counter addConstraint:[NSLayoutConstraint constraintWithItem:self.counter
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:100]];
    [self.counter addConstraint:[NSLayoutConstraint constraintWithItem:self.counter
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:28]];
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
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoTitleLabel
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeWidth
                                                                multiplier:0.7
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
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoDetailLabel
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeWidth
                                                                multiplier:0.9
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
    [self.closeButton addTarget:self action:@selector(didTapClose:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    self.infoTitleLabel.text = title;
}

- (void)setDetail:(NSString *)detail {
    self.infoDetailLabel.text = detail;
}

- (void)setChargeAmount:(NSString *)chargeAmount {
    self.detailLabel.text = chargeAmount;
}

- (void)setCount:(NSInteger)count {
    self.counter.countLabel.text = @(count).stringValue;
}

- (void)setChargeAmountHighlighted:(BOOL)chargeAmountHighlighted {
}

- (void)setImage:(UIImage *)image {
    self.leftImageView.image = image;
}

// MARK: Detail Display

- (void)setDetailDisplayed:(BOOL)detailDisplayed animated:(BOOL)animated {
    [UIView transitionWithView:self.contentView
                      duration:animated ? 0.4 : 0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        for (UIView *view in @[self.leftBackgroundView, self.separator, self.rightBackgroundView, self.infoButton]) {
                            view.hidden = detailDisplayed;
                        }
                        for (UIView *view in @[self.closeButton, self.infoTitleLabel, self.infoDetailLabel]) {
                            view.hidden = !detailDisplayed;
                        }
                    } completion:nil];
}

// MARK: Counter Management

- (void)setIncrementEnabled:(BOOL)incrementEnabled {
    [self.counter setIncrementEnabled:incrementEnabled];
}

- (void)setDecrementEnabled:(BOOL)decrementEnabled {
    [self.counter setDecrementEnabled:decrementEnabled];
}

- (void)setEnabled:(BOOL)enabled button:(UIButton *)button {
    button.enabled = enabled;
    button.tintColor = enabled ? [UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0] : [UIColor colorWithRed:227.0/255.0 green:238.0/255.0 blue:247.0/255.0 alpha:1.0];
}

- (void)didTapInfo:(UIButton *)button {
    [self.delegate cellDidTapInfo:self];
}

- (void)didTapClose:(UIButton *)button {
    [self.delegate cellDidTapClose:self];
}

- (void)counterViewDidTapIncrement:(CTCounterView *)counterView {
    [[CTAnalytics instance] tagScreen:@"extras" detail:@"scroll_clk" step:nil];
    [self.delegate cellDidTapIncrement:self];
}

- (void)counterViewDidTapDecrement:(CTCounterView *)counterView {
    [[CTAnalytics instance] tagScreen:@"extras" detail:@"scroll_clk" step:nil];
    [self.delegate cellDidTapDecrement:self];
}

@end
