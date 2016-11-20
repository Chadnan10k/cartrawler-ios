//
//  BookingSummaryButton.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "BookingSummaryButton.h"
#import "BookingSummaryViewController.h"
#import "CTLabel.h"

@interface BookingSummaryButton()

@property (strong, nonatomic) NSLayoutConstraint *topConstraint;
@property (strong, nonatomic) NSLayoutConstraint *bottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *rightConstraint;

@property (strong, nonatomic) CTLabel *titleLabel;
@property (strong, nonatomic) UIButton *expandButton;

@end

@implementation BookingSummaryButton
{
    BOOL summaryVisible;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _titleLabel = [CTLabel new];
    _expandButton = [UIButton new];

    [self.expandButton setImage:[UIImage imageNamed:@"arrow"
                                           inBundle:[NSBundle bundleForClass:[self class]]
                      compatibleWithTraitCollection:nil]
                       forState:UIControlStateNormal];
    
    self.titleLabel.text = NSLocalizedString(@"Booking summary", @"Booking summary");
    
    self.expandButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.expandButton addTarget:self action:@selector(viewTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: self.expandButton];
    [self addSubview: self.titleLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[view]" options:0 metrics:nil views:@{@"view" : self.titleLabel }]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]" options:0 metrics:nil views:@{@"view" : self.titleLabel }]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[view(25)]" options:0 metrics:nil views:@{@"view" : self.expandButton }]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(25)]-8-|" options:0 metrics:nil views:@{@"view" : self.expandButton }]];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    [self addGestureRecognizer:tap];
    return self;
}

- (void)viewTapped
{
    if (self.delegate) {
        [self.delegate openSummaryTapped];
    }
}

@end
