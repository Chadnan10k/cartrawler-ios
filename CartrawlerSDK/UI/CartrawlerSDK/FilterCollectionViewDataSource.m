//
//  FilterCollectionViewDataSource.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 09/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "FilterCollectionViewDataSource.h"

@interface FilterCollectionViewDataSource()

@end

@implementation FilterCollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            [cell setFilterType:GTFilterTypeService currency:@"EUR" price:@"101.00"];
            break;
        case 1:
            [cell setFilterType:GTFilterTypeShuttle currency:@"EUR" price:@"111.00"];
            break;
        default:
            break;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTFilterCollectionViewCell *cell = (GTFilterCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.selectedFilter) {
        self.selectedFilter(cell.filterType);
    }
}

@end
