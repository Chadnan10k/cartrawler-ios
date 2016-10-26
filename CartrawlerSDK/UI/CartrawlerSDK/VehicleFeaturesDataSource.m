//
//  VehicleFeaturesDataSource.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 25/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "VehicleFeaturesDataSource.h"
#import "VehicleFeatureCollectionViewCell.h"

@interface VehicleFeaturesDataSource()

@property (nonatomic, strong) NSArray < NSDictionary *> *items;

@end

@implementation VehicleFeaturesDataSource

- (instancetype)init
{
    self = [super init];
    _items = @[];
    return self;
}

- (void)setData:(NSArray < NSDictionary *> *)items
{
    _items = items;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *b = [NSBundle bundleWithPath:bundlePath];
    NSString *text = [self.items[indexPath.row] objectForKey:@"text"];
    UIImage *image = [UIImage imageNamed:[self.items[indexPath.row] objectForKey:@"image"] inBundle:b compatibleWithTraitCollection:nil];

    VehicleFeatureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setData:text image:image];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((collectionView.frame.size.width/2)-16, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8,8,8,8);
}
@end
