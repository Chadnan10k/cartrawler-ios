//
//  CTExtrasCarouselView.m
//  CartrawlerRental
//
//  Created by Alan on 11/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTExtrasCarouselView.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTAlertViewController.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import "CTRentalLocalizationConstants.h"

@interface CTExtrasCarouselView ()
@property (nonatomic, strong) CTLabel *titleLabel;
@property (nonatomic, strong) UIButton *viewAllButton;
@property (nonatomic, strong) CTExtrasCollectionView *collectionView;
@end

@implementation CTExtrasCarouselView

- (instancetype)initWithExtras:(NSArray *)extras {
    self = [super init];
    if (self) {
        self.titleLabel = [[CTLabel alloc] init:20 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter boldFont:YES];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.text = CTLocalizedString(CTRentalAddExtrasTitle);
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.titleLabel];
        
        self.collectionView = [[CTExtrasCollectionView alloc] initWithScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [self.collectionView updateWithExtras:extras];
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.collectionView];
        
        self.viewAllButton = [UIButton new];
        self.viewAllButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.viewAllButton setTitle:@"View All" forState:UIControlStateNormal];
        [self.viewAllButton setTitleColor:[UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self addSubview:self.viewAllButton];
        [self.viewAllButton addTarget:self action:@selector(didTapViewAll:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addConstraints];
    }
    return self;
}

- (void)addConstraints {
    NSDictionary *views = @{@"titleLabel": self.titleLabel, @"collectionView": self.collectionView, @"viewAllButton": self.viewAllButton};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[titleLabel]-[viewAllButton(80)]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[titleLabel(34)]-(10)-[collectionView(120)]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[viewAllButton(34)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
}

- (void)didTapViewAll:(UIButton *)button {
    [self.delegate extrasViewDidTapViewAll:self];
}

@end
