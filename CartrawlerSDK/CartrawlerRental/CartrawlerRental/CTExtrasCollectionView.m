//
//  CTExtrasCollectionViewController.m
//  CartrawlerSDK
//
//  Created by Alan on 10/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTExtrasCollectionView.h"
#import "CTExtrasCollectionViewCell.h"
#import "CTExtrasListCollectionViewCell.h"
#import <CartrawlerAPI/CTExtraEquipment.h>
#import <CartrawlerSDK/CTLayoutManager.h>

NSInteger const kMaxExtras = 4;
NSInteger const kDefaultExtrasCountWhenIncludedInRate = 1;

CGFloat const kCarouselInteritemSpacing = 10.0;
CGFloat const kCarouselVerticalSectionInsets = 0;
CGFloat const kCarouselHorizontalSectionInsets = 15.0;
CGFloat const kCarouselCellWidth = 220.0;
CGFloat const kCarouselCellHeight = 100.0;

CGFloat const kListCellHeight = 80.0;
CGFloat const kListCellHeightExpanded = 160.0;

@interface CTExtrasCollectionView () <CTExtrasCollectionViewCellDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;
@property (nonatomic, strong) NSArray *extras;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableIndexSet *indexesOfCellsWithDetailDisplayed;
@end

@implementation CTExtrasCollectionView

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    self = [super init];
    if (self) {
        self.scrollDirection = scrollDirection;
        self.collectionView =  [self collectionViewForScrollDirection:scrollDirection];
        [self addSubview:self.collectionView];
        [CTLayoutManager pinView:self.collectionView toSuperView:self];
        
        self.indexesOfCellsWithDetailDisplayed = [NSMutableIndexSet new];
    }
    return self;
}

// MARK: Collection View

- (UICollectionView *)collectionViewForScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    UICollectionView *collectionView = scrollDirection == UICollectionViewScrollDirectionHorizontal ? [self horizontalCollectionView] : [self verticalCollectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    return collectionView;
}

- (UICollectionView *)horizontalCollectionView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = kCarouselInteritemSpacing;
    layout.sectionInset = UIEdgeInsetsMake(kCarouselVerticalSectionInsets, kCarouselHorizontalSectionInsets, kCarouselVerticalSectionInsets, kCarouselHorizontalSectionInsets);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectionView registerClass:[CTExtrasCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    collectionView.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
    collectionView.showsHorizontalScrollIndicator = NO;
    
    return collectionView;
}

- (UICollectionView *)verticalCollectionView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectionView registerClass:[CTExtrasListCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    collectionView.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
    
    return collectionView;
}

//- (UICollectionViewFlowLayout *)flowLayoutWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
//    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//    layout.scrollDirection = scrollDirection;
//    layout.minimumInteritemSpacing = kInteritemSpacing;
//    layout.minimumLineSpacing = 0;
//    CGFloat horizontalSpacing = (scrollDirection == UICollectionViewScrollDirectionVertical) ? 0 : kHorizontalSectionInsets;
//    CGFloat verticalSpacing = (scrollDirection == UICollectionViewScrollDirectionVertical) ? 0 : kVerticalSectionCarouselInsets;
//    layout.sectionInset = UIEdgeInsetsMake(verticalSpacing, horizontalSpacing, verticalSpacing, horizontalSpacing);
//    return layout;
//}



//- (UICollectionView *)collectionViewWithFlowLayout:(UICollectionViewFlowLayout *)flowLayout {
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//    if (flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
//        [collectionView registerClass:[CTExtrasCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    } else {
//        [collectionView registerClass:[CTExtrasListCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    }
//    
//    collectionView.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
//    collectionView.delegate = self;
//    collectionView.dataSource = self;
//    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
//    collectionView.showsHorizontalScrollIndicator = NO;
//    return collectionView;
//}

- (void)updateWithExtras:(NSArray *)extras {
    self.extras = extras;
    [self.collectionView reloadData];
}

// MARK: <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.extras.count;
}

- (UICollectionViewCell <CTExtrasCollectionViewCellProtocol> *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell <CTExtrasCollectionViewCellProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    CTExtraEquipment *extra = self.extras[indexPath.row];
    cell.title = extra.equipDescription;
    // To be localised
    cell.chargeAmount = extra.chargeAmount;
    cell.detail = @"Extras will be paid for at desk";
    
    BOOL decrementEnabled = (!extra.isIncludedInRate && extra.qty != 0);
    [cell setDecrementEnabled:decrementEnabled];
    
    BOOL incrementEnabled = (!extra.isIncludedInRate && extra.qty != kMaxExtras);
    [cell setIncrementEnabled:incrementEnabled];
    
    BOOL detailDisplayed = [self.indexesOfCellsWithDetailDisplayed containsIndex:indexPath.row];
    [cell setDetailDisplayed:detailDisplayed animated:NO];
    
    NSInteger count = extra.isIncludedInRate ? kDefaultExtrasCountWhenIncludedInRate : extra.qty;
    [cell setCount:count];
    
    return cell;
}

// MARK: UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        return CGSizeMake(kCarouselCellWidth, kCarouselCellHeight);
    }
    
    CGFloat height = [self.indexesOfCellsWithDetailDisplayed containsIndex:indexPath.row] ? kListCellHeightExpanded : kListCellHeight;
    return CGSizeMake(self.collectionView.frame.size.width, height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        return;
    }
    
    if ([self.indexesOfCellsWithDetailDisplayed containsIndex:indexPath.row]) {
        [self.indexesOfCellsWithDetailDisplayed removeIndex:indexPath.row];
    } else {
        [self.indexesOfCellsWithDetailDisplayed addIndex:indexPath.row];
    }
    
    [collectionView performBatchUpdates:nil completion:nil];
}

// MARK: CTExtrasCollectionViewCellDelegate

- (void)cellDidTapInfo:(CTExtrasCollectionViewCell *)cell {
    NSInteger index = [self.collectionView indexPathForCell:cell].row;
    [self.indexesOfCellsWithDetailDisplayed addIndex:index];
    [cell setDetailDisplayed:YES animated:YES];
}

- (void)cellDidTapClose:(CTExtrasCollectionViewCell *)cell {
    NSInteger index = [self.collectionView indexPathForCell:cell].row;
    [self.indexesOfCellsWithDetailDisplayed removeIndex:index];
    [cell setDetailDisplayed:NO animated:YES];
}

- (void)cellDidTapIncrement:(CTExtrasCollectionViewCell *)cell {
    NSInteger index = [self.collectionView indexPathForCell:cell].row;
    CTExtraEquipment *extra = self.extras[index];
    
    if (extra.qty < kMaxExtras) {
        extra.qty++;
        [cell setDecrementEnabled:YES];
        cell.count = extra.qty;
    }
    
    if (extra.qty == kMaxExtras) {
        [cell setIncrementEnabled:NO];
    }
}

- (void)cellDidTapDecrement:(CTExtrasCollectionViewCell *)cell {
    NSInteger index = [self.collectionView indexPathForCell:cell].row;
    CTExtraEquipment *extra = self.extras[index];
    
    if (extra.qty > 0) {
        extra.qty--;
        [cell setIncrementEnabled:YES];
        cell.count = extra.qty;
    }
    
    if (extra.qty == 0) {
        [cell setDecrementEnabled:NO];
    }
}

@end
