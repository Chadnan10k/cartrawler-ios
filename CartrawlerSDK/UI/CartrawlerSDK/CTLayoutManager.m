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
@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *constraints;

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
    layoutManager.constraints = [NSMutableArray new];
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

- (void)insertViewAtIndex:(NSUInteger)index padding:(UIEdgeInsets)padding view:(UIView *)view
{
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.containerView addSubview:view];
        NSDictionary *viewDict = @{CTLayoutTopPaddingKey : [NSNumber numberWithDouble:padding.top ?: 0.0],
                                   CTLayoutBottomPaddingKey : [NSNumber numberWithDouble:padding.bottom ?: 0.0],
                                   CTLayoutLeftPaddingKey : [NSNumber numberWithFloat:padding.left ?: 0.0],
                                   CTLayoutRightPaddingKey : [NSNumber numberWithFloat:padding.right ?: 0.0],
                                   CTLayoutViewKey : view
                                   };
        
        [self undoConstraints];
        if (index < self.viewArray.count) {
            [self.viewArray insertObject:viewDict atIndex:index];
        } else {
            [self.viewArray insertObject:viewDict atIndex: self.viewArray.count == 0 ? 0 : self.viewArray.count-1];
        }
        [self layoutViews];
}

- (void)removeAtIndex:(NSUInteger)index
{
    [self.viewArray removeObjectAtIndex:index];
    [self undoConstraints];
    [self layoutViews];
}

- (void)undoConstraints
{
    [self.containerView removeConstraints:self.constraints];
}

- (void)layoutViews
{
    //we should remove any previous contraints
    
    if (self.viewArray.count < 2) {
        return;
    }
    
    for (int i=0; i < self.viewArray.count; i++) {
        
        UIView *currentView = [self viewForIndexInArray:i array:self.viewArray];
        UIEdgeInsets currentPadding = [self paddingForIndexInArray:i array:self.viewArray];
        
        if (i == 0) {
            UIView *nextView = [self viewForIndexInArray:i+1 array:self.viewArray];
            
            [self layoutView:currentView
                previousView:nil
                    nextView:nextView
                     padding:currentPadding
                   container:self.containerView
                 orientation:self.orientation
                     justify:self.justify];
        } else if (i == self.viewArray.count-1) {
            UIView *previousView = [self viewForIndexInArray:i-1 array:self.viewArray];
            
            [self layoutView:currentView
                previousView:previousView
                    nextView:nil
                     padding:currentPadding
                   container:self.containerView
                 orientation:self.orientation
                     justify:self.justify];
        } else {
            UIView *previousView = [self viewForIndexInArray:i-1 array:self.viewArray];
            UIView *nextView = [self viewForIndexInArray:i+1 array:self.viewArray];
            
            [self layoutView:currentView
                previousView:previousView
                    nextView:nextView
                     padding:currentPadding
                   container:self.containerView
                 orientation:self.orientation
                     justify:self.justify];
        }
    }
}

- (void)layoutView:(UIView *)subview
      previousView:(UIView *)previousView
          nextView:(UIView *)nextView
           padding:(UIEdgeInsets)padding
         container:(UIView *)container
       orientation:(CTLayoutManagerOrientation)orientation
           justify:(BOOL)justify
{
    NSDictionary *metrics = @{CTLayoutTopPaddingKey : @(padding.top),
                              CTLayoutBottomPaddingKey : @(padding.bottom),
                              CTLayoutLeftPaddingKey : @(padding.left),
                              CTLayoutRightPaddingKey : @(padding.right)};
    
    NSMutableDictionary *viewDict = [NSMutableDictionary new];
    NSMutableString *viewFormatV = [NSMutableString new];
    NSMutableString *viewFormatH = [NSMutableString new];
    
    [viewDict addEntriesFromDictionary:@{@"subview" : subview}];
    
    //V:
    if (previousView && orientation == CTLayoutManagerOrientationTopToBottom) {
        [viewDict addEntriesFromDictionary:@{@"previousView" : previousView}];
        NSString *justifyConstraint = justify ? @"(previousView)" : @"";
        NSString *verticalConstraints = [NSString stringWithFormat:@"V:[previousView]-topPadding-[subview%@]", justifyConstraint];
        [viewFormatV appendString:verticalConstraints];
    } else {
        [viewFormatV appendString:@"V:|-topPadding-[subview]"];
    }
    
    if (nextView && orientation == CTLayoutManagerOrientationTopToBottom) {
        [viewDict addEntriesFromDictionary:@{@"nextView" : nextView}];
        [viewFormatV appendString:@"-bottomPadding-[nextView]"];
    } else {
        [viewFormatV appendString:@"-bottomPadding-|"];
    }
    
    //H:
    if (previousView && orientation == CTLayoutManagerOrientationLeftToRight) {
        [viewDict addEntriesFromDictionary:@{@"previousView" : previousView}];
        NSString *justifyConstraint = justify ? @"(previousView)" : @"";
        NSString *horizontalConstraints = [NSString stringWithFormat:@"H:[previousView]-leftPadding-[subview%@]", justifyConstraint];
        [viewFormatH appendString:horizontalConstraints];
    } else {
        [viewFormatH appendString:@"H:|-leftPadding-[subview]"];
    }
    
    if (nextView && orientation == CTLayoutManagerOrientationLeftToRight) {
        [viewDict addEntriesFromDictionary:@{@"nextView" : nextView}];
        [viewFormatH appendString:@"-rightPadding-[nextView]"];
    } else {
        [viewFormatH appendString:@"-rightPadding-|"];
    }
    
    NSArray<NSLayoutConstraint *> *constraintsV = [NSLayoutConstraint constraintsWithVisualFormat:viewFormatV
                                                                                         options:0
                                                                                         metrics:metrics
                                                                                            views:viewDict];
    
    NSArray<NSLayoutConstraint *> *constraintsH = [NSLayoutConstraint constraintsWithVisualFormat:viewFormatH
                                                                                          options:0
                                                                                          metrics:metrics
                                                                                            views:viewDict];
    
    [self.constraints addObjectsFromArray:constraintsV];
    [self.constraints addObjectsFromArray:constraintsH];

    [container addConstraints:constraintsV];
    [container addConstraints:constraintsH];
    
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

- (nullable NSNumber *)indexOfObject:(id)object
{
    for (NSDictionary *d in self.viewArray) {
        if (d[CTLayoutViewKey] == object) {
            return @([self.viewArray indexOfObject:d]);
        }
    }
    return nil;
}

+ (void)pinView:(UIView *)view toSuperView:(UIView *)superview
{
    [self pinView:view toSuperView:superview padding:UIEdgeInsetsMake(0, 0, 0, 0)];
}

+ (void)pinView:(UIView *)view
    toSuperView:(UIView *)superview
        padding:(UIEdgeInsets)padding
 {
     NSDictionary *metrics = @{CTLayoutTopPaddingKey : @(padding.top),
                               CTLayoutBottomPaddingKey : @(padding.bottom),
                               CTLayoutLeftPaddingKey : @(padding.left),
                               CTLayoutRightPaddingKey : @(padding.right)};
     
     view.translatesAutoresizingMaskIntoConstraints = NO;
     [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftPadding-[view]-rightPadding-|"
                                                                       options:0
                                                                       metrics:metrics
                                                                         views:@{@"view" : view}]];
     [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topPadding-[view]-bottomPadding-|"
                                                                       options:0
                                                                       metrics:metrics
                                                                         views:@{@"view" : view}]];
}



@end
