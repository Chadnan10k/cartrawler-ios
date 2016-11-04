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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    UIImage* image =[UIImage imageNamed:@"checkmark" inBundle:bundle compatibleWithTraitCollection:nil];
    
    (self.imageView).image = image;
    [self addSubview:self.imageView];
    self.imageView.translatesAutoresizingMaskIntoConstraints = false;
    (self.imageView).contentMode = UIViewContentModeScaleAspectFit;
    
    NSLayoutConstraint *imageViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1.0
                                                                               constant:5];
    NSLayoutConstraint *imageViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                                 attribute:NSLayoutAttributeBottom
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self
                                                                                 attribute:NSLayoutAttributeBottom
                                                                                multiplier:1.0
                                                                                  constant:-5];
    NSLayoutConstraint *imageViewLeftConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1.0
                                                                                constant:5];
    NSLayoutConstraint *imageViewRightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                                attribute:NSLayoutAttributeRight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1.0
                                                                                 constant:-5];
    [self addConstraints:@[imageViewTopConstraint,
                           imageViewBottomConstraint,
                           imageViewLeftConstraint,
                           imageViewRightConstraint]];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(boxTapped:)];
    [self addGestureRecognizer:gesture];
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imageView.alpha = self.enabled;
    _checkEnabled = self.enabled;
}

+ (void)forceLinkerLoad_
{
    
}

- (void)boxTapped:(UIGestureRecognizer *)gesture
{
    if (self.checkEnabled) {
        self.checkEnabled = NO;
        _enabled = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.alpha = 0;
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.viewTapped(NO);
        });
    } else {
        self.checkEnabled = YES;
        _enabled = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.alpha = 1;
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.viewTapped(YES);
        });
    }
}


@end
