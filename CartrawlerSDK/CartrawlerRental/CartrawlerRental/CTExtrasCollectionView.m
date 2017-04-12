//
//  CTExtrasCollectionViewController.m
//  CartrawlerSDK
//
//  Created by Alan on 10/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTExtrasCollectionView.h"
#import "CTExtrasCollectionViewCell.h"
#import <CartrawlerAPI/CTExtraEquipment.h>
#import <CartrawlerSDK/CTLayoutManager.h>

NSInteger const kMaxExtras = 4;
NSInteger const kDefaultExtrasCountWhenIncludedInRate = 1;
CGFloat const kInteritemSpacing = 10.0;
CGFloat const kVerticalSectionInsets = 5.0;
CGFloat const kHorizontalSectionInsets = 15.0;
CGFloat const kHorizontalCellWidth = 220.0;
CGFloat const kHorizontalCellHeight = 100.0;
CGFloat const kVerticalCellHeight = 120.0;

@interface CTExtrasCollectionView () <CTExtrasCollectionViewCellDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;
@property (nonatomic, strong) NSArray *extras;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableIndexSet *flippedCards;
@end

@implementation CTExtrasCollectionView

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    self = [super init];
    if (self) {
        self.scrollDirection = scrollDirection;
        
        UICollectionViewFlowLayout *flowLayout = [self flowLayoutWithScrollDirection:scrollDirection];
        self.collectionView = [self collectionViewWithFlowLayout:flowLayout];
        [self addSubview:self.collectionView];
        [CTLayoutManager pinView:self.collectionView toSuperView:self];
        
        self.flippedCards = [NSMutableIndexSet new];
    }
    return self;
}

- (UICollectionViewFlowLayout *)flowLayoutWithScrollDirection:(UICollectionViewScrollDirection *)scrollDirection {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = scrollDirection;
    layout.minimumInteritemSpacing = kInteritemSpacing;
    layout.sectionInset = UIEdgeInsetsMake(kVerticalSectionInsets, kHorizontalSectionInsets, kVerticalSectionInsets, kHorizontalSectionInsets);
    return layout;
}

- (UICollectionView *)collectionViewWithFlowLayout:(UICollectionViewFlowLayout *)flowLayout {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [collectionView registerClass:[CTExtrasCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    collectionView.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    return collectionView;
}

- (void)updateWithExtras:(NSArray *)extras {
    self.extras = extras;
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.extras.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CTExtrasCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    CTExtraEquipment *extra = self.extras[indexPath.row];
    cell.titleLabel.text = extra.equipType;
    cell.detailLabel.text = [NSString stringWithFormat:@"€%@ for rental", extra.chargeAmount];
    cell.infoTitleLabel.text = extra.equipType;
    cell.infoDetailLabel.text = extra.equipDescription;
    
    BOOL decrementEnabled = (!extra.isIncludedInRate && extra.qty != 0);
    [cell setDecrementEnabled:decrementEnabled];
    
    BOOL incrementEnabled = (!extra.isIncludedInRate && extra.qty != kMaxExtras);
    [cell setIncrementEnabled:incrementEnabled];
    
    BOOL flipped = [self.flippedCards containsIndex:indexPath.row];
    [cell setFlippedState:flipped animated:NO];
    
    NSInteger count = extra.isIncludedInRate ? kDefaultExtrasCountWhenIncludedInRate : extra.qty;
    cell.countLabel.text = @(count).stringValue;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL horizontal = self.scrollDirection == UICollectionViewScrollDirectionHorizontal;
    return horizontal ? CGSizeMake(kHorizontalCellWidth, kHorizontalCellHeight) : CGSizeMake(self.collectionView.frame.size.width - kHorizontalSectionInsets * 2, kVerticalCellHeight);
}

// MARK: CTExtrasCollectionViewCellDelegate

- (void)cellDidTapInfo:(CTExtrasCollectionViewCell *)cell {
    NSInteger index = [self.collectionView indexPathForCell:cell].row;
    [self.flippedCards addIndex:index];
    [cell setFlippedState:YES animated:YES];
}

- (void)cellDidTapClose:(CTExtrasCollectionViewCell *)cell {
    NSInteger index = [self.collectionView indexPathForCell:cell].row;
    [self.flippedCards removeIndex:index];
    [cell setFlippedState:NO animated:YES];
}

- (void)cellDidTapDecrement:(CTExtrasCollectionViewCell *)cell {
    NSInteger index = [self.collectionView indexPathForCell:cell].row;
    CTExtraEquipment *extra = self.extras[index];
    extra.qty--;
    
    if (extra.qty == 0) {
        [cell setDecrementEnabled:NO];
    }
    [cell setIncrementEnabled:YES];
    
    cell.countLabel.text = @(extra.qty).stringValue;
}

- (void)cellDidTapIncrement:(CTExtrasCollectionViewCell *)cell {
    NSInteger index = [self.collectionView indexPathForCell:cell].row;
    CTExtraEquipment *extra = self.extras[index];
    extra.qty++;
    
    if (extra.qty == kMaxExtras) {
        [cell setIncrementEnabled:NO];
    }
    [cell setDecrementEnabled:YES];
    
    cell.countLabel.text = @(extra.qty).stringValue;
}

@end
