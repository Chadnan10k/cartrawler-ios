//
//  CTTabView.h
//  CartrawlerSDK
//
//  Created by Alan on 22/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 A view with a title label and a baseline
 */
@interface CTTabView : UIView

@property (nonatomic, readonly) UILabel *titleLabel;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong) UIColor *selectedTextColor;

@property (nonatomic, strong) UIColor *deselectedTextColor;

@property (nonatomic, strong) UIColor *selectedLineColor;

@property (nonatomic, strong) UIColor *deselectedLineColor;

@end
