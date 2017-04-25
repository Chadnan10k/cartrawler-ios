//
//  CTExtrasListCollectionViewCell.m
//  CartrawlerRental
//
//  Created by Alan on 13/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTExtrasListCollectionViewCell.h"
#import <CartrawlerSDK/CTCounterView.h>
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTTriangleView.h>

CGFloat const kExtrasTriangleHeight = 10.0;

@interface CTExtrasListCollectionViewCell () <CTCounterViewDelegate>
@property (nonatomic, strong) UIView *titleContainer;
@property (nonatomic, strong) UIView *detailContainer;
@property (nonatomic, strong) UIView *separator;
@property (nonatomic, strong) CTLabel *titleLabel;
@property (nonatomic, strong) CTLabel *costLabel;
@property (nonatomic, strong) CTLabel *detailLabel;
@property (nonatomic, strong) CTCounterView *counter;
@property (nonatomic, strong) CTTriangleView *triangle;
@property (nonatomic, strong) NSLayoutConstraint *triangleBottomConstraint;
@end

@implementation CTExtrasListCollectionViewCell
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        [self addViews];
        [self addConstraints];
    }
    return self;
}

// MARK: Subviews

- (void)addViews {
    self.titleContainer = [UIView new];
    self.titleContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleContainer];
    
    self.titleLabel = [[CTLabel alloc] init:20 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft boldFont:NO];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.titleContainer addSubview:self.titleLabel];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    UIColor *textColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:207.0/255.0 alpha:1.0];
    self.costLabel = [[CTLabel alloc] init:18 textColor:textColor textAlignment:NSTextAlignmentLeft boldFont:NO];
    self.costLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.titleContainer addSubview:self.costLabel];
    
    UIColor *backgroundColor = [UIColor colorWithRed:33.0/255.0 green:74.0/255.0 blue:150.0/255.0 alpha:1.0];
    self.detailContainer = [UIView new];
    self.detailContainer.translatesAutoresizingMaskIntoConstraints = NO;
    self.detailContainer.backgroundColor = backgroundColor;
    [self.contentView addSubview:self.detailContainer];
    
    self.detailLabel = [[CTLabel alloc] init:18 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter boldFont:NO];
    self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.detailContainer addSubview:self.detailLabel];
    
    self.counter = [CTCounterView new];
    self.counter.translatesAutoresizingMaskIntoConstraints = NO;
    self.counter.delegate = self;
    [self.contentView addSubview:self.counter];
    
    self.separator = [UIView new];
    self.separator.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:241.0/255.0 alpha:1.0];
    self.separator.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.separator];
    
    self.triangle = [[CTTriangleView alloc] initWithColor:backgroundColor];
    self.triangle.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.triangle];
}

- (void)addConstraints {
    NSDictionary *views = @{@"titleContainer": self.titleContainer, @"detailContainer": self.detailContainer, @"titleLabel": self.titleLabel, @"costLabel": self.costLabel, @"detailLabel" : self.detailLabel, @"counter" : self.counter, @"separator": self.separator};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleContainer]-[counter(100)]-30-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self.titleContainer setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[separator]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[detailContainer]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.titleContainer
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:-40.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.counter
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:-40.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.detailContainer
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:-80.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.separator
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:-79.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.counter
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:30.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.separator
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:1.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.detailContainer
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:80.0]];
    
    [self.titleContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:views]];
    [self.titleContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[costLabel]-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:views]];
    [self.titleContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleLabel][costLabel]|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:views]];
    
    [self.detailContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[detailLabel]-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
    [self.detailContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[detailLabel]-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.triangle
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:20.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.triangle
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:kExtrasTriangleHeight]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.triangle
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.detailContainer
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    self.triangleBottomConstraint = [NSLayoutConstraint constraintWithItem:self.triangle
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.detailContainer
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:kExtrasTriangleHeight];
    [self addConstraint:self.triangleBottomConstraint];
}


// MARK: CTExtrasCollectionViewCellProtocol

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setChargeAmount:(NSString *)chargeAmount {
    self.costLabel.text = chargeAmount;
}

- (void)setChargeAmountHighlighted:(BOOL)chargeAmountHighlighted {
    self.costLabel.textColor = chargeAmountHighlighted ? [UIColor colorWithRed:53.0/255.0 green:179.0/255.0 blue:98.0/255.0 alpha:1.0] : [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:207.0/255.0 alpha:1.0];
}

- (void)setDetail:(NSString *)detail {
    self.detailLabel.text = detail;
}

- (void)setCount:(NSInteger)count {
    self.counter.countLabel.text = @(count).stringValue;
}

// MARK: Detail Display

- (void)setDetailDisplayed:(BOOL)detailDisplayed animated:(BOOL)animated {
    self.triangleBottomConstraint.constant = detailDisplayed ? 0 : kExtrasTriangleHeight;
    
    [UIView animateWithDuration:animated ? 0.3 : 0
                     animations:^{
                         [self layoutIfNeeded];
                     }];
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
    button.tintColor = enabled ? [UIColor colorWithRed:25.0/255.0 green:173.0/255.0 blue:79.0/255.0 alpha:1.0] : [UIColor colorWithRed:227.0/255.0 green:238.0/255.0 blue:247.0/255.0 alpha:1.0];
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
