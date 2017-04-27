//
//  CTCounterView.h
//  CartrawlerSDK
//
//  Created by Alan on 13/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTCounterView;

@protocol CTCounterViewDelegate <NSObject>

- (void)counterViewDidTapIncrement:(CTCounterView *)counterView;
- (void)counterViewDidTapDecrement:(CTCounterView *)counterView;

@end

@interface CTCounterView : UIView

@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, weak) id <CTCounterViewDelegate> delegate;

- (void)setIncrementEnabled:(BOOL)incrementEnabled;
- (void)setDecrementEnabled:(BOOL)decrementEnabled;

@end
