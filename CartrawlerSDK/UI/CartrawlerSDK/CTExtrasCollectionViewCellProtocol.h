//
//  CTExtrasCollectionViewCellProtocol.h
//  CartrawlerRental
//
//  Created by Alan on 13/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CTExtrasCollectionViewCellProtocol;

/**
 Delegate which is notified of extras cell events
 */
@protocol CTExtrasCollectionViewCellDelegate

- (void)cellDidTapDecrement:(id <CTExtrasCollectionViewCellProtocol>)cell;
- (void)cellDidTapIncrement:(id <CTExtrasCollectionViewCellProtocol>)cell;

@optional

- (void)cellDidTapInfo:(id <CTExtrasCollectionViewCellProtocol>)cell;
- (void)cellDidTapClose:(id <CTExtrasCollectionViewCellProtocol>)cell;

@end

/**
 Protocol for extras cell to conform to
 */
@protocol CTExtrasCollectionViewCellProtocol

- (void)setTitle:(NSString *)title;
- (void)setChargeAmount:(NSNumber *)chargeAmount;
- (void)setCount:(NSInteger)count;
- (void)setDetail:(NSString *)detail;
- (void)setDetailDisplayed:(BOOL)detailDisplayed animated:(BOOL)animated;
- (void)setIncrementEnabled:(BOOL)incrementEnabled;
- (void)setDecrementEnabled:(BOOL)decrementEnabled;

@property (nonatomic, weak) id <CTExtrasCollectionViewCellDelegate> delegate;
@end
