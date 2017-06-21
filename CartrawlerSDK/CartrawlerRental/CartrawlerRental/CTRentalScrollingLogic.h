//
//  CTRentalScrollingLogic.h
//  CartrawlerRental
//
//  Created by Alan on 22/05/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Provides logic for pinning a top view above a scroll view
 Top view will disappear off screen on upwards scroll and reappear as soon as downward scroll commences
 */
@interface CTRentalScrollingLogic : NSObject

/**
 Designated initialiser

 @param height the height of the top view
 @return a CTRentalScrollingLogic object
 */
- (instancetype)initWithTopViewHeight:(CGFloat)height;

/**
 Use this method to calculate the top offset of the top view

 @param desiredOffset the scroll view offset
 @param currentOffset the current top view offset
 @return the calculated top offset
 */
- (CGFloat)offsetForDesiredOffset:(CGFloat)desiredOffset currentOffset:(CGFloat)currentOffset;

@end
