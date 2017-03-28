//
//  CTInPathCarouselView.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 24/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTCarouselView.h"
#import "CTCarouselCollectionViewCell.h"
#import <CartrawlerSDK/CTAppearance.h>

@interface CTCarouselView() <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *vehicleCollectionView;
@property (nonatomic, strong) UIButton *viewAllButton;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, weak) CTVehicleAvailability *availability;
@property (nonatomic, weak) NSDate *pickupDate;
@property (nonatomic, weak) NSDate *dropoffDate;

@end

@implementation CTCarouselView

- (instancetype)init
{
    self = [super init];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[container(220)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"container" : self}]];
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];//remove for production
    
    _vehicleCollectionView = [self renderCollectionView];
    _viewAllButton = [self renderViewAllButton];
    _pageControl = [self renderPageControl];
    
    [self layout];
    return self;
}

- (void)reloadCollectionViewFromAvailability:(CTVehicleAvailability *)availability
                                  pickupDate:(NSDate *)pickupDate
                                     dropoff:(NSDate *)dropoffDate
{
    _availability = availability;
    _dropoffDate = dropoffDate;
    _pickupDate = pickupDate;
    [self.vehicleCollectionView reloadData];
}

- (void)layout
{
    
    NSDictionary *viewDictionary = @{
                                     @"vehicleCollectionView" : self.vehicleCollectionView,
                                     @"viewAllButton" : self.viewAllButton,
                                     @"pageControl" : self.pageControl,
                                     };
    //Collection view
    [self addSubview:self.vehicleCollectionView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[vehicleCollectionView]-0-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[vehicleCollectionView]-50-|" options:0 metrics:nil views:viewDictionary]];
    
    //View all button
    [self addSubview:self.viewAllButton];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[viewAllButton]-8-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[viewAllButton]-4-|" options:0 metrics:nil views:viewDictionary]];
    
    //View page control
    [self addSubview:self.pageControl];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl]-4-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:0
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:1]];
    
    [self.viewAllButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[viewAllButton(0)]"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:viewDictionary]];
    
    for (NSLayoutConstraint *c in self.viewAllButton.constraints) {
        if (c.firstAttribute == NSLayoutAttributeWidth) {
            c.constant = self.viewAllButton.intrinsicContentSize.width + 24;
        }
    }
    
}

- (UICollectionView *)renderCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(240, 160);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectionView registerClass:[CTCarouselCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    return collectionView;
}

- (UIButton *)renderViewAllButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:@"SEE ALL" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(viewAllAction:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:17];
    [button setTitleColor:[CTAppearance instance].headerTitleColor forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [CTAppearance instance].headerTitleColor.CGColor;
    button.layer.cornerRadius = 5;
    return button;
}

- (UIPageControl *)renderPageControl
{
    UIPageControl *control = [UIPageControl new];
    control.translatesAutoresizingMaskIntoConstraints = NO;
    control.currentPageIndicatorTintColor = [CTAppearance instance].headerTitleColor;
    control.pageIndicatorTintColor = [UIColor grayColor];
    return control;
}

- (void)viewAllAction:(id)sender
{
    if (self.delegate) {
        [self.delegate didSelectViewAll];
    }
}

//MARK: UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int count = self.availability.items.count >= 5 ? 5 : self.availability.items.count;
    self.pageControl.numberOfPages = count;
    return count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CTCarouselCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setVehicle:self.availability.items[indexPath.row]
          pickupDate:self.pickupDate
         dropoffDate:self.dropoffDate];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate) {
        [self.delegate didSelectVehicle:self.availability.items[indexPath.row]];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //use the cell width minus some padding
    NSInteger currentIndex = self.vehicleCollectionView.contentOffset.x / 200;
    self.pageControl.currentPage = currentIndex;
}

@end
