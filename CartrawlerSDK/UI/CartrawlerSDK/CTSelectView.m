//
//  LocationSelectView.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 03/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSelectView.h"
#import "JVFloatLabeledTextField.h"
#import "CTAppearance.h"

@interface CTSelectView() <UITextFieldDelegate>

@property (nonatomic, strong) JVFloatLabeledTextField *textField;

@end

@implementation CTSelectView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    //Add textfield
    
    self.layer.borderColor = [UIColor colorWithRed:213.0/255.0 green:213.0/255.0 blue:213.0/255.0 alpha:1].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = [CTAppearance instance].textFieldCornerRadius;
    
    self.textField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    self.textField.font = [UIFont fontWithName:[CTAppearance instance].fontName size:20];
    self.textField.floatingLabelYPadding = -2;
    
    [self addSubview:self.textField];
    self.textField.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint *textFieldTopConstraint = [NSLayoutConstraint constraintWithItem:self.textField
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1.0
                                                                               constant:5];
    NSLayoutConstraint *textFieldBottomConstraint = [NSLayoutConstraint constraintWithItem:self.textField
                                                                                 attribute:NSLayoutAttributeBottom
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self
                                                                                 attribute:NSLayoutAttributeBottom
                                                                                multiplier:1.0
                                                                                  constant:-5];
    NSLayoutConstraint *textFieldLeftConstraint = [NSLayoutConstraint constraintWithItem:self.textField
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1.0
                                                                                constant:10];
    NSLayoutConstraint *textFieldRightConstraint = [NSLayoutConstraint constraintWithItem:self.textField
                                                                                attribute:NSLayoutAttributeRight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1.0
                                                                                 constant:5];
    [self addConstraints:@[textFieldTopConstraint,
                           textFieldBottomConstraint,
                           textFieldLeftConstraint,
                           textFieldRightConstraint]];
    
    self.textField.delegate = self;
    self.textField.placeholder = self.placeholder;
    self.textField.adjustsFontSizeToFitWidth = YES;
    
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    self.textField.placeholder = placeholder;
}

- (void)setTextFieldText:(NSString *)text
{
    self.textField.text = text;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    return NO;
}

- (void)shakeAnimation
{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.6;
    animation.values = @[ @(-20), @(20), @(-20), @(20), @(-10), @(10), @(-5), @(5), @(0) ];
    [self.layer addAnimation:animation forKey:@"shake"];
}

@end
