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
#import <CartrawlerSDK/CTAppearance.h>

@interface CTExtrasCarouselView () <CTExtrasCollectionViewDelegate>
@property (nonatomic, strong) CTLabel *titleLabel;
@property (nonatomic, strong) UIButton *viewAllButton;
@property (nonatomic, strong) CTExtrasCollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation CTExtrasCarouselView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleLabel = [[CTLabel alloc] init:20 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter boldFont:YES];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.text = CTLocalizedString(CTRentalAddExtrasTitle);
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.titleLabel];
        
        self.collectionView = [[CTExtrasCollectionView alloc] initWithScrollDirection:UICollectionViewScrollDirectionHorizontal];
        self.collectionView.delegate = self;
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.collectionView];
        
        self.viewAllButton = [UIButton new];
        self.viewAllButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.viewAllButton setTitle:CTLocalizedString(CTRentalExtrasViewAll) forState:UIControlStateNormal];
        [self.viewAllButton setTitleColor:[UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self addSubview:self.viewAllButton];
        [self.viewAllButton addTarget:self action:@selector(didTapViewAll:) forControlEvents:UIControlEventTouchUpInside];
        
        self.pageControl = [self renderPageControl];
        [self addSubview:self.pageControl];
        
        [self addConstraints];
    }
    return self;
}

- (UIPageControl *)renderPageControl
{
    UIPageControl *control = [UIPageControl new];
    control.translatesAutoresizingMaskIntoConstraints = NO;
    control.currentPageIndicatorTintColor = [CTAppearance instance].headerTitleColor;
    control.pageIndicatorTintColor = [UIColor grayColor];
    return control;
}

- (void)addConstraints {
    NSDictionary *views = @{@"titleLabel": self.titleLabel, @"collectionView": self.collectionView, @"viewAllButton": self.viewAllButton, @"pageControl" : self.pageControl};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[titleLabel]-[viewAllButton(80)]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pageControl]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[titleLabel(34)]-(10)-[collectionView(180)]-[pageControl(20)]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10)-[viewAllButton(34)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
}

- (void)updateWithExtras:(NSArray<CTExtraEquipment *> *)extras {
    self.pageControl.numberOfPages = extras.count;
    [self.collectionView updateWithExtras:extras];
}

- (void)didTapViewAll:(UIButton *)button {
    [self.delegate extrasViewDidTapViewAll:self];
}

// MARK: Collection View Delegate

- (void)collectionViewDidScrollToIndex:(NSInteger)index
{
    self.pageControl.currentPage = index;
}

@end
