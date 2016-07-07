//
//  ExpandExtrasButton.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ExpandExtrasButton.h"
#import "OptionalExtrasViewController.h"

@interface ExpandExtrasButton()

@property (weak, nonatomic) IBOutlet UIButton *expandButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@property (strong, nonatomic) NSLayoutConstraint *topConstraint;
@property (strong, nonatomic) NSLayoutConstraint *bottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *rightConstraint;
@property (strong, nonatomic) OptionalExtrasViewController *extrasViewController;

@end

@implementation ExpandExtrasButton {
    BOOL expanded;
}

+ (void)forceLinkerLoad_ {}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    expanded = NO;
    
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.masksToBounds = YES;
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *b = [NSBundle bundleWithPath:bundlePath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepFour" bundle:b];
    
    self.extrasViewController = [storyboard instantiateViewControllerWithIdentifier:@"ExtrasDetailViewController"];
    [self.extrasViewController setExtras:@[]];
    __weak typeof (self) weakSelf = self;
    
    self.extrasViewController.viewLoaded = ^(double viewHeight) {
        weakSelf.height.constant = viewHeight + 200;
    };
    
    
    return self;
}

- (IBAction)expand:(id)sender
{
    if (!expanded) {
        self.height.constant = 300;
        expanded = YES;
        
        [self addSubview:self.extrasViewController.view];
        
        self.extrasViewController.view.translatesAutoresizingMaskIntoConstraints = false;
        self.translatesAutoresizingMaskIntoConstraints = false;
        
        self.topConstraint = [NSLayoutConstraint constraintWithItem:self.extrasViewController.view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:50];
        
        self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.extrasViewController.view
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0
                                                              constant:-5];
        
        self.leftConstraint = [NSLayoutConstraint constraintWithItem:self.extrasViewController.view
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0
                                                            constant:5];
        
        self.rightConstraint = [NSLayoutConstraint constraintWithItem:self.extrasViewController.view
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1.0
                                                             constant:-5];
        [self addConstraints:@[self.topConstraint,
                               self.bottomConstraint,
                               self.leftConstraint,
                               self.rightConstraint]];
        
    } else {
        self.height.constant = 60;
        
        [self.extrasViewController.view removeFromSuperview];
        
        [self removeConstraints:@[self.topConstraint,
                                  self.bottomConstraint,
                                  self.leftConstraint,
                                  self.rightConstraint]];
        
        self.height.constant = 50;
        
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
        expanded = NO;

    }
}

@end
