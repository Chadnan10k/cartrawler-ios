//
//  CTExtrasCollectionViewCell.h
//  CartrawlerSDK
//
//  Created by Alan on 10/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerSDK/CTLabel.h>

@class CTExtrasCollectionViewCell;

/**
 Delegate which is notified of cell events
 */
@protocol CTExtrasCollectionViewCellDelegate

- (void)cellDidTapInfo:(CTExtrasCollectionViewCell *)cell;
- (void)cellDidTapDecrement:(CTExtrasCollectionViewCell *)cell;
- (void)cellDidTapIncrement:(CTExtrasCollectionViewCell *)cell;
- (void)cellDidTapClose:(CTExtrasCollectionViewCell *)cell;

@end

/**
 Cell which displays extras info
 */
@interface CTExtrasCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) CTLabel *titleLabel;
@property (nonatomic, strong) CTLabel *detailLabel;
@property (nonatomic, strong) CTLabel *countLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) CTLabel *infoTitleLabel;
@property (nonatomic, strong) CTLabel *infoDetailLabel;
@property (nonatomic, weak) id <CTExtrasCollectionViewCellDelegate> delegate;

- (void)setFlippedState:(BOOL)flipped animated:(BOOL)animated;
- (void)setIncrementEnabled:(BOOL)incrementEnabled;
- (void)setDecrementEnabled:(BOOL)decrementEnabled;

@end
