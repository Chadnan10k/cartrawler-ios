//
//  CTInPathCarouselView.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 24/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTCarouselView.h"
#import "CTCarouselCollectionViewCell.h"

@interface CTCarouselView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) CTVehicleAvailability *availability;

@end

@implementation CTCarouselView

+ (CTCarouselView *)carouselFromAvail:(CTVehicleAvailability *)availability
{
    CTCarouselView *container = [CTCarouselView new];
    container.availability = availability;

    container.translatesAutoresizingMaskIntoConstraints = NO;
    
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[container(240)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"container" : container}]];
    container.backgroundColor = [UIColor yellowColor];
    [container initCollectionView];
    return container;
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(240, 140);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[CTCarouselCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:self.collectionView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.collectionView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[view]-40-|" options:0 metrics:nil views:@{@"view" : self.collectionView}]];
    
    [self.collectionView reloadData];
}

//MARK: UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.availability.items.count >= 5 ? 5 : self.availability.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CTCarouselCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setVehicle:self.availability.items[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate) {
        [self.delegate didSelectVehicle:self.availability.items[indexPath.row]];
    }
}

@end
