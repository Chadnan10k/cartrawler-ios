//
//  CTLayoutManager.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTLayoutManager.h"

@interface CTLayoutManager()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *viewArray;

@end

@implementation CTLayoutManager

NSString *const CTLayoutViewKey = @"view";
NSString *const CTLayoutTopPaddingKey = @"topPadding";
NSString *const CTLayoutBottomPaddingKey = @"bottomPadding";
NSString *const CTLayoutLeftPaddingKey = @"leftPadding";
NSString *const CTLayoutRightPaddingKey = @"rightPadding";

+ (instancetype)layoutManagerWithContainer:(UIView *)containerView
{
    CTLayoutManager *layoutManager = [CTLayoutManager new];
    layoutManager.viewArray = [NSMutableArray new];
    layoutManager.containerView = containerView;
    return layoutManager;
}

- (void)insertView:(UIEdgeInsets)padding view:(UIView *)view
{
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:view];
    NSDictionary *viewDict = @{CTLayoutTopPaddingKey : [NSNumber numberWithDouble:padding.top ?: 0.0],
                               CTLayoutBottomPaddingKey : [NSNumber numberWithDouble:padding.bottom ?: 0.0],
                               CTLayoutLeftPaddingKey : [NSNumber numberWithFloat:padding.left ?: 0.0],
                               CTLayoutRightPaddingKey : [NSNumber numberWithFloat:padding.right ?: 0.0],
                               CTLayoutViewKey : view
                               };
    
    [self.viewArray addObject:viewDict];
}

- (void)layoutViews
{
    
    //we should remove any previous contraints
    
    if (self.viewArray.count < 2) {
        NSLog(@"Not enough views for CTLayoutManager to layout");
        return;
    }
    
    for (int i=0; i < self.viewArray.count; i++) {
        
        UIView *currentView = [self viewForIndexInArray:i array:self.viewArray];
        UIEdgeInsets currentPadding = [self paddingForIndexInArray:i array:self.viewArray];
        
        if (i == 0) {
            //layout top
            UIView *nextView = [self viewForIndexInArray:i+1 array:self.viewArray];
            [self layoutView:currentView
                     topView:nil
                  bottomView:nextView
                    leftView:nil
                   rightView:nil
                     padding:currentPadding
                   container:self.containerView];
        } else if (i == self.viewArray.count -1) {
            //layout bottom
            UIView *previousView = [self viewForIndexInArray:i-1 array:self.viewArray];
            [self layoutView:currentView
                     topView:previousView
                  bottomView:nil
                    leftView:nil
                   rightView:nil
                     padding:currentPadding
                   container:self.containerView];
        } else {
            //layout middle
            UIView *previousView = [self viewForIndexInArray:i-1 array:self.viewArray];
            UIView *nextView = [self viewForIndexInArray:i+1 array:self.viewArray];
            [self layoutView:currentView
                     topView:previousView
                  bottomView:nextView
                    leftView:nil
                   rightView:nil
                     padding:currentPadding
                   container:self.containerView];
        }
    }
}

- (void)layoutView:(UIView *)subview
           topView:(UIView *)topView
        bottomView:(UIView *)bottomView
          leftView:(UIView *)leftView
         rightView:(UIView *)rightView
           padding:(UIEdgeInsets)padding
         container:(UIView *)container
{
    //if a view is nil we attach the view to the superview
    
    NSDictionary *metrics = @{CTLayoutTopPaddingKey : @(padding.top),
                              CTLayoutBottomPaddingKey : @(padding.bottom),
                              CTLayoutLeftPaddingKey : @(padding.left),
                              CTLayoutRightPaddingKey : @(padding.right)};
    
    NSMutableDictionary *viewDict = [NSMutableDictionary new];
    NSMutableString *viewFormatV = [NSMutableString new];
    NSMutableString *viewFormatH = [NSMutableString new];

    [viewDict addEntriesFromDictionary:@{@"subview" : subview}];
    
    //V:
    if (topView) {
        [viewDict addEntriesFromDictionary:@{@"top" : topView}];
        [viewFormatV appendString:@"V:[top]-topPadding-[subview]"];
    } else {
        [viewFormatV appendString:@"V:|-topPadding-[subview]"];
    }
    
    if (bottomView) {
        [viewDict addEntriesFromDictionary:@{@"bottom" : bottomView}];
        [viewFormatV appendString:@"-bottomPadding-[bottom]"];
    } else {
        [viewFormatV appendString:@"-bottomPadding-|"];
    }
    
    //H:
    if (leftView) {
        [viewDict addEntriesFromDictionary:@{@"left" : leftView}];
        [viewFormatH appendString:@"H:[left]-leftPadding-[subview]"];
    } else {
        [viewFormatH appendString:@"H:|-leftPadding-[subview]"];
    }
    
    if (rightView) {
        [viewDict addEntriesFromDictionary:@{@"right" : rightView}];
        [viewFormatH appendString:@"-rightPadding-[right]"];
    } else {
        [viewFormatH appendString:@"-rightPadding-|"];
    }

    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:viewFormatV
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewDict]];
    
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:viewFormatH
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewDict]];
    
}

/**
 Returns padding in the view array

 @param index Index of the array
 @param array The array you want to search
 @return UIEdgeInsets
 */
- (UIEdgeInsets)paddingForIndexInArray:(int)index array:(NSArray *)array
{
    NSDictionary *currentDict = self.viewArray[index];
    UIEdgeInsets currentPadding = UIEdgeInsetsMake(((NSNumber *)currentDict[CTLayoutTopPaddingKey]).doubleValue,
                                                   ((NSNumber *)currentDict[CTLayoutLeftPaddingKey]).doubleValue,
                                                   ((NSNumber *)currentDict[CTLayoutBottomPaddingKey]).doubleValue,
                                                   ((NSNumber *)currentDict[CTLayoutRightPaddingKey]).doubleValue);
    return currentPadding;
}

/**
 View for index in array

 @param index Index of the array
 @param array The array you want to search
 @return UIView
 */
- (UIView *)viewForIndexInArray:(int)index array:(NSArray *)array
{
    NSDictionary *currentDict = self.viewArray[index];
    UIView *view = currentDict[CTLayoutViewKey];
    return view;
}

@end
