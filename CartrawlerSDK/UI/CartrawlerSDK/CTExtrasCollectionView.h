//
//  CTExtrasCollectionView.h
//  CartrawlerSDK
//
//  Created by Alan on 10/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTExtraEquipment.h>

@protocol CTExtrasCollectionViewDelegate
/**
 Delegate which informs which cell index has been scrolled to

 @param index the index that has been scrolled to
 */
- (void)collectionViewDidScrollToIndex:(NSInteger)index;
@end

/**
 A view which manages a collection view of CTExtrasCollectionViewCells
 */
@interface CTExtrasCollectionView : UIView

/**
 Designated initialiser

 @param scrollDirection the required scroll direction
 @return a CTExtrasCollectionView instance
 */
- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection;

/**
 Pass in extras objects to have the collection view update

 @param extras an array of CTExtraEquipment objects
 */
- (void)updateWithExtras:(NSArray<CTExtraEquipment *> *)extras;

@property (nonatomic, weak) id <CTExtrasCollectionViewDelegate> delegate;

@end
