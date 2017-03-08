//
//  CTInsuranceView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 08/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTInsuranceView.h"
#import <CartrawlerSDK/CTLabel.h>

@interface CTInsuranceView()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) CTLabel *headerLabel;
@property (nonatomic, strong) CTLabel *subheaderLabel;
@property (nonatomic, strong) UIImageView *shieldImageView;
@property (nonatomic, strong) UIButton *addNowButton;
@property (nonatomic, strong) UIButton *termsButton;

@end

@implementation CTInsuranceView

- (instancetype)init
{
    self = [super init];
    [self createBackgroundView];
    [self buildAddInsuranceState];
    return self;
}

- (void)createBackgroundView
{
    _backgroundView = [UIView new];
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.backgroundView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[backgroundView(0@100)]-|" options:0 metrics:nil views:@{@"backgroundView" : self.backgroundView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[backgroundView]-|" options:0 metrics:nil views:@{@"backgroundView" : self.backgroundView}]];
}

- (void)buildAddInsuranceState
{
    _headerLabel = [CTLabel new];
    self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerLabel.text = @"Test add insurance";
    [self.backgroundView addSubview:self.headerLabel];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[label]" options:0 metrics:nil views:@{@"label" : self.headerLabel}]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]-|" options:0 metrics:nil views:@{@"label" : self.headerLabel}]];
    
    _subheaderLabel = [CTLabel new];
    self.subheaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subheaderLabel.text = @"Test add insurance";
    [self.backgroundView addSubview:self.subheaderLabel];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[header]-[label]" options:0 metrics:nil views:@{@"label" : self.subheaderLabel, @"header" : self.headerLabel}]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]-|" options:0 metrics:nil views:@{@"label" : self.subheaderLabel}]];
    
    _shieldImageView = [UIImageView new];
    self.shieldImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.shieldImageView.contentMode = UIViewContentModeScaleAspectFit;
    NSBundle *b = [NSBundle bundleForClass:[self class]];
    UIImage *shield = [UIImage imageNamed:@"insurance_shield" inBundle:b compatibleWithTraitCollection:nil];
    self.shieldImageView.image = shield;
    [self.backgroundView addSubview:self.shieldImageView];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[image(40)]" options:0 metrics:nil views:@{@"image" : self.shieldImageView}]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[image(40)]-|" options:0 metrics:nil views:@{@"image" : self.shieldImageView}]];
    
    _addNowButton = [UIButton new];
    self.addNowButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.addNowButton setTitle:@"Add Test Insurance" forState:UIControlStateNormal];
    [self.backgroundView addSubview:self.addNowButton];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-[button(60)]" options:0 metrics:nil views:@{@"button" : self.addNowButton, @"label" : self.subheaderLabel}]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button]-|" options:0 metrics:nil views:@{@"button" : self.addNowButton}]];
    self.addNowButton.backgroundColor = [UIColor redColor];
    
    _termsButton = [UIButton new];
    self.termsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.termsButton setTitle:@"terms and cond" forState:UIControlStateNormal];
    [self.backgroundView addSubview:self.termsButton];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[addButton]-[button(30)]-|" options:0 metrics:nil views:@{@"button" : self.termsButton, @"addButton" : self.addNowButton}]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button]-|" options:0 metrics:nil views:@{@"button" : self.termsButton}]];
    self.termsButton.backgroundColor = [UIColor redColor];
}

- (UIView *)buildAccordion
{
    UIView *accordionBackground = [UIView new];
    accordionBackground.translatesAutoresizingMaskIntoConstraints = NO;
    accordionBackground.backgroundColor = [UIColor greenColor];
    
    //label
    
    //icon
    
    //text view
    
    return accordionBackground;
}

@end
