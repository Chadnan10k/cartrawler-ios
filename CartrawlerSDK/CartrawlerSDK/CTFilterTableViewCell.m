//
//  CTFilterTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTFilterTableViewCell.h"
#import "CTAppearance.h"
#import "CTLabel.h"
@interface CTFilterTableViewCell()

@property (strong, nonatomic) UIImageView *checkmarkImageView;
@property (strong, nonatomic) CTLabel *label;

@property (nonatomic) BOOL cellEnabled;

@end

@implementation CTFilterTableViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)setup
{
    _checkmarkImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _label = [[CTLabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.checkmarkImageView];
    [self addSubview:self.label];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *b = [NSBundle bundleWithPath:bundlePath];
    self.checkmarkImageView.image = [UIImage imageNamed:@"checkmark" inBundle:b compatibleWithTraitCollection:nil];
    
    self.checkmarkImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    
    //check box
    NSLayoutConstraint *imageCenterXConstraint = [NSLayoutConstraint constraintWithItem:self.checkmarkImageView
                                                                          attribute:NSLayoutAttributeRight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeRight
                                                                         multiplier:1.0
                                                                           constant:-20];
    
    NSLayoutConstraint *imageCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.checkmarkImageView
                                                                              attribute:NSLayoutAttributeCenterY
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeCenterY
                                                                             multiplier:1.0
                                                                               constant:0];
    
    NSLayoutConstraint *imageWidthConstraint = [NSLayoutConstraint constraintWithItem:self.checkmarkImageView
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1.0
                                                                              constant:20];
    
    
    NSLayoutConstraint *imageHeightConstraint = [NSLayoutConstraint constraintWithItem:self.checkmarkImageView
                                                                           attribute:NSLayoutAttributeHeight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.0
                                                                            constant:20];
    
    //label
    NSLayoutConstraint *labelTopConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:8];
    
    NSLayoutConstraint *labelBottomConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:-8];
    
    NSLayoutConstraint *labelLeftConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:5];
    
    NSLayoutConstraint *labelRightConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.checkmarkImageView
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                       constant:-5];
    [self addConstraints:@[imageCenterXConstraint,
                           imageCenterYConstraint,
                           imageWidthConstraint,
                           imageHeightConstraint,
                           labelTopConstraint,
                           labelBottomConstraint,
                           labelLeftConstraint,
                           labelRightConstraint
                           ]];
    
    [self updateConstraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setText:(NSString *)text
{
    self.label.text = text;
}

- (void)enableCheckmark:(BOOL)enableCheckmark
{
    _cellEnabled = enableCheckmark;
    
    if (self.cellEnabled) {
        self.checkmarkImageView.alpha = 1;
        _cellEnabled = YES;
    } else {
        self.checkmarkImageView.alpha = 0;
        _cellEnabled = NO;
    }
}

- (void)cellTapped
{
    if (self.cellEnabled) {
        self.checkmarkImageView.alpha = 0;
        _cellEnabled = NO;
    } else {
        self.checkmarkImageView.alpha = 1;
        _cellEnabled = YES;
    }
}

@end
