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
 Insert a view into the containerView at a certain index
 
 @param index The index in the view array
 @param padding The padding for the surrounding subviews
 @param view The view you want to insert
 */
- (void)insertViewAtIndex:(NSUInteger)index padding:(UIEdgeInsets)padding view:(UIView *)view;

/**
 Removes a view at a specific index

 @param index The index of the view array
 */
- (void)removeAtIndex:(NSUInteger)index;

/**
 Call this method when you want to apply the contraints to the inserted subviews
 */
- (void)layoutViews;


/**
 Get the index of an object in the view array

 @param object The object you want to check index for
 @return The index of the object
 */
- (nullable NSNumber *)indexOfObject:(id)object;

/**
 Convenience method to pin a view to a superview

 @param view a view
 @param superview a superview
 */
+ (void)pinView:(UIView *)view toSuperView:(UIView *)superview;

/**
 Convenience method to pin a view to a superview
 
 @param view a view
 @param superview a superview
 @param padding padding for the view
 */
+ (void)pinView:(UIView *)view
    toSuperView:(UIView *)superview
        padding:(UIEdgeInsets)padding;

@end
