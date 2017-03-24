//
//  CTLayoutManager.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CTLayoutManager : NSObject

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

- (void)layoutView:(UIView *)subview
           topView:(UIView *)topView
        bottomView:(UIView *)bottomView
          leftView:(UIView *)leftView
         rightView:(UIView *)rightView
           padding:(UIEdgeInsets)padding
         container:(UIView *)container;

@end
