//
//  CTPickerView.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTInsuranceSelectorItem.h>

@protocol CTPickerViewDelegate <NSObject>

- (void)pickerViewDidSelectItem:(CTInsuranceSelectorItem *)item;

@end

@interface CTPickerView : UIPickerView

@property (nonatomic) BOOL isVisible;

@property (weak, nonatomic) id<CTPickerViewDelegate> pickerDelegate;

- (void)presentInView:(UIView *)view data:(NSArray<CTInsuranceSelectorItem *> *)data;

- (void)removeFromView;

@end
