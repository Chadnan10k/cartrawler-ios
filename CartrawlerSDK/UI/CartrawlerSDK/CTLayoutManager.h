//
//  CTLayoutManager.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CTLayoutManagerOrientation) {
    CTLayoutManagerOrientationTopToBottom,
    CTLayoutManagerOrientationLeftToRight
};

@interface CTLayoutManager : NSObject

/**
 Defines the layout orientation. Default is CTLayoutManagerOrientationTopToBottom
 */
@property (nonatomic, assign) CTLayoutManagerOrientation orientation;

/**
 Optional flag to specify whether views should be laid out with equal widths/heights
 */
@property (nonatomic, assign) BOOL justify;

/**
 Designated initialiser

 @param containerView The superview in which the inserted subviews will lie
 @return CTLayoutManager
 */
+ (instancetype)layoutManagerWithContainer:(UIView *)containerView;

/**
 Insert a view into the containerView

 @param padding The padding for the surrounding subviews
 @param view The view you want to insert
 */
- (void)insertView:(UIEdgeInsets)padding view:(UIView *)view;

/**
 Call this method when you want to apply the contraints to the inserted subviews
 */
- (void)layoutViews;

/**
 Convenience method to pin a view to a superview

 @param view a view
 @param superview a superview
 */
+ (void)pinView:(UIView *)view toSuperView:(UIView *)superview;

@end
