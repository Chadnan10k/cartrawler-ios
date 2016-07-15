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
    
    return self;
}

- (id)initWithView:(UIView *)view placeholder:(NSString *)placeholder
{
    self = [super init];
    
    self.frame = CGRectZero;
    
    [view addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:view
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1.0
                                                                       constant:0];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                      attribute:NSLayoutAttributeBottom
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:view
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1.0
                                                                       constant:5];
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:view
                                                                        attribute:NSLayoutAttributeLeft
                                                                       multiplier:1.0
                                                                         constant:0];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                      attribute:NSLayoutAttributeRight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:view
                                                                      attribute:NSLayoutAttributeRight
                                                                     multiplier:1.0
                                                                       constant:0];
    [view addConstraints:@[topConstraint,
                           bottomConstraint,
                           leftConstraint,
                           rightConstraint]];
    
    [view addSubview: self];
    
    //Add textfield
    
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
    [self.textField setPlaceholder:placeholder];
    
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    
    return self;
}

- (void)setTextFieldText:(NSString *)text
{
    self.textField.text = text;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.viewTapped();
    });
    return NO;
}

- (void)shakeAnimation
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1 options:0 animations:^{
        self.transform = CGAffineTransformMakeScale(1.02, 1.02);
        self.backgroundColor = [UIColor redColor];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.backgroundColor = [UIColor whiteColor];
        }];
    }];
}

@end
