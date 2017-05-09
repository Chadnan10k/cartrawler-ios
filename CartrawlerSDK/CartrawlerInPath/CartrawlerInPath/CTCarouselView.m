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
#import "CTInPathLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CTAnalytics.h>

@interface CTCarouselView() <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *vehicleCollectionView;
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
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[container(185@100)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"container" : self}]];
    _vehicleCollectionView = [self renderCollectionView];
    _pageControl = [self renderPageControl];
    
    [[CTAnalytics instance] tagScreen:@"display_WI" detail:@"displayed" step:@-1];

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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.vehicleCollectionView setContentOffset:CGPointMake(-15, 0)];
    });
}

- (void)layout
{
    
    NSDictionary *viewDictionary = @{
                                     @"vehicleCollectionView" : self.vehicleCollectionView,
                                     @"pageControl" : self.pageControl,
                                     };
    //Collection view
    [self addSubview:self.vehicleCollectionView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[vehicleCollectionView]-0-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[vehicleCollectionView]" options:0 metrics:nil views:viewDictionary]];

    //View page control
    [self addSubview:self.pageControl];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[vehicleCollectionView(140)]-2-[pageControl(10)]-2-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[pageControl]-8-|" options:0 metrics:nil views:viewDictionary]];
}

- (UICollectionView *)renderCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(240, 120);
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

- (UIPageControl *)renderPageControl
{
    UIPageControl *control = [UIPageControl new];
    control.translatesAutoresizingMaskIntoConstraints = NO;
    control.currentPageIndicatorTintColor = [CTAppearance instance].headerTitleColor;
    control.pageIndicatorTintColor = [UIColor grayColor];
    return control;
}

//MARK: UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSUInteger count = self.availability.items.count >= 5 ? 5 : self.availability.items.count;
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
    [[CTAnalytics instance] tagScreen:@"click_WI" detail:@(indexPath.row + 1).stringValue step:@-1];
    [[CTAnalytics instance] tagScreen:@"display_WI" detail:@"clicked" step:@-1];
    if (self.delegate) {
        [self.delegate didSelectVehicle:self.availability.items[indexPath.row] atIndex:indexPath.row];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //use the cell width minus some padding
    NSInteger currentIndex = self.vehicleCollectionView.contentOffset.x / 200;
    self.pageControl.currentPage = currentIndex;
    if (self.delegate) {
        [self.delegate didDisplayVehicle:self.availability.items[currentIndex] atIndex:currentIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self tagScrollViewOffset:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self tagScrollViewOffset:scrollView];
    }
}

- (void)tagScrollViewOffset:(UIScrollView *)scrollView {
    if (scrollView.contentSize.width > 0) {
        int percentageOffset = 100 * scrollView.contentOffset.x / (scrollView.contentSize.width - scrollView.frame.size.width);
        [[CTAnalytics instance] tagScreen:@"scroll_WI" detail:@(percentageOffset).stringValue step:@-1];
    }
}

@end
