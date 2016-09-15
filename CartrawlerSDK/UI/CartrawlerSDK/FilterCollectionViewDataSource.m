//
//  FilterCollectionViewDataSource.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 09/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "FilterCollectionViewDataSource.h"
#import "CTSDKSettings.h"
#import "NSNumberUtils.h"

@interface FilterCollectionViewDataSource()

@end

@implementation FilterCollectionViewDataSource


- (NSNumber *)serviceLowestPrice
{
    NSMutableArray<CTGroundService *> *tempServices = [[NSMutableArray alloc] initWithArray:self.avail.services];
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"self.totalCharge" ascending:YES];
    [tempServices sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    return tempServices.firstObject.totalCharge ?: @0;
}

- (NSNumber *)shuttleLowestPrice
{
    NSMutableArray<CTGroundShuttle *> *tempShuttles = [[NSMutableArray alloc] initWithArray:self.avail.shuttles];
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"self.totalCharge" ascending:YES];
    [tempShuttles sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    return tempShuttles.firstObject.totalCharge ?: @0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.avail.shuttles.count > 0 && self.avail.services.count > 0) {
        return 2;
    } else {
        return 1;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (self.avail.shuttles.count > 0 && self.avail.services.count > 0) {
        switch (indexPath.row) {
            case 0:
                [cell setFilterType:GTFilterTypeService price:[NSNumberUtils numberStringWithCurrencyCode:[self serviceLowestPrice]]];
                break;
            case 1:
                [cell setFilterType:GTFilterTypeShuttle price:[NSNumberUtils numberStringWithCurrencyCode:[self shuttleLowestPrice]]];
                break;
            default:
                break;
        }
    } else if (self.avail.shuttles.count == 0 && self.avail.services.count > 0){
        [cell setFilterType:GTFilterTypeService price:[NSNumberUtils numberStringWithCurrencyCode:[self serviceLowestPrice]]];
    } else {
        [cell setFilterType:GTFilterTypeShuttle price:[NSNumberUtils numberStringWithCurrencyCode:[self shuttleLowestPrice]]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTFilterCollectionViewCell *cell = (GTFilterCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell animate];
    if (self.selectedFilter) {
        self.selectedFilter(cell.filterType);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    NSInteger cellCount = [collectionView.dataSource collectionView:collectionView numberOfItemsInSection:section];
    if( cellCount >0 )
    {
        CGFloat cellWidth = ((UICollectionViewFlowLayout*)collectionViewLayout).itemSize.width+((UICollectionViewFlowLayout*)collectionViewLayout).minimumInteritemSpacing;
        CGFloat totalCellWidth = cellWidth*cellCount;
        CGFloat contentWidth = collectionView.frame.size.width-collectionView.contentInset.left-collectionView.contentInset.right;
        if( totalCellWidth<contentWidth )
        {
            CGFloat padding = (contentWidth - totalCellWidth) / 2.0;
            return UIEdgeInsetsMake(0, padding, 0, padding);
        }
    }
    return UIEdgeInsetsZero;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat width = collectionView.frame.size.width;
//    return CGSizeMake(width/3, 85);
//}

@end
