//
//  CTExtrasCarouselViewCell.m
//  CartrawlerSDK
//
//  Created by Alan on 10/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTExtrasCarouselViewCell.h"
#import <CartrawlerSDK/CTCounterView.h>
#import <CartrawlerSDK/CTLayoutManager.h>

@interface CTExtrasCarouselViewCell () <CTCounterViewDelegate>

@property (nonatomic, strong) UIButton *infoButton;

@property (nonatomic, strong) UIView *imageBackgroundView;
@property (nonatomic, strong) UIImageView *imageView;
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
        [self addBackgroundGradient];
        [self addViews];
        [self addConstraints];
        [self addCommands];
    }
    return self;
}

- (void)addBackgroundGradient {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    UIColor *bottomColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0];
    gradient.colors = @[(id)[UIColor whiteColor].CGColor, (id)bottomColor.CGColor];
    [self.contentView.layer insertSublayer:gradient atIndex:0];
    
    self.contentView.layer.cornerRadius = 2.0;
    self.contentView.layer.borderWidth = 1.0;
    self.contentView.layer.borderColor = [UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:1.0].CGColor;
    self.contentView.clipsToBounds = YES;
}

- (void)addViews {
    self.imageBackgroundView = [UIView new];
    self.imageBackgroundView.layer.borderWidth = 2.0;
    self.imageBackgroundView.layer.borderColor = [UIColor colorWithRed:240.0/255.0 green:199.0/255.0 blue:69.0/255.0 alpha:1.0].CGColor;
    self.imageBackgroundView.layer.masksToBounds = YES;
    self.imageBackgroundView.layer.cornerRadius = 20;
    self.imageBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.imageBackgroundView];
    
    self.infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    self.infoButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.infoButton];
    
    self.imageView = [UIImageView new];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.tintColor = [UIColor colorWithRed:12.0/255.0 green:57.0/255.0 blue:142.0/255.0 alpha:1.0];
    [self.imageBackgroundView addSubview:self.imageView];
    
    UIColor *textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    self.titleLabel = [[CTLabel alloc] init:18 textColor:textColor textAlignment:NSTextAlignmentCenter boldFont:YES];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:self.titleLabel];
    
    UIColor *detailColor = [UIColor colorWithRed:130.0/255.0 green:135.0/255.0 blue:143.0/255.0 alpha:1.0];
    self.detailLabel = [[CTLabel alloc] init:15 textColor:detailColor textAlignment:NSTextAlignmentCenter boldFont:NO];
    self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.detailLabel];
    
    self.counter = [CTCounterView new];
    self.counter.translatesAutoresizingMaskIntoConstraints = NO;
    self.counter.delegate = self;
    [self.contentView addSubview:self.counter];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
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
    self.infoDetailLabel.numberOfLines = 0;
    self.infoDetailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.infoDetailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.infoDetailLabel.hidden = YES;
    self.infoDetailLabel.allowsDefaultTighteningForTruncation = YES;
    [self.contentView addSubview:self.infoDetailLabel];
}

- (void)addConstraints {
    NSDictionary *views = @{@"imageBackgroundView": self.imageBackgroundView, @"imageView" : self.imageView, @"infoButton" : self.infoButton, @"closeButton" : self.closeButton, @"titleLabel" : self.titleLabel, @"detailLabel" : self.detailLabel, @"counter" : self.counter, @"infoTitleLabel": self.infoTitleLabel, @"infoDetailLabel": self.infoDetailLabel};
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[imageBackgroundView(40)]-15-[titleLabel][detailLabel(==titleLabel)]-15-[counter(30)]-10-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageBackgroundView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageBackgroundView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:40]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[imageView]-5-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[imageView]-5-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.detailLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.counter
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    [self.counter addConstraint:[NSLayoutConstraint constraintWithItem:self.counter
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0
                                                              constant:100]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[infoButton(20)]-(10)-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[infoButton(20)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-25-[infoTitleLabel(20)]-5-[infoDetailLabel]-5-[counter(30)]-10-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageBackgroundView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[closeButton(20)]-(10)-|"
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
    self.imageView.image = image;
}

// MARK: Detail Display

- (void)setDetailDisplayed:(BOOL)detailDisplayed animated:(BOOL)animated {
    [UIView transitionWithView:self.contentView
                      duration:animated ? 0.4 : 0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        for (UIView *view in @[self.titleLabel, self.detailLabel, self.imageBackgroundView, self.infoButton]) {
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
    [self.delegate cellDidTapIncrement:self];
}

- (void)counterViewDidTapDecrement:(CTCounterView *)counterView {
    [self.delegate cellDidTapDecrement:self];
}

@end
