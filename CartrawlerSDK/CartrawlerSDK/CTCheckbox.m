//
//  CTCheckbox.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 07/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTCheckbox.h"

@interface CTCheckbox()

@property (nonatomic) BOOL checkEnabled;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CTCheckbox

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)forceLinkerLoad_
{
    
}

- (void)boxTapped:(UIGestureRecognizer *)gesture
{
    if (self.checkEnabled) {
        self.checkEnabled = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.alpha = 0;
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.viewTapped(NO);
        });
    } else {
        self.checkEnabled = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.alpha = 1;
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.viewTapped(YES);
        });
    }
}

- (id)initEnabled:(BOOL)enabled containerView:(UIView *)containerView;
{
    self = [super init];
    
    self.checkEnabled = enabled;
    
    self.frame = CGRectZero;
    
    [containerView addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:containerView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:containerView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:containerView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:containerView
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:0];
    [containerView addConstraints:@[topConstraint,
                           bottomConstraint,
                           leftConstraint,
                           rightConstraint]];
    
    [containerView addSubview: self];
    
    //Add textfield
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    NSBundle* bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle]URLForResource:@"CartrawlerResources" withExtension:@"bundle"]];    
    UIImage* image =[UIImage imageNamed:@"checkmark" inBundle:bundle compatibleWithTraitCollection:nil];
    
    [self.imageView setImage:image];
    [self addSubview:self.imageView];
    self.imageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    NSLayoutConstraint *textFieldTopConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1.0
                                                                               constant:5];
    NSLayoutConstraint *textFieldBottomConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                                 attribute:NSLayoutAttributeBottom
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self
                                                                                 attribute:NSLayoutAttributeBottom
                                                                                multiplier:1.0
                                                                                  constant:-5];
    NSLayoutConstraint *textFieldLeftConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1.0
                                                                                constant:5];
    NSLayoutConstraint *textFieldRightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                                attribute:NSLayoutAttributeRight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1.0
                                                                                 constant:-5];
    [self addConstraints:@[textFieldTopConstraint,
                           textFieldBottomConstraint,
                           textFieldLeftConstraint,
                           textFieldRightConstraint]];
    
    containerView.layer.cornerRadius = 5;
    containerView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(boxTapped:)];
    [self addGestureRecognizer:gesture];
        
    return self;
}

@end
