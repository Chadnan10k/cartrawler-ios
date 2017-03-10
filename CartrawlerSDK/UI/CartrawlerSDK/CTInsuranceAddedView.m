//
//  CTInsuranceOfferingView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 09/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

//
//  CTInsuranceView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 08/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTInsuranceAddedView.h"
#import <CartrawlerSDK/CTLabel.h>

@interface CTInsuranceAddedView()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *shieldImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *removeButton;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UILabel *subheaderLabel;

@end

@implementation CTInsuranceAddedView

- (instancetype)init
{
    self = [super init];
    [self createBackgroundView];
    [self buildAddedState];
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

- (void)buildAddedState
{
    _backgroundImageView = [UIImageView new];
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundImageView.backgroundColor = [UIColor redColor];
    [self.backgroundView addSubview:self.backgroundImageView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[backgroundImage]-0-|" options:0 metrics:nil views:@{@"backgroundImage" : self.backgroundImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[backgroundImage]-0-|" options:0 metrics:nil views:@{@"backgroundImage" : self.backgroundImageView}]];
    
    _shieldImageView = [UIImageView new];
    self.shieldImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.shieldImageView.backgroundColor = [UIColor orangeColor];
    [self.backgroundView addSubview:self.shieldImageView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[shieldImage(100)]" options:0 metrics:nil views:@{@"shieldImage" : self.shieldImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[shieldImage]-|" options:0 metrics:nil views:@{@"shieldImage" : self.shieldImageView}]];
    
    _headerLabel = [CTLabel new];
    self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerLabel.backgroundColor = [UIColor greenColor];
    self.headerLabel.textAlignment = NSTextAlignmentCenter;
    self.headerLabel.text = @"test header";
    [self.backgroundView addSubview:self.headerLabel];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[shieldImage]-[headerLabel]" options:0 metrics:nil views:@{@"headerLabel" : self.headerLabel, @"shieldImage" : self.shieldImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[headerLabel]-|" options:0 metrics:nil views:@{@"headerLabel" : self.headerLabel}]];
    
    _subheaderLabel = [CTLabel new];
    self.subheaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subheaderLabel.backgroundColor = [UIColor greenColor];
    self.subheaderLabel.textAlignment = NSTextAlignmentCenter;
    self.subheaderLabel.text = @"test subheader";
    [self.backgroundView addSubview:self.subheaderLabel];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headerLabel]-[subheaderLabel]" options:0 metrics:nil views:@{@"subheaderLabel" : self.subheaderLabel, @"headerLabel" : self.headerLabel}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[subheaderLabel]-|" options:0 metrics:nil views:@{@"subheaderLabel" : self.subheaderLabel}]];
    
    _removeButton = [UIButton new];
    [self.removeButton addTarget:self action:@selector(removeInsurance:) forControlEvents:UIControlEventTouchUpInside];
    self.removeButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.removeButton.backgroundColor = [UIColor purpleColor];
    [self.removeButton setTitle:@"Remove" forState:UIControlStateNormal];
    [self.backgroundView addSubview:self.removeButton];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subheaderLabel]-[removeButton(40)]-|" options:0 metrics:nil views:@{@"subheaderLabel" : self.subheaderLabel, @"removeButton" : self.removeButton}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[removeButton]-|" options:0 metrics:nil views:@{@"removeButton" : self.removeButton}]];
}

- (void)removeInsurance:(id)sender
{
    if (self.removeAction) {
        self.removeAction();
    }
}

@end
