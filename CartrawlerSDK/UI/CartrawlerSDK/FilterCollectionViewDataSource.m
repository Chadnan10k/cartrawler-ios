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
                [cell setFilterType:GTFilterTypeService price:[NSNumberUtils numberStringWithCurrencyCode:[self serviceLowestPrice]] imageURL:self.avail.services.firstObject.vehicleImage];
                break;
            case 1:
                [cell setFilterType:GTFilterTypeShuttle price:[NSNumberUtils numberStringWithCurrencyCode:[self shuttleLowestPrice]] imageURL:self.avail.shuttles.firstObject.vehicleImage];
                break;
            default:
                break;
        }
    } else if (self.avail.shuttles.count == 0 && self.avail.services.count > 0){
        [cell setFilterType:GTFilterTypeService price:[NSNumberUtils numberStringWithCurrencyCode:[self serviceLowestPrice]] imageURL:self.avail.services.firstObject.vehicleImage];
    } else {
        [cell setFilterType:GTFilterTypeShuttle price:[NSNumberUtils numberStringWithCurrencyCode:[self shuttleLowestPrice]] imageURL:self.avail.shuttles.firstObject.vehicleImage];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (GTFilterCollectionViewCell *cell in collectionView.visibleCells) {
        [cell deselect];
    }
    
    GTFilterCollectionViewCell *cell = (GTFilterCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell animate];
    if (self.selectedFilter) {
        self.selectedFilter(cell.filterType);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    CGFloat cellWidth = 120;
    if (self.avail.shuttles.count > 0 && self.avail.services.count > 0) {
        cellWidth = 240;
    } else {
        cellWidth = 120;
    }
    CGFloat cellSpacing = 16;
    
    CGFloat inset = (collectionView.frame.size.width - (cellWidth + cellSpacing)) / 2;
    
    return UIEdgeInsetsMake(8, inset, 0, inset);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(120, 90);
}

@end
