//
//  CTPickerView.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/InsuranceSelectorItem.h>

@protocol CTPickerViewDelegate <NSObject>

- (void)pickerViewDidSelectItem:(InsuranceSelectorItem *)item;

@end

@interface CTPickerView : UIPickerView

@property (nonatomic) BOOL isVisible;

@property (weak, nonatomic) id<CTPickerViewDelegate> pickerDelegate;

- (void)presentInView:(UIView *)view data:(NSArray<InsuranceSelectorItem *> *)data;

- (void)removeFromView;

+ (void)forceLinkerLoad_;

@end
