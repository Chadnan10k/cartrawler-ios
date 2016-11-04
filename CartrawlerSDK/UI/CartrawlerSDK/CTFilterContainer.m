//
//  CTFilterContainer.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTFilterContainer.h"
#import "CTLabel.h"

@interface CTFilterContainer()

@property (nonatomic) BOOL isExpanded;
@property (nonatomic, strong) CTFilterTableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CTFilterContainer



- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    return self;
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    [self expand];
}

- (void)setTableView:(CTFilterTableView *)tableView
{
    _tableView = tableView;
    self.backgroundColor = [UIColor whiteColor];
    CTLabel *titleLabel = [[CTLabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = tableView.tableViewTitle;
    titleLabel.useBoldFont = YES;
    titleLabel.font = [UIFont fontWithName:titleLabel.font.fontName size:20];
    [self addSubview:titleLabel];
    [self addSubview:tableView];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.tableView reloadData];
    
    [self bringSubviewToFront:self.tableView];
    
    [titleLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [titleLabel addGestureRecognizer:gesture];
    
    //image view
    
    NSBundle *b = [NSBundle bundleForClass:[self class]];
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow" inBundle:b compatibleWithTraitCollection:nil]];
    [self addSubview:self.imageView];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;

    
    NSLayoutConstraint *imageViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1.0
                                                                           constant:10];
    
    NSLayoutConstraint *imageViewRightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                              attribute:NSLayoutAttributeRight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1.0
                                                                               constant:-8];
    
    NSLayoutConstraint *imageViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:30];
    
    NSLayoutConstraint *imageViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:30];
    

    NSLayoutConstraint *labelTopConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1.0
                                                                           constant:5];
    
    NSLayoutConstraint *labelHeightConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1.0
                                                                              constant:40];
    
    
    NSLayoutConstraint *labelLeftConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1.0
                                                                            constant:5];
    
    NSLayoutConstraint *labelRightConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1.0
                                                                             constant:-5];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:titleLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:5];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1.0
                                                                         constant:0];
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:0];
    [self addConstraints:@[labelTopConstraint,
                           labelHeightConstraint,
                           labelLeftConstraint,
                           labelRightConstraint,
                           topConstraint,
                           leftConstraint,
                           rightConstraint,
                           imageViewTopConstraint,
                           imageViewRightConstraint,
                           imageViewWidthConstraint,
                           imageViewHeightConstraint]];
    
    [self.tableView addConstraint:heightConstraint];
}

- (void)close
{
    NSLayoutConstraint *c = nil;
    NSLayoutConstraint *tableViewHeight = nil;
    
    for (NSLayoutConstraint *l in self.constraints) {
        if (l.firstAttribute == NSLayoutAttributeHeight) {
            c = l;
        }
    }
    
    for (NSLayoutConstraint *l in self.tableView.constraints) {
        if (l.firstAttribute == NSLayoutAttributeHeight) {
            tableViewHeight = l;
        }
    }
    
    if (c) {
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.imageView.transform = CGAffineTransformMakeRotation(0);
        } completion:nil];
        
        tableViewHeight.constant = 0;
        c.constant = 50;
    }
    _isExpanded = NO;

}

- (void)expand
{
    NSLayoutConstraint *c = nil;
    NSLayoutConstraint *tableViewHeight = nil;
    
    for (NSLayoutConstraint *l in self.constraints) {
        if (l.firstAttribute == NSLayoutAttributeHeight) {
            c = l;
        }
    }
    
    for (NSLayoutConstraint *l in self.tableView.constraints) {
        if (l.firstAttribute == NSLayoutAttributeHeight) {
            tableViewHeight = l;
        }
    }
    
    if (self.isExpanded) {
        if (c) {
            
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.imageView.transform = CGAffineTransformMakeRotation(0);
            } completion:nil];
            
            tableViewHeight.constant = 0;
            c.constant = 50;
        }
        _isExpanded = NO;
    } else {
        if (c) {
            
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            } completion:nil];
            
            tableViewHeight.constant = self.tableView.contentSize.height-1;
            CGFloat height = self.tableView.contentSize.height + 50;
            c.constant = height;
        }
        _isExpanded = YES;
    }
}

@end
