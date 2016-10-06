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

@end

@implementation CTFilterContainer

+ (void)forceLinkerLoad_ {}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expand)];
//    [self addGestureRecognizer:tap];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expand)];
//    [self addGestureRecognizer:tap];
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
    [self addSubview:titleLabel];
    [self addSubview:tableView];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.tableView reloadData];
    
    [self bringSubviewToFront:self.tableView];
    
    [titleLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [titleLabel addGestureRecognizer:gesture];

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
                           rightConstraint]];
    
    [self.tableView addConstraint:heightConstraint];
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
            tableViewHeight.constant = 0;
            c.constant = 50;
        }
        _isExpanded = NO;
    } else {
        if (c) {
            tableViewHeight.constant = self.tableView.contentSize.height-1;
            CGFloat height = self.tableView.contentSize.height + 20;
            c.constant = height;
        }
        _isExpanded = YES;
    }
}

@end
