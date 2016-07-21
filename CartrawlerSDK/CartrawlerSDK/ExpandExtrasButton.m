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
    __weak typeof (self) weakSelf = self;
    
    self.extrasViewController.optionalExtrasLoaded = ^(double viewHeight) {
        weakSelf.height.constant = viewHeight;
    };
    
    return self;
}

- (void)refreshView
{
    [self.extrasViewController refreshView];
}

- (void)setExtras:(NSArray<CTExtraEquipment *> *)extras
{
    if (expanded) {
        [self closeExtrasDrawer:YES];
    }
    [self.extrasViewController setExtras:extras];
}

- (void)closeExtrasDrawer:(BOOL)expand
{
    expanded = expand;
    if (!expanded) {
        
        [self.expandButton setTitle:@"-" forState:UIControlStateNormal];
        
        self.height.constant = 50;
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
                                                              constant:0];
        
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
        
        [self.expandButton setTitle:@"+" forState:UIControlStateNormal];

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

- (void)openView
{
   // [self closeExtrasDrawer:NO];
   // self.height.constant = [self.extrasViewController openHeight];
}

- (IBAction)expand:(id)sender
{
    [self closeExtrasDrawer:expanded];
}

@end
