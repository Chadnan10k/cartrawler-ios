//
//  ExpandingInfoView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ExpandingInfoView.h"
#import <QuartzCore/QuartzCore.h>
#import "CTAppearance.h"

@interface ExpandingInfoView()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) NSLayoutConstraint *topConstraint;
@property (strong, nonatomic) NSLayoutConstraint *bottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *rightConstraint;

@end

@implementation ExpandingInfoView {
    BOOL expanded;
}

+ (void)forceLinkerLoad_ {}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.masksToBounds = YES;
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
    return self;
}

- (void)setTitle:(NSString *)title text:(NSString *)text image:(UIImage *)image
{
    self.titleLabel.text = title;
    self.imageView.image = image;
    self.textView.text = text;
    
    self.textView.alpha = 0;
    self.textView.editable = NO;
    self.textView.font = [UIFont fontWithName:[CTAppearance instance].fontName size:18];
    [self.textView scrollRangeToVisible:NSMakeRange(0, 0)];
    self.heightConstraint.constant = 50;
    [self layoutIfNeeded];
    expanded = NO;
    
    self.textView.translatesAutoresizingMaskIntoConstraints = false;
    self.translatesAutoresizingMaskIntoConstraints = false;
}

- (IBAction)sizeViewTapped:(id)sender
{
    if (!expanded) {
        
        [self.button setTitle:@"-" forState:UIControlStateNormal];

            
            [self addSubview:self.textView];
            
            self.topConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:50];
            
            self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:-10];
            
            self.leftConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:10];
            
            self.rightConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1.0
                                                                constant:-10];
            [self addConstraints:@[self.topConstraint,
                                   self.bottomConstraint,
                                   self.leftConstraint,
                                   self.rightConstraint]];
        
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
        [self layoutSubviews];
        self.heightConstraint.constant = 60 + self.textView.contentSize.height;
        self.textView.alpha = 1;
        
        expanded = YES;

    } else {
        
        [self.button setTitle:@"+" forState:UIControlStateNormal];

        self.textView.alpha = 0;
        [self.textView removeFromSuperview];
        
        [self removeConstraints:@[self.topConstraint,
                               self.bottomConstraint,
                               self.leftConstraint,
                               self.rightConstraint]];
        
        self.heightConstraint.constant = 50;

        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
        
        expanded = NO;
    }
}


@end
